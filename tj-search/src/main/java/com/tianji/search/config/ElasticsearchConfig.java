package com.tianji.search.config;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.ElasticsearchTransport;
import co.elastic.clients.transport.rest_client.RestClientTransport;
import lombok.Getter;
import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Configuration
public class ElasticsearchConfig {

    @Bean
    public ElasticsearchClient elasticsearchClient(ElasticsearchProperties properties) {
        // 创建低级客户端
        RestClient restClient = RestClient.builder(
                new HttpHost(properties.getHost(), properties.getPort(), properties.getScheme())
        ).build();

        // 使用 Jackson 映射器创建传输层
        ElasticsearchTransport transport = new RestClientTransport(
                restClient, new JacksonJsonpMapper());

        // 创建高级客户端
        return new ElasticsearchClient(transport);
    }

    @Getter
    @Component
    @ConfigurationProperties(prefix = "elasticsearch")
    public static class ElasticsearchProperties {
        private String host = "116.62.21.219";
        private int port = 9200;
        private String scheme = "http";

        public void setHost(String host) {
            this.host = host;
        }

        public void setPort(int port) {
            this.port = port;
        }

        public void setScheme(String scheme) {
            this.scheme = scheme;
        }
    }
}