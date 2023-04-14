package kr.spring.cafe.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.cafe.service.CafeService;
import kr.spring.cafe.vo.CafeVO;
import kr.spring.util.PagingUtil;

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

	@RequestMapping("/cafe/cafeList.do")
	public ModelAndView cafeList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								 @RequestParam(value = "keyfield", defaultValue = "서울특별시")
								 String keyfield,
								 String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//글의 총 개수
		int count = cafeService.selectCafeCount(map);
		
		logger.debug("개수" + count);
		
		PagingUtil page = new PagingUtil(keyfield, null, currentPage,
										 count, 10, 5, "cafeList.do");
		
		List<CafeVO> cafe = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			cafe = cafeService.selectCafeList(map);
		}
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cafeList");
		
		mav.addObject("count", count);
		mav.addObject("cafe", cafe);
		mav.addObject("page", page.getPage());
		
		
		return mav;
		
	}
	
	
}

