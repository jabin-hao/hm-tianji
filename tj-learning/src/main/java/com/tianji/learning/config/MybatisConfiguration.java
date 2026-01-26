package com.tianji.learning.config;

import com.baomidou.mybatisplus.extension.plugins.inner.DynamicTableNameInnerInterceptor;
import com.tianji.learning.utils.TableInfoContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * MP动态计算表名拦截器，在执行SQL之前，根据表名的不同，动态的替换表名
 */
@Configuration
public class MybatisConfiguration {

    @Bean
    public DynamicTableNameInnerInterceptor dynamicTableNameInnerInterceptor() {
        // 创建动态表名拦截器
        DynamicTableNameInnerInterceptor interceptor = new DynamicTableNameInnerInterceptor();
        // 存入一个TableNameHandler，用来替换points_board表名称
        // 替换方式，就是从TableInfoContext中读取保存好的动态表名，如果没有，则返回原来的表名
        interceptor.setTableNameHandler((sql, tableName) -> {
            // 只处理 points_board 表
            if ("points_board".equals(tableName)) {
                return TableInfoContext.getInfo() == null ? tableName : TableInfoContext.getInfo();
            }
            return tableName;
        });
        return interceptor;
    }
}