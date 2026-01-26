package com.tianji.search.repository.impl;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.*;
import co.elastic.clients.elasticsearch.core.bulk.BulkOperation;
import co.elastic.clients.elasticsearch.core.bulk.BulkResponseItem;
import co.elastic.clients.elasticsearch.core.bulk.IndexOperation;
import co.elastic.clients.elasticsearch.core.bulk.DeleteOperation;
import co.elastic.clients.elasticsearch.core.bulk.UpdateOperation;
import co.elastic.clients.elasticsearch._types.Script;
import co.elastic.clients.json.JsonData;
import com.tianji.search.domain.po.Course;
import com.tianji.search.repository.CourseRepository;
import com.tianji.common.exceptions.CommonException;
import com.tianji.common.utils.JsonUtils;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static com.tianji.search.constants.SearchErrorInfo.*;

@Slf4j
@Component
public class CourseRepositoryImpl implements CourseRepository {

    @Resource
    private ElasticsearchClient elasticsearchClient;

    @Override
    public void save(Course course) {
        try {
            IndexRequest<Object> request = IndexRequest.of(i -> i
                    .index(INDEX_NAME)
                    .id(course.getId().toString())
                    .withJson(new StringReader(JsonUtils.toJsonStr(course)))
            );
            elasticsearchClient.index(request);
        } catch (Exception e) {
            throw new CommonException(SAVE_COURSE_ERROR, e);
        }
    }

    @Override
    public void deleteById(Long courseId) {
        try {
            DeleteRequest request = DeleteRequest.of(d -> d
                    .index(INDEX_NAME)
                    .id(courseId.toString())
            );
            elasticsearchClient.delete(request);
        } catch (Exception e) {
            throw new CommonException(SAVE_COURSE_ERROR, e);
        }
    }

    @Override
    public Optional<Course> findById(Long courseId) {
        try {
            GetRequest request = GetRequest.of(g -> g
                    .index(INDEX_NAME)
                    .id(courseId.toString())
            );
            GetResponse<Course> response = elasticsearchClient.get(request, Course.class);
            if (!response.found()) {
                return Optional.empty();
            }
            if (response.source() != null) {
                return Optional.of(response.source());
            }
        } catch (Exception e) {
            throw new CommonException(QUERY_COURSE_ERROR, e);
        }
        return Optional.empty();
    }

    @Override
    public void updateById(Long courseId, Object... sources) {
        try {
            // 将 sources 转换为 Map
            Map<String, Object> doc = new HashMap<>();
            for (int i = 0; i < sources.length; i += 2) {
                if (i + 1 < sources.length) {
                    doc.put(sources[i].toString(), sources[i + 1]);
                }
            }
            
            UpdateRequest<Course, Object> request = UpdateRequest.of(u -> u
                    .index(INDEX_NAME)
                    .id(courseId.toString())
                    .doc(doc)
            );
            elasticsearchClient.update(request, Course.class);
        } catch (Exception e) {
            throw new CommonException(UPDATE_COURSE_STATUS_ERROR, e);
        }
    }

    @Override
    public void increment(Long courseId, String field, int amount) {
        try {
            String code = "ctx._source." + field + " += params.count";
            Map<String, JsonData> params = new HashMap<>();
            params.put("count", JsonData.of(amount));
            
            Script script = Script.of(s -> s
                    .inline(i -> i
                            .source(code)
                            .params(params)
                    )
            );
            
            UpdateRequest<Course, Object> request = UpdateRequest.of(u -> u
                    .index(INDEX_NAME)
                    .id(courseId.toString())
                    .script(script)
            );
            elasticsearchClient.update(request, Course.class);
        } catch (Exception e) {
            throw new CommonException(UPDATE_COURSE_STATUS_ERROR, e);
        }
    }

    @Override
    public void incrementSold(List<Long> courseIds, int amount) {
        try {
            List<BulkOperation> operations = new ArrayList<>();
            
            for (Long courseId : courseIds) {
                Map<String, JsonData> params = new HashMap<>();
                params.put(INCREMENT_SOLD_SCRIPT_PARAM, JsonData.of(amount));
                
                // 创建内联脚本而不是存储脚本
                String scriptSource = "ctx._source.sold += params.count";
                
                Script script = Script.of(s -> s
                        .inline(i -> i
                                .source(scriptSource)
                                .params(params)
                        )
                );
                
                // 直接使用 UpdateOperation 构建批量操作
                BulkOperation operation = BulkOperation.of(b -> b
                        .update(UpdateOperation.of(u -> u
                                .index(INDEX_NAME)
                                .id(courseId.toString())
                                .action(a -> a.script(script))
                        ))
                );
                operations.add(operation);
            }
            
            BulkRequest bulkRequest = BulkRequest.of(b -> b
                    .operations(operations)
            );
            
            elasticsearchClient.bulk(bulkRequest);
        } catch (Exception e) {
            throw new CommonException(UPDATE_COURSE_STATUS_ERROR, e);
        }
    }

    @Override
    public void saveAll(List<Course> list) {
        try {
            List<BulkOperation> operations = new ArrayList<>();
            
            for (Course course : list) {
                BulkOperation operation = BulkOperation.of(b -> b
                        .index(IndexOperation.of(i -> i
                                .index(INDEX_NAME)
                                .id(course.getId().toString())
                                .document(course)
                        ))
                );
                operations.add(operation);
            }
            
            BulkRequest bulkRequest = BulkRequest.of(b -> b
                    .operations(operations)
            );
            
            process(bulkRequest);
        } catch (Exception e) {
            throw new CommonException(SAVE_COURSE_ERROR, e);
        }
    }

    private void process(BulkRequest request) {
        try {
            BulkResponse bulkResponse = elasticsearchClient.bulk(request);
            for (BulkResponseItem itemResponse : bulkResponse.items()) {
                if (itemResponse.error() != null) {
                    log.error("批处理失败，id:{}, 原因:{}", itemResponse.id(), itemResponse.error().reason());
                }
            }
        } catch (Exception e) {
            throw new CommonException(SAVE_COURSE_ERROR, e);
        }
    }

    @Override
    public void deleteByIds(List<Long> courseIds) {
        try {
            List<BulkOperation> operations = new ArrayList<>();
            
            for (Long courseId : courseIds) {
                BulkOperation operation = BulkOperation.of(b -> b
                        .delete(DeleteOperation.of(d -> d
                                .index(INDEX_NAME)
                                .id(courseId.toString())
                        ))
                );
                operations.add(operation);
            }
            
            BulkRequest bulkRequest = BulkRequest.of(b -> b
                    .operations(operations)
            );
            
            process(bulkRequest);
        } catch (Exception e) {
            throw new CommonException(SAVE_COURSE_ERROR, e);
        }
    }
}
