package com.tianji.api.utils;

import com.tianji.api.dto.user.UserDTO;
import com.tianji.common.utils.CollUtils;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 用户工具类
 */
public class UserUtils {
    
    /**
     * 将用户列表转换为 ID到用户 DTO的映射
     * @param users 用户列表
     * @return ID 到用户 DTO的映射
     */
    public static Map<Long, UserDTO> toUserMap(List<UserDTO> users) {
        if (CollUtils.isEmpty(users)) {
            return Collections.emptyMap();
        }
        return users.stream().collect(Collectors.toMap(UserDTO::getId, user -> user));
    }
    
    /**
     * 将用户列表转换为 ID到用户名的映射
     * @param users 用户列表
     * @return ID 到用户名的映射
     */
    public static Map<Long, String> toUserNameMap(List<UserDTO> users) {
        if (CollUtils.isEmpty(users)) {
            return Collections.emptyMap();
        }
        return users.stream().collect(Collectors.toMap(UserDTO::getId, UserDTO::getName));
    }
}
