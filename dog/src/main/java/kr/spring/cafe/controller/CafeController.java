package kr.spring.cafe.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cafe.service.CafeService;
import kr.spring.cafe.vo.CafeVO;

@Controller
public class CafeController {
	private static final Logger logger = LoggerFactory.getLogger(CafeController.class);
	
	@Autowired
	private CafeService cafeService;
	
	//자바빈 초기화
	@ModelAttribute
	public CafeVO initCommand() {
		return new CafeVO();
	}
	
	//카페 목록
	@RequestMapping("/cafe/cafeList.do")
	public String cafeList(Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//카페 목록 개수
		int count = cafeService.selectCafeCount(map);
		
		model.addAttribute("count", count);
		
		return "cafeList";
		
	}
	
}

