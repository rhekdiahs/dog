package kr.spring.mail.controller;

import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MailController {
	
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private MailVO mailVO;
	
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) throws Exception{
		String key = createKey();
		System.out.println(key);
		System.out.println(email);
		
		mailVO.setAddress(email);
		mailVO.setTitle("4or Dog 인증번호 안내");
		mailVO.setMessage("인증번호는 " + key + "입니다.");
		
		logger.debug("메일vo : " + mailVO.getAddress());
		logger.debug("메일vo : " + mailVO.getTitle());
		logger.debug("메일vo : " + mailVO.getMessage());
		
		mailService.mailSend(mailVO);
		
		return key;
	}
	
	public String createKey() {
		StringBuffer key = new StringBuffer();
		Random rand = new Random();
		
		for(int i = 0; i < 6; i++) {
			key.append((rand.nextInt(10)));
		}
		
		return key.toString();
	}
}
