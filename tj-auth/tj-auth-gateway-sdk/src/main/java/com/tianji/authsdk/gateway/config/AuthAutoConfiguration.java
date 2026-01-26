package com.tianji.authsdk.gateway.config;

import com.tianji.authsdk.gateway.util.AuthUtil;
import com.tianji.authsdk.gateway.util.JwtSignerHolder;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;

@Configuration
public class AuthAutoConfiguration {

    /**
     * 添加了 @ConditionalOnBean(DiscoveryClient.class)：确保只有当 DiscoveryClient bean 存在时才创建 JwtSignerHolder
     * 添加了 @ConditionalOnClass(StringRedisTemplate.class) 和 @ConditionalOnBean({JwtSignerHolder.class, StringRedisTemplate.class})：确保只有当 StringRedisTemplate 类存在并且相关的 bean 都可用时才创建 AuthUtil
     * 导入了 @ConditionalOnBean：添加了必要的导入
     */
    @Bean
    @ConditionalOnClass(DiscoveryClient.class)
    @ConditionalOnBean(DiscoveryClient.class)
    public JwtSignerHolder jwtSignerHolder(DiscoveryClient discoveryClient){
        return new JwtSignerHolder(discoveryClient);
    }

    @Bean
    @ConditionalOnClass(StringRedisTemplate.class)
    @ConditionalOnBean({JwtSignerHolder.class, StringRedisTemplate.class})
    public AuthUtil authUtil(JwtSignerHolder jwtSignerHolder, StringRedisTemplate stringRedisTemplate){
        return new AuthUtil(jwtSignerHolder, stringRedisTemplate);
    }
}
