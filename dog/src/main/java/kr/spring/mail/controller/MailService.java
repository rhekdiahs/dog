package kr.spring.mail.controller;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class MailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	private static final String FROM_ADDRESS = "4ordog@naver.com";
	
	public void mailSend(MailVO mail) throws Exception{
		MimeMessage message = mailSender.createMimeMessage();
		try {
			message.setFrom(MailService.FROM_ADDRESS);
			message.setSubject(mail.getTitle());
			message.setText(mail.getMessage());
			message.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(mail.getAddress()));
		}catch(MessagingException e) {
			System.out.println("MessagingException");
		}
		
		try {
			mailSender.send(message);
		}catch(MailException e) {
			System.out.println("MailException");
			e.printStackTrace();
		}
	}
}
