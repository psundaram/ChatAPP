package com.anpi.app.config;

import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.anpi.app.model.Connection;

public class HttpSessionIdHandshakeInterceptor implements HandshakeInterceptor {

    @Override public boolean beforeHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Map<String, Object> stringObjectMap)
            throws Exception {
        if(serverHttpRequest instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) serverHttpRequest;
            HttpSession session = ((ServletServerHttpRequest) serverHttpRequest).getServletRequest().getSession(false);
            if(session != null) {
                stringObjectMap.put("connection",  (Connection) session.getAttribute("connection"));
                stringObjectMap.put("userName",   session.getAttribute("userName"));
                
            }
        }
        return true;
    }

    @Override public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

    }
}
