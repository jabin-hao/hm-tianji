package com.tianji.message.service;

import com.tianji.message.domain.po.NoticeTask;

/**
 * <p>
 * 通告任务执行服务
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
public interface INoticeTaskExecutorService {
    
    /**
     * 执行通告任务
     * @param task 通告任务
     */
    void executeTask(NoticeTask task);
}