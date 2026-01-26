package com.tianji.common.autoconfigure.swagger;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import jakarta.annotation.Resource;

@Configuration
@ConditionalOnProperty(prefix = "tj.swagger", name = "enable", havingValue = "true")
@EnableConfigurationProperties(SwaggerConfigProperties.class)
public class OpenApiConfiguration {

    @Resource
    private SwaggerConfigProperties swaggerConfigProperties;

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title(swaggerConfigProperties.getTitle())
                        .description(swaggerConfigProperties.getDescription())
                        .version(swaggerConfigProperties.getVersion())
                        .contact(new Contact()
                                .name(swaggerConfigProperties.getContactName())
                                .url(swaggerConfigProperties.getContactUrl())
                                .email(swaggerConfigProperties.getContactEmail())));
    }
}