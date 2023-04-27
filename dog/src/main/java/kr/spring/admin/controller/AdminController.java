package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.service.MemberService;

@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	
	
	
	/*
	@RequestMapping("/admin/adminMember.do")
	public ModelAndView memberList(@RequestParam(value="pageNum",defaultValue="1")
								  int currentPage,
								  String keyfield, String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = memberService.
		
		
		return ;
	}
	*/
	
	@RequestMapping("/admin/adminMember.do")
	public String member(Model model) {
		return "adminMember";//타일스 설정값
	}
	
}
