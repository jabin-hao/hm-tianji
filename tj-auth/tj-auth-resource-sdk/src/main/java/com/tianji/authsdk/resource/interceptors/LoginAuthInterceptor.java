package com.tianji.authsdk.resource.interceptors;

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
public class LoginAuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request,
                             @NonNull HttpServletResponse response,
                             @NonNull Object handler) throws Exception {

        if (WebUtils.isSwaggerRequest()) {
            return true;
        }

        Long userId = UserContext.getUser();
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "未登录用户无法访问！");
            return false;
        }
        return true;
    }
}
