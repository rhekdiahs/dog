package kr.spring.kakao.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class KakaoService {
	
	@Value("${property.key.apikey}")
	private String apikey;
	
	public String getToken(String code) {
		
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuffer sb = new StringBuffer();
			sb.append("grant_type=authorization_code");
            sb.append("&client_id="+apikey);
            sb.append("&redirect_uri=http://localhost:8080/member/kakaoLogin");
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();
            
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while((line = br.readLine()) != null) {
            	result += line;
            }
            
            System.out.println("response body : " + result);
            
            ObjectMapper objectMapper = new ObjectMapper();
            
            Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
			});
            
            access_Token = jsonMap.get("access_token").toString();
			refresh_Token = jsonMap.get("refresh_token").toString();
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return access_Token;
	}
}
