package com.tianji.gateway.config;

import com.tianji.gateway.swagger.GatewaySwaggerResourceProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.ServerResponse;

import static org.springframework.web.reactive.function.server.RequestPredicates.GET;
import static org.springframework.web.reactive.function.server.RequestPredicates.accept;
import static org.springframework.web.reactive.function.server.RouterFunctions.route;
import static org.springframework.http.MediaType.APPLICATION_JSON;

@Configuration
@RequiredArgsConstructor
public class OpenApiConfig {

    private final RouteLocator routeLocator;
    private final GatewaySwaggerResourceProvider swaggerResourceProvider;

    @Bean
    public RouterFunction<ServerResponse> openApiRoutes() {
        return route(GET("/v3/api-docs/swagger-config")
                        .and(accept(APPLICATION_JSON)), 
                serverRequest -> ServerResponse.ok()
                        .contentType(APPLICATION_JSON)
                        .bodyValue(swaggerResourceProvider.getSwaggerResources()))
                .andRoute(GET("/swagger-resources")
                        .and(accept(APPLICATION_JSON)), 
                serverRequest -> ServerResponse.ok()
                        .contentType(APPLICATION_JSON)
                        .bodyValue(swaggerResourceProvider.getSwaggerResources()))
                .andRoute(GET("/swagger-resources/configuration/ui"),
                serverRequest -> ServerResponse.ok()
                        .contentType(APPLICATION_JSON)
                        .bodyValue("{}"))
                .andRoute(GET("/swagger-resources/configuration/security"),
                serverRequest -> ServerResponse.ok()
                        .contentType(APPLICATION_JSON)
                        .bodyValue("{}"));
    }
}