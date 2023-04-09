package kr.spring.cafe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.cafe.service.CafeCrawlService;
import kr.spring.cafe.service.CafeService;
import kr.spring.cafe.vo.CafeCrawl;
import kr.spring.cafe.vo.CafeVO;

@Controller
public class CafeController {
	private static final Logger logger = LoggerFactory.getLogger(CafeController.class);
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private CafeCrawlService cafeCrawlService;
	
	//자바빈 초기화
	@ModelAttribute
	public CafeVO initCommand() {
		return new CafeVO();
	}
	
	public CafeController(CafeCrawlService cafeCrawlService) {
		this.cafeCrawlService = cafeCrawlService;
	}
	
	
	//카페 지도
	@RequestMapping("/cafe/cafeMap.do")
	public String cafeMap(Model model) {

		Map<String, Object> map = new HashMap<String, Object>();

		//카페 목록 개수
		int count = cafeService.selectCafeCount(map);

		model.addAttribute("count", count);

		return "cafeMap";

	}
	
	//카페 크롤링 목록
	@GetMapping("/cafe/cafeList.do")
	public String cafeList(Model model) throws Exception{
		
		List<CafeCrawl> cafeCrawl = cafeCrawlService.getCafeCrawlDatas();
		logger.debug("<<카페 뜨나요?>> : " + cafeCrawl);
		model.addAttribute("CafeCrawl", cafeCrawl);
		
		return "cafeList";
		
	}

	
}

