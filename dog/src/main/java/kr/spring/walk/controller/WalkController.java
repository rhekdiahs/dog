package kr.spring.walk.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.walk.service.WalkService;

@Controller
public class WalkController {
	private static final Logger logger = LoggerFactory.getLogger(WalkController.class);
	
	@Autowired
	private WalkService walkService;
	
	@RequestMapping("/walk/list.do")
	public String walkList() {
		return "walkList";
	}
	
}
