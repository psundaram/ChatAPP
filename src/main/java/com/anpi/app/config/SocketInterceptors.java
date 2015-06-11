package com.anpi.app.config;

import java.util.Map;

import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageType;
import org.springframework.messaging.support.ChannelInterceptorAdapter;

public class  SocketInterceptors extends ChannelInterceptorAdapter{

    @Override public Message<?> preSend(Message<?> message, MessageChannel channel) {
        Map<String, Object> sessionHeaders = SimpMessageHeaderAccessor.getSessionAttributes(message.getHeaders());
        MessageHeaders headers = message.getHeaders();
        SimpMessageType type = (SimpMessageType) sessionHeaders.get("connection");
        String simpSessionId = (String) sessionHeaders.get("simpSessionId");
        System.out.println("WsSession " + simpSessionId + " is connected for ");
        /*if(type == SimpMessageType.CONNECT){
            Principal principal = (Principal) headers.get("simpUsr");
            System.out.println("WsSession " + simpSessionId + " is connected for user "+principal.getName());
        }else if(type == SimpMessageType.DISCONNECT){
            System.out.println("WsSession "+ simpSessionId + "is disconnected");
        }*/
        return super.preSend(message,channel);
    }
}
