package com.tianji.remark;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.net.InetAddress;
import java.net.UnknownHostException;

@SpringBootApplication
@EnableScheduling
@MapperScan("com.tianji.remark.mapper")
@Slf4j
@ComponentScan("com.tianji")
public class RemarkApplication {
    public static void main(String[] args) throws UnknownHostException {
        SpringApplication app = new SpringApplicationBuilder(RemarkApplication.class).build(args);
        Environment env = app.run(args).getEnvironment();
        String protocol = "http";
        if (env.getProperty("server.ssl.key-store") != null) {
            protocol = "https";
        }
        log.info("""
                        --/
                        ---------------------------------------------------------------------------------------
                        \t\
                        Application '{}' is running! Access URLs:
                        \t\
                        Local: \t\t{}://localhost:{}
                        \t\
                        External: \t{}://{}:{}
                        \t\
                        Profile(s): \t{}\
                        
                        ---------------------------------------------------------------------------------------""",
                env.getProperty("spring.application.name"),
                protocol,
                env.getProperty("server.port"),
                protocol,
                InetAddress.getLocalHost().getHostAddress(),
                env.getProperty("server.port"),
                env.getActiveProfiles());
    }
}
