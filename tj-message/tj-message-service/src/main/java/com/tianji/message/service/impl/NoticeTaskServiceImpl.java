package com.tianji.message.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tianji.common.domain.dto.PageDTO;
import com.tianji.common.utils.BeanUtils;
import com.tianji.common.utils.MarkedRunnable;
import com.tianji.common.utils.StringUtils;
import com.tianji.message.domain.dto.NoticeTaskDTO;
import com.tianji.message.domain.dto.NoticeTaskFormDTO;
import com.tianji.message.domain.po.NoticeTask;
import com.tianji.message.domain.query.NoticeTaskPageQuery;
import com.tianji.message.mapper.NoticeTaskMapper;
import com.tianji.message.service.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.concurrent.Executor;

/**
 * <p>
 * 系统通告的任务表，可以延期或定期发送通告 服务实现类
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class NoticeTaskServiceImpl extends ServiceImpl<NoticeTaskMapper, NoticeTask> implements INoticeTaskService {

    private final Executor asyncNoticeExecutor;
    private final INoticeTaskExecutorService noticeTaskExecutorService;

    @Override
    public Long saveNoticeTask(NoticeTaskFormDTO noticeTaskFormDTO) {
        // 1.保存任务
        NoticeTask noticeTask = BeanUtils.copyBean(noticeTaskFormDTO, NoticeTask.class);
        save(noticeTask);
        Long taskId = noticeTask.getId();
        // 2.判断是否有执行时间
        LocalDateTime pushTime = noticeTask.getPushTime();
        if(pushTime == null || pushTime.isBefore(LocalDateTime.now())){
            // 没有执行时间，或者执行时间小于当前时间，立刻执行任务
            asyncNoticeExecutor.execute(new MarkedRunnable(() -> noticeTaskExecutorService.executeTask(noticeTask)));
        }
        return taskId;
    }

    @Override
    public void updateNoticeTask(NoticeTaskFormDTO noticeTaskFormDTO) {
        NoticeTask noticeTask = BeanUtils.copyBean(noticeTaskFormDTO, NoticeTask.class);
        updateById(noticeTask);
    }

    @Override
    public PageDTO<NoticeTaskDTO> queryNoticeTasks(NoticeTaskPageQuery query) {
        // 1.分页条件
        Page<NoticeTask> page = query.toMpPage();
        // 2.过滤条件
        page = lambdaQuery()
                .eq(query.getFinished() != null, NoticeTask::getFinished, query.getFinished())
                .like(StringUtils.isNotBlank(query.getKeyword()), NoticeTask::getName, query.getKeyword())
                .ge(query.getMinPushTime() != null, NoticeTask::getPushTime, query.getMinPushTime())
                .le(query.getMaxPushTime() != null, NoticeTask::getPushTime, query.getMaxPushTime())
                .page(page);
        // 3.数据转换
        return PageDTO.of(page, NoticeTaskDTO.class);
    }

    @Override
    public NoticeTaskDTO queryNoticeTask(Long id) {
        return BeanUtils.copyBean(getById(id), NoticeTaskDTO.class);
    }

    @Override
    public PageDTO<NoticeTask> queryTodoNoticeTaskByPage(int pageNo, int size) {
        // 1.分页查询待发布任务：未完成，发布时间早于当前时间
        Page<NoticeTask> page = lambdaQuery()
                .eq(NoticeTask::getFinished, false)
                .le(NoticeTask::getPushTime, LocalDateTime.now())
                .page(new Page<>(pageNo, size));
        return PageDTO.of(page);
    }

    @Override
    public void handleTask(NoticeTask noticeTask) {

    }
}
