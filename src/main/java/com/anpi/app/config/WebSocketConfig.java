/**
 */
package com.anpi.app.config;

import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

/**
 * Defines methods for configuring message handling with simple messaging
 * protocols (e.g. STOMP) from WebSocket clients. Typically used to customize
 * the configuration provided via the {@link EnableWebSocketMessageBroker}
 * annotation. <br/>
 * <br/>
 * WebSocketConfig is annotated with <code>@Configuration</code> to indicate
 * that it is a Spring configuration class. It is also annotated with
 * <code>@EnableWebSocketMessageBroker</code>. As its name suggests,
 * <code>@EnableWebSocketMessageBroker</code> enables WebSocket message
 * handling, backed by a message broker. <br/>
 * <br/>
 * Furthermore, this is also annotated with the <code>@EnableScheduling</code>
 * annotation. This enables Spring's scheduled task execution ability.
 * 
 * @author <a href="mailto:sunitkatkar@gmail.com">Sunit Katkar</a>
 * @since 1.0
 * @version 1.0.0.1
 */

@Configuration
@EnableWebSocketMessageBroker
@EnableScheduling
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {
    //public class WebSocketConfig implements WebSocketConfigurer{

    @Override public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic/","/user", "/queue/");
        config.setApplicationDestinationPrefixes("/app");
    }

    /*@Bean
    public DefaultHandshakeHandler handshakeHandler() {
        return new DefaultHandshakeHandler(new TomcatRequestUpgradeStrategy());
    }*/

    @Override public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/simplemessages","/statusmessage","/displayusers","/groupChat","/groupChatInvitation").withSockJS().setInterceptors(new HttpSessionIdHandshakeInterceptor());;
    }

    @Override
    public boolean configureMessageConverters(List<MessageConverter> converters) {
      return true;
    }
    
    @Override
    public void configureClientInboundChannel(ChannelRegistration channelRegistration) {
      //  channelRegistration.setInterceptors(new SubscriptionInterceptor());
    }

    @Override
    public void configureClientOutboundChannel(ChannelRegistration channelRegistration) {
    }

    
    /*@Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.taskExecutor().corePoolSize(4).maxPoolSize(8);
    }

    @Override
    public void configureClientOutboundChannel(ChannelRegistration registration) {
        registration.taskExecutor().corePoolSize(4).maxPoolSize(8);
    }*/


    //    @Override public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
    //        webSocketHandlerRegistry.addHandler(chatHandler(),"/hello");
    //    }

    
    


    /*@Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.taskExecutor().corePoolSize(4).maxPoolSize(8);
    }

    @Override
    public void configureClientOutboundChannel(ChannelRegistration registration) {
        registration.taskExecutor().corePoolSize(4).maxPoolSize(8);
    }*/


    //    @Override public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
    //        webSocketHandlerRegistry.addHandler(chatHandler(),"/hello");
    //    }

   /* @Override public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.setInterceptors(new SocketInterceptors());
    }*/

    /*@Bean
      public WebSocketHandler chatHandler() {
        return new ChatHandler();
    }*/

    
    

    
}
