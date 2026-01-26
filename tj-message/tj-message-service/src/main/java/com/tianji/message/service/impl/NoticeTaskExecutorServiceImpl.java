package com.tianji.message.service.impl;

import com.tianji.api.client.user.UserClient;
import com.tianji.api.dto.user.UserDTO;
import com.tianji.common.utils.CollUtils;
import com.tianji.message.constants.MessageErrorInfo;
import com.tianji.message.domain.po.NoticeTask;
import com.tianji.message.domain.po.NoticeTemplate;
import com.tianji.message.enums.TemplateStatus;
import com.tianji.message.mapper.NoticeTaskMapper;
import com.tianji.message.service.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 通告任务执行服务实现类
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class NoticeTaskExecutorServiceImpl implements INoticeTaskExecutorService {

    private final INoticeTemplateService noticeTemplateService;
    private final UserClient userClient;
    private final IPublicNoticeService publicNoticeService;
    private final IUserInboxService inboxService;
    private final ISmsService smsService;
    private final NoticeTaskMapper noticeTaskMapper;

    @Override
    @Transactional
    public void executeTask(NoticeTask task) {
        // 1.获取任务要发送的通知模板
        Long templateId = task.getTemplateId();
        NoticeTemplate noticeTemplate = noticeTemplateService.getById(templateId);
        if(noticeTemplate == null){
            // 模板不存在或者无法使用
            log.error("通知任务无法执行，模板id【{}】，原因：{}", templateId, MessageErrorInfo.NOTICE_TEMPLATE_NOT_EXISTS);
            return;
        }
        if(noticeTemplate.getStatus() != TemplateStatus.IN_SERVICE.getValue()){
            // 模板不存在或者无法使用
            log.error("通知任务无法执行，模板id【{}】，原因：{}", templateId, MessageErrorInfo.NOTICE_TEMPLATE_CANNOT_USE);
            return;
        }
        // 2.获取通知对应的目标用户
        List<UserDTO> users = null;
        if (task.getPartial()) {
            // 针对部分用户，需要查询用户信息
            List<Long> userIds = noticeTaskMapper.queryTaskTargetByTaskId(task.getId());
            if(CollUtils.isNotEmpty(userIds)){
                users = userClient.queryUserByIds(userIds);
            }
        }

        // 3.判断是全部用户还是部分
        if (CollUtils.isEmpty(users)) {
            // 3.1.全部用户，直接存入公告箱，用户查看消息时才拉取(pull mode)
            publicNoticeService.saveNoticeOfTemplate(noticeTemplate);
        }else{
            // 3.2.部分用户，需要写入用户信箱
            inboxService.saveNoticeToInbox(noticeTemplate, users);
            // 3.3.判断是否需要发短信通知
            if(noticeTemplate.getIsSmsTemplate()){
                // 需要发送短信通知
                smsService.sendMessageByTemplate(noticeTemplate, users);
            }
        }
        // 4.到这里说明任务完成，更新任务状态
        boolean shouldRepeat = task.getMaxTimes() > 0;
        // 使用原生SQL更新，避免再次调用自己的方法
        if (shouldRepeat) {
            // 重复任务，更新下次推送时间并减少剩余次数
            noticeTaskMapper.updateTaskForRepeat(task.getId(), task.getPushTime().plusMinutes(task.getInterval()));
        } else {
            // 非重复任务，标记为已完成
            noticeTaskMapper.updateTaskAsFinished(task.getId());
        }
    }
}