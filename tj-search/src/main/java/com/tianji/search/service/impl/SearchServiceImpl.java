package com.tianji.search.service.impl;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.SortOrder;
import co.elastic.clients.elasticsearch._types.FieldValue;
import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery;
import co.elastic.clients.elasticsearch.core.SearchRequest;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;
import co.elastic.clients.json.JsonData;
import com.tianji.api.client.user.UserClient;
import com.tianji.api.dto.user.UserDTO;
import com.tianji.api.utils.UserUtils;
import com.tianji.common.domain.dto.PageDTO;
import com.tianji.common.exceptions.CommonException;
import com.tianji.common.utils.*;
import com.tianji.search.config.InterestsProperties;
import com.tianji.search.constants.SearchErrorInfo;
import com.tianji.search.domain.po.Course;
import com.tianji.search.domain.query.CoursePageQuery;
import com.tianji.search.domain.vo.CourseVO;
import com.tianji.search.repository.CourseRepository;
import com.tianji.search.service.IInterestsService;
import com.tianji.search.service.ISearchService;
import jakarta.annotation.Resource;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.checkerframework.checker.nullness.qual.NonNull;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

import static com.tianji.search.repository.CourseRepository.PUBLISH_TIME;

@Service
@RequiredArgsConstructor
public class SearchServiceImpl implements ISearchService {
    @Resource
    private ElasticsearchClient elasticsearchClient;
    private final IInterestsService interestsService;
    @Resource
    private UserClient userClient;

    private final InterestsProperties interestsProperties;

    @Override
    public List<CourseVO> queryCourseByCateId(Long cateLv2Id) {
        return queryTopNByCategoryIdLv2sAndFree(
                CollUtils.singletonList(cateLv2Id), null, PUBLISH_TIME, 10);
    }

    @Override
    public List<CourseVO> queryBestTopN() {
        // 1.获取当前用户
        return queryTopNCourseOnMarketByFree(false, CourseRepository.SOLD);
    }

    @Override
    public List<CourseVO> queryNewTopN() {
        return queryTopNCourseOnMarketByFree(false, PUBLISH_TIME);
    }

    @Override
    public List<CourseVO> queryFreeTopN() {
        return queryTopNCourseOnMarketByFree(true, CourseRepository.SOLD);
    }

    private List<CourseVO> queryTopNCourseOnMarketByFree(boolean isFree, String sortBy) {
        // 1.获取当前用户
        Long id = UserContext.getUser();
        // 2.查询课程
        List<CourseVO> courses;
        if (id == null) {
            // 3.未登录，直接查询报名人数最多的
            courses = queryTopNByCategoryIdLv2sAndFree(
                    null, isFree, sortBy, interestsProperties.getTopNumber());
        } else {
            // 4.已登录，根据兴趣爱好查询
            List<Long> categoryIds = interestsService.queryMyInterestsIds();
            if (CollUtils.isEmpty(categoryIds)) {
                // 4.1.没有兴趣爱好，直接查询报名人数最多的
                courses = queryTopNByCategoryIdLv2sAndFree(
                        null, isFree, sortBy, interestsProperties.getTopNumber());
            } else {
                // 4.2.有爱好.查询爱好课程中报名人数最多的
                courses = queryTopNByCategoryIdLv2sAndFree(
                        categoryIds, isFree, sortBy, interestsProperties.getTopNumber());
            }
        }
        return courses;
    }

    private List<CourseVO> queryTopNByCategoryIdLv2sAndFree(
            List<Long> categoryIds, Boolean isFree, String sortBy, int n) {
        try {
            // 1.构建查询
            BoolQuery.Builder queryBuilder = getQueryBuilder(categoryIds, isFree);

            // 2.创建搜索请求
            SearchRequest.Builder requestBuilder = new SearchRequest.Builder()
                    .index(CourseRepository.INDEX_NAME)
                    .size(n)
                    .sort(s -> s.field(f -> f.field(sortBy).order(SortOrder.Desc)));
            
            // 设置查询条件（如果有的话）
            if (isFree != null || (categoryIds != null && !categoryIds.isEmpty())) {
                requestBuilder.query(queryBuilder.build()._toQuery());
            }
            
            // 3.执行搜索
            SearchResponse<CourseVO> response = elasticsearchClient.search(requestBuilder.build(), CourseVO.class);
            
            // 4.解析结果
            List<Hit<CourseVO>> hits = response.hits().hits();
            if (hits == null || hits.isEmpty()) {
                return CollUtils.emptyList();
            }
            
            List<CourseVO> courses = new ArrayList<>(hits.size());
            Set<Long> teacherIds = new HashSet<>(hits.size());
            for (Hit<CourseVO> hit : hits) {
                // 4.1.数据转换
                CourseVO vo = hit.source();
                if (vo == null) continue;
                
                // 4.2.获取分类id
                teacherIds.add(Long.valueOf(vo.getTeacher()));
                courses.add(vo);
            }
            
            // 5.查询教师信息
            if (!teacherIds.isEmpty()) {
                List<UserDTO> teachers = userClient.queryUserByIds(teacherIds);
                if (CollUtils.isNotEmpty(teachers)) {
                    Map<Long, String> teacherMap = teachers.stream()
                            .collect(Collectors.toMap(UserDTO::getId, UserDTO::getName));
                    for (CourseVO course : courses) {
                        course.setTeacher(teacherMap.get(Long.valueOf(course.getTeacher())));
                    }
                }
            }
            return courses;
            
        } catch (Exception e) {
            throw new CommonException(SearchErrorInfo.QUERY_COURSE_ERROR, e);
        }
    }

    private static BoolQuery.@NonNull Builder getQueryBuilder(List<Long> categoryIds, Boolean isFree) {
        BoolQuery.Builder queryBuilder = new BoolQuery.Builder();

        // 1.1.是否免费过滤
        if (isFree != null) {
            queryBuilder.filter(f -> f.term(t -> t.field(CourseRepository.FREE).value(isFree)));
        }

        // 1.2.分类id过滤
        if (categoryIds != null && !categoryIds.isEmpty()) {
            if (categoryIds.size() == 1) {
                queryBuilder.filter(f -> f.term(t -> t.field(CourseRepository.CATEGORY_ID_LV2).value(categoryIds.getFirst())));
            } else {
                List<FieldValue> categoryValues = categoryIds.stream().map(FieldValue::of).collect(Collectors.toList());
                queryBuilder.filter(f -> f.terms(t -> t.field(CourseRepository.CATEGORY_ID_LV2).terms(ts -> ts.value(categoryValues))));
            }
        }
        return queryBuilder;
    }

    @Override
    public PageDTO<CourseVO> queryCoursesForPortal(CoursePageQuery query) {
        try {
            // 1.构建查询
            BoolQuery.Builder queryBuilder = new BoolQuery.Builder();
            
            // 1.1.关键字搜索
            String keyword = query.getKeyword();
            if (StringUtils.isBlank(keyword)) {
                queryBuilder.must(m -> m.matchAll(ma -> ma));
            } else {
                queryBuilder.must(m -> m.matchPhrase(mp -> mp
                        .field(CourseRepository.DEFAULT_QUERY_NAME)
                        .query(keyword)
                ));
            }
            
            // 1.2.其他条件过滤
            if (query.getCategoryIdLv1() != null) {
                queryBuilder.filter(f -> f.term(t -> t.field(CourseRepository.CATEGORY_ID_LV1).value(query.getCategoryIdLv1())));
            }
            if (query.getCategoryIdLv2() != null) {
                queryBuilder.filter(f -> f.term(t -> t.field(CourseRepository.CATEGORY_ID_LV2).value(query.getCategoryIdLv2())));
            }
            if (query.getCategoryIdLv3() != null) {
                queryBuilder.filter(f -> f.term(t -> t.field(CourseRepository.CATEGORY_ID_LV3).value(query.getCategoryIdLv3())));
            }
            if (query.getFree() != null) {
                queryBuilder.filter(f -> f.term(t -> t.field(CourseRepository.FREE).value(query.getFree())));
            }
            if (query.getType() != null) {
                queryBuilder.filter(f -> f.term(t -> t.field(CourseRepository.TYPE).value(query.getType())));
            }
            
            // 1.3.时间范围查询
            LocalDateTime beginTime = query.getBeginTime();
            LocalDateTime endTime = query.getEndTime();
            if (beginTime != null || endTime != null) {
                queryBuilder.filter(f -> f.range(r -> {
                    r.field(CourseRepository.UPDATE_TIME);
                    if (beginTime != null) {
                        r.gte(JsonData.of(beginTime));
                    }
                    if (endTime != null) {
                        r.lte(JsonData.of(endTime));
                    }
                    return r;
                }));
            }
            
            // 2.构建搜索请求
            SearchRequest.Builder requestBuilder = new SearchRequest.Builder()
                    .index(CourseRepository.INDEX_NAME)
                    .query(queryBuilder.build()._toQuery())
                    .from(query.from())
                    .size(query.getPageSize());
            
            // 2.1.排序
            String sortBy = query.getSortBy();
            if (StringUtils.isNotBlank(sortBy)) {
                SortOrder order = query.getIsAsc() ? SortOrder.Asc : SortOrder.Desc;
                requestBuilder.sort(s -> s.field(f -> f.field(sortBy).order(order)));
            }
            
            // 2.2.高亮
            requestBuilder.highlight(h -> h
                    .fields(CourseRepository.DEFAULT_QUERY_NAME, hf -> hf)
            );
            
            // 2.3.source处理
            if (CourseVO.EXCLUDE_FIELDS.length > 0) {
                requestBuilder.source(src -> src.filter(f -> f.excludes(Arrays.asList(CourseVO.EXCLUDE_FIELDS))));
            }
            
            // 3.执行搜索
            SearchResponse<Course> response = elasticsearchClient.search(requestBuilder.build(), Course.class);
            
            // 4.解析结果
            List<Hit<Course>> hits = response.hits().hits();
            long total = 0;
            if (response.hits().total() != null) {
                total = response.hits().total().value();
            }
            long totalPages = (total + query.getPageSize() - 1) / query.getPageSize();
            
            if (hits.isEmpty()) {
                return new PageDTO<>(total, totalPages, CollUtils.emptyList());
            }
            
            // 5.处理课程数据和高亮
            List<Course> courses = new ArrayList<>(hits.size());
            Set<Long> teacherIds = new HashSet<>(hits.size());
            
            for (Hit<Course> hit : hits) {
                Course course = hit.source();
                if (course == null) continue;
                
                // 处理高亮
                Map<String, List<String>> highlight = hit.highlight();
                if (highlight != null && highlight.containsKey(CourseRepository.DEFAULT_QUERY_NAME)) {
                    List<String> fragments = highlight.get(CourseRepository.DEFAULT_QUERY_NAME);
                    if (CollUtils.isNotEmpty(fragments)) {
                        course.setName(String.join("", fragments));
                    }
                }
                
                courses.add(course);
                teacherIds.add(course.getTeacher());
            }
            
            // 6.查询教师信息
            List<UserDTO> teachers = CollUtils.isEmpty(teacherIds) ? 
                    Collections.emptyList() : userClient.queryUserByIds(teacherIds);
            Map<Long, String> teacherMap = CollUtils.isEmpty(teachers) ? 
                    Collections.emptyMap() : UserUtils.toUserNameMap(teachers);
            
            // 7.转换VO
            List<CourseVO> vos = new ArrayList<>(courses.size());
            for (Course c : courses) {
                CourseVO vo = BeanUtils.toBean(c, CourseVO.class);
                vo.setTeacher(teacherMap.getOrDefault(c.getTeacher(), "未知"));
                vos.add(vo);
            }
            
            return new PageDTO<>(total, totalPages, vos);
        } catch (Exception e) {
            throw new CommonException(SearchErrorInfo.QUERY_COURSE_ERROR, e);
        }
    }

    @Override
    public List<Long> queryCoursesIdByName(String keyword) {
        try {
            // 1.创建搜索请求
            SearchRequest request = SearchRequest.of(s -> s
                    .index(CourseRepository.INDEX_NAME)
                    .query(q -> q.matchPhrase(mp -> mp
                            .field(CourseRepository.DEFAULT_QUERY_NAME)
                            .query(keyword)
                    ))
                    .source(src -> src.filter(f -> f
                            .includes("id")
                    ))
            );
            
            // 2.执行搜索
            SearchResponse<Course> response = elasticsearchClient.search(request, Course.class);
            
            // 3.解析结果
            List<Hit<Course>> hits = response.hits().hits();
            if (hits.isEmpty()) {
                return CollUtils.emptyList();
            }
            
            // 4.提取ID
            return hits.stream()
                    .map(Hit::id)
                    .map(Long::valueOf)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            throw new CommonException(SearchErrorInfo.QUERY_COURSE_ERROR, e);
        }
    }
}
