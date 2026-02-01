package com.tianji.authsdk.resource.config;

import cn.hutool.core.collection.CollUtil;
import com.tianji.authsdk.resource.interceptors.LoginAuthInterceptor;
import com.tianji.authsdk.resource.interceptors.UserInfoInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Configuration
@RequiredArgsConstructor
@EnableConfigurationProperties(ResourceAuthProperties.class)
public class ResourceInterceptorConfiguration implements WebMvcConfigurer {

    private final ResourceAuthProperties authProperties;
    private final UserInfoInterceptor userInfoInterceptor;
    private final LoginAuthInterceptor loginAuthInterceptor;

        private static final List<String> SWAGGER_EXCLUDE_PATHS = List.of(
            // 支持任意前缀下的文档路径自动放行
            "/**/v3/api-docs",
            "/**/v3/api-docs/**",
            "/**/swagger-ui/**",
            "/**/swagger-ui.html",
            "/**/swagger-resources/**",
            "/**/webjars/**",
            "/**/doc.html",
            // 兼容无前缀情况
            "/v3/api-docs",
            "/v3/api-docs/**",
            "/swagger-ui/**",
            "/swagger-ui.html",
            "/swagger-resources/**",
            "/webjars/**",
            "/doc.html"
        );

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(userInfoInterceptor)
                .order(0)
                .excludePathPatterns(SWAGGER_EXCLUDE_PATHS);

        if (!Boolean.TRUE.equals(authProperties.getEnable())) {
            return;
        }

        InterceptorRegistration registration = registry
                .addInterceptor(loginAuthInterceptor)
                .order(1);

        if (CollUtil.isNotEmpty(authProperties.getIncludeLoginPaths())) {
            registration.addPathPatterns(authProperties.getIncludeLoginPaths());
        }

        if (CollUtil.isNotEmpty(authProperties.getExcludeLoginPaths())) {
            registration.excludePathPatterns(authProperties.getExcludeLoginPaths());
        }

        registration.excludePathPatterns(SWAGGER_EXCLUDE_PATHS);
    }
}
