package com.tianji.gateway.swagger;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class GatewaySwaggerResourceProvider {

    /**
     * OpenAPI 3默认的url后缀
     */
    private static final String OPENAPI_URL = "/v3/api-docs";

    /**
     * 路由定位器
     */
    private final RouteLocator routeLocator;

    /**
     * 网关应用名称
     */
    @Value("${spring.application.name}")
    private String gatewayName;

    /**
     * 获取所有微服务的 OpenAPI 文档路径
     */
    public List<SwaggerResource> getSwaggerResources() {
        Map<String, String> servers = new HashMap<>();
        
        // 1.获取路由 Uri中的 Host 作为服务名，把路由id作为请求路径
        routeLocator.getRoutes()
                .filter(route -> route.getUri().getHost() != null)
                .filter(route -> !gatewayName.equals(route.getUri().getHost()))
                .subscribe(r -> servers.put(r.getUri().getHost(), r.getId()));
        
        // 2.创建Swagger资源列表
        return servers.entrySet().stream()
                .map(entry -> {
                    SwaggerResource resource = new SwaggerResource();
                    resource.setName(entry.getKey());
                    resource.setUrl("/" + entry.getValue() + OPENAPI_URL);
                    resource.setSwaggerVersion("3.0.3");
                    return resource;
                })
                .collect(Collectors.toList());
    }
    
    /**
     * Swagger 资源数据结构
     */
    @Setter
    @Getter
    public static class SwaggerResource {
        private String name;
        private String url;
        private String swaggerVersion;
    }
}