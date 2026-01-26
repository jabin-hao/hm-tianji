package com.tianji.message.service;

import com.tianji.api.dto.user.UserDTO;
import com.tianji.message.domain.po.NoticeTemplate;
import com.tianji.message.domain.po.PublicNotice;

import java.util.List;

/**
 * <p>
 * 用户信箱批量操作服务
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-19
 */
public interface IUserInboxBatchService {
    
    /**
     * 将公告列表批量保存到用户信箱
     * @param notices 公告列表
     * @param userId 用户ID
     */
    void saveNoticeListToInbox(List<PublicNotice> notices, Long userId);
    
    /**
     * 将通知模板批量保存到用户信箱
     * @param notice 通知模板
     * @param users 用户列表
     */
    void saveNoticeToInbox(NoticeTemplate notice, List<UserDTO> users);
}