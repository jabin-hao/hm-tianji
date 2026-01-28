package com.tianji.common.autoconfigure.mvc;


import com.tianji.common.autoconfigure.mvc.advice.CommonExceptionAdvice;
import com.tianji.common.autoconfigure.mvc.advice.WrapperResponseBodyAdvice;
import com.tianji.common.autoconfigure.mvc.converter.WrapperResponseMessageConverter;
import com.tianji.common.filters.RequestIdFilter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingClass;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import jakarta.servlet.Filter;

@ConditionalOnClass({CommonExceptionAdvice.class, Filter.class})
@Configuration
public class MvcConfig implements WebMvcConfigurer {

    @Bean
    public RequestIdFilter requestIdFilter(){
        return new RequestIdFilter();
    }

    @Bean
    @ConditionalOnMissingClass("org.springframework.cloud.gateway.filter.GlobalFilter")
    public WrapperResponseMessageConverter wrapperResponseMessageConverter(
            MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter
    ){
        return new WrapperResponseMessageConverter(mappingJackson2HttpMessageConverter);
    }

    @Bean
    public WrapperResponseBodyAdvice wrapperResponseBodyAdvice(){
        return new WrapperResponseBodyAdvice();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");

        registry.addResourceHandler("/doc.html")
                .addResourceLocations("classpath:/META-INF/resources/");

        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars");
    }
}
