package com.tianji.auth.config;

import org.apache.tomcat.util.http.Rfc6265CookieProcessor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.embedded.tomcat.TomcatContextCustomizer;
import org.springframework.cloud.bootstrap.encrypt.KeyProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.rsa.crypto.KeyStoreKeyFactory;

import java.security.KeyPair;

@Configuration
public class AuthConfig {

    @Bean
    @ConfigurationProperties(prefix = "encrypt")
    public KeyProperties keyProperties(){
        return new KeyProperties();
    }

    @Bean
    public KeyPair keyPair(KeyProperties keyProperties){
        // 获取秘钥工厂
        KeyStoreKeyFactory keyStoreKeyFactory =
                new KeyStoreKeyFactory(
                        keyProperties.getKeyStore().getLocation(),
                        keyProperties.getKeyStore().getPassword().toCharArray());
        //读取钥匙对
        return keyStoreKeyFactory.getKeyPair(
                keyProperties.getKeyStore().getAlias(),
                keyProperties.getKeyStore().getSecret().toCharArray());
    }

    @Bean
    public TomcatContextCustomizer cookieTomcatContextCustomizer(){
        return context -> {
            Rfc6265CookieProcessor cookieProcessor = new Rfc6265CookieProcessor();
            // 允许Cookie名称中使用特殊字符，类似LegacyCookieProcessor的行为
            cookieProcessor.setSameSiteCookies("Lax");
            context.setCookieProcessor(cookieProcessor);
        };
    }
}
