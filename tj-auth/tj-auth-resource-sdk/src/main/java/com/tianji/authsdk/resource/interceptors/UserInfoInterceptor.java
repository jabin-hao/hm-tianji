package com.tianji.authsdk.resource.interceptors;

import com.tianji.auth.common.constants.JwtConstants;
import com.tianji.common.utils.UserContext;
import com.tianji.common.utils.WebUtils;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Slf4j
@Component
public class UserInfoInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request,
                             @NonNull HttpServletResponse response,
                             @NonNull Object handler) {

        if (WebUtils.isSwaggerRequest()) {
            return true;
        }

        String authorization = request.getHeader(JwtConstants.USER_HEADER);
        if (authorization == null) {
            return true;
        }

        try {
            Long userId = Long.valueOf(authorization);
            UserContext.setUser(userId);
        } catch (NumberFormatException e) {
            log.error("用户身份信息格式不正确: {}", authorization);
        }
        return true;
    }

    @Override
    public void afterCompletion(@NonNull HttpServletRequest request,
                                @NonNull HttpServletResponse response,
                                @NonNull Object handler,
                                Exception ex) {
        if (WebUtils.isSwaggerRequest()) {
            UserContext.removeUser();
        }
    }
}
