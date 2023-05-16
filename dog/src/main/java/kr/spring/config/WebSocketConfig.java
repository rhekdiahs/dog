package kr.spring.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.spring.websocket.ws.AlarmHandler;

@Configuration//bean을 정의하는 클래스
@EnableWebSocket//websocket을 사용할 수 있게 해준다
public class WebSocketConfig implements WebSocketConfigurer{

	private final AlarmHandler alarmHandler = new AlarmHandler();
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(alarmHandler, "message-ws.do").setAllowedOrigins("*");
		//message-ws.do  Endpoint 예) new WebSocket("ws://localhost:8001/message-ws.do");
		//setAllowedOrigins("*"); 모든 도메인 접근 허용
		//message-ws.do 호출하면 alarmHandler 실행
	}
	
}
