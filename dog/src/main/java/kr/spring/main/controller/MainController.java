package kr.spring.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	
	@RequestMapping("/")
	public String rmain() {
		return "redirect:/main/main.do";
	}
	
	@RequestMapping("/main/main.do")
	public String main(Model model) {
		return "main";//타일스 설정값
	}
	
	@RequestMapping("/main/admin.do")
	public String mainAdmin(Model model) {
		return "admin";//타일스 설정값
	}
}
