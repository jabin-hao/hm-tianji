package com.tianji.promotion.config;

import lombok.extern.slf4j.Slf4j;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Duration;

/**
 * Redisson配置类
 * 如果 tj-common 模块的自动配置没有生效，使用此配置类
 */
@Slf4j
@Configuration
@EnableConfigurationProperties(RedisProperties.class)
public class RedissonConfiguration {

    @Bean
    @ConditionalOnMissingBean
    public RedissonClient redissonClient(RedisProperties properties) {
        log.debug("尝试在 tj-promotion 模块中初始化 RedissonClient");
        
        // 1.读取Redis配置
        String password = properties.getPassword();
        int timeout = 3000;
        Duration d = properties.getTimeout();
        if (d != null) {
            timeout = Long.valueOf(d.toMillis()).intValue();
        }
        
        // 2.设置Redisson配置
        Config config = new Config();
        
        // 单机模式 (根据实际情况调整)
        config.useSingleServer()
                .setAddress(String.format("redis://%s:%d", properties.getHost(), properties.getPort()))
                .setConnectTimeout(timeout)
                .setDatabase(properties.getDatabase())
                .setPassword(password);
        
        // 3.创建Redisson客户端
        return Redisson.create(config);
    }
}