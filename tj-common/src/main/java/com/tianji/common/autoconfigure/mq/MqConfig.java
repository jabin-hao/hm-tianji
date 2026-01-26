package com.tianji.common.autoconfigure.mq;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tianji.common.utils.StringUtils;
import org.slf4j.MDC;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.config.ContainerCustomizer;
import org.springframework.amqp.rabbit.config.SimpleRabbitListenerContainerFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;
import org.springframework.amqp.rabbit.retry.MessageRecoverer;
import org.springframework.amqp.rabbit.retry.RepublishMessageRecoverer;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.amqp.SimpleRabbitListenerContainerFactoryConfigurer;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import static com.tianji.common.constants.Constant.REQUEST_ID_HEADER;
import static com.tianji.common.constants.MqConstants.Exchange.ERROR_EXCHANGE;
import static com.tianji.common.constants.MqConstants.Key.ERROR_KEY_PREFIX;
import static com.tianji.common.constants.MqConstants.Queue.ERROR_QUEUE_TEMPLATE;


@Configuration
@ConditionalOnClass(value = {MessageConverter.class, AmqpTemplate.class, ConnectionFactory.class})
@ConditionalOnProperty(prefix = "spring.rabbitmq", name = "host")
public class MqConfig implements EnvironmentAware{

    private String defaultErrorRoutingKey;
    private String defaultErrorQueue;

    @Bean(name = "rabbitListenerContainerFactory")
    @ConditionalOnProperty(prefix = "spring.rabbitmq.listener", name = "type", havingValue = "simple",
            matchIfMissing = true)
    @ConditionalOnClass({SimpleRabbitListenerContainerFactory.class, ConnectionFactory.class})
    @ConditionalOnBean({SimpleRabbitListenerContainerFactoryConfigurer.class, ConnectionFactory.class})
    SimpleRabbitListenerContainerFactory simpleRabbitListenerContainerFactory(
            @Autowired(required = false) SimpleRabbitListenerContainerFactoryConfigurer configurer, 
            @Autowired(required = false) ConnectionFactory connectionFactory,
            @Autowired(required = false) ObjectProvider<ContainerCustomizer<SimpleMessageListenerContainer>> simpleContainerCustomizer) {
        if (configurer == null || connectionFactory == null) {
            return null;
        }
        SimpleRabbitListenerContainerFactory factory = new SimpleRabbitListenerContainerFactory();
        configurer.configure(factory, connectionFactory);
        if (simpleContainerCustomizer != null) {
            simpleContainerCustomizer.ifUnique(factory::setContainerCustomizer);
        }
        factory.setAfterReceivePostProcessors(message -> {
            Object header = message.getMessageProperties().getHeader(REQUEST_ID_HEADER);
            if(header != null) {
                MDC.put(REQUEST_ID_HEADER, header.toString());
            }
            return message;
        });
        return factory;
    }

    @Bean
    @ConditionalOnClass(ObjectMapper.class)
    @ConditionalOnBean(ObjectMapper.class)
    public MessageConverter messageConverter(@Autowired(required = false) ObjectMapper mapper){
        if (mapper == null) {
            return null;
        }
        // 1.定义消息转换器
        Jackson2JsonMessageConverter jackson2JsonMessageConverter = new Jackson2JsonMessageConverter(mapper);
        // 2.配置自动创建消息id，用于识别不同消息
        jackson2JsonMessageConverter.setCreateMessageIds(true);
        return jackson2JsonMessageConverter;
    }

    /**
     * <h1>消息处理失败的重试策略</h1>
     * 本地重试失败后，消息投递到专门的失败交换机和失败消息队列：error.queue
     */
    @Bean
    @ConditionalOnClass({MessageRecoverer.class, RabbitTemplate.class})
    @ConditionalOnBean(RabbitTemplate.class)
    @ConditionalOnMissingBean
    public MessageRecoverer republishMessageRecoverer(@Autowired(required = false) RabbitTemplate rabbitTemplate){
        if (rabbitTemplate == null) {
            return null;
        }
        // 消息处理失败后，发送到错误交换机：error.direct，RoutingKey默认是error.微服务名称
        return new RepublishMessageRecoverer(
                rabbitTemplate, ERROR_EXCHANGE, defaultErrorRoutingKey);
    }

    /**
     * rabbitmq 发送工具
     *
     */
    @Bean
    @ConditionalOnMissingBean
    @ConditionalOnClass(RabbitTemplate.class)
    @ConditionalOnBean(RabbitTemplate.class)
    public RabbitMqHelper rabbitMqHelper(@Autowired(required = false) RabbitTemplate rabbitTemplate){
        if (rabbitTemplate == null) {
            return null;
        }
        return new RabbitMqHelper(rabbitTemplate);
    }

    /**
     * 专门接收处理失败的消息
     */
    @Bean
    @ConditionalOnClass(DirectExchange.class)
    @ConditionalOnBean(ConnectionFactory.class)
    public DirectExchange errorMessageExchange(){
        return new DirectExchange(ERROR_EXCHANGE);
    }

    @Bean
    @ConditionalOnClass(Queue.class)
    @ConditionalOnBean(ConnectionFactory.class)
    public Queue errorQueue(){
        return new Queue(defaultErrorQueue, true);
    }

    @Bean
    @ConditionalOnClass(Binding.class)
    @ConditionalOnBean({ConnectionFactory.class, Queue.class, DirectExchange.class})
    public Binding errorBinding(Queue errorQueue, DirectExchange errorMessageExchange){
        return BindingBuilder.bind(errorQueue).to(errorMessageExchange).with(defaultErrorRoutingKey);
    }

    @Override
    public void setEnvironment(Environment environment) {
        String appName = environment.getProperty("spring.application.name");
        this.defaultErrorRoutingKey = ERROR_KEY_PREFIX + appName;
        this.defaultErrorQueue = StringUtils.format(ERROR_QUEUE_TEMPLATE, appName);
    }
}
