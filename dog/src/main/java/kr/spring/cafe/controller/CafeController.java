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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	  public ModelAndView cafeList(
			  			  @RequestParam(value="pageNum", defaultValue="1") int currentPage,
						  @RequestParam(value = "keyfield", defaultValue = "서울특별시") String keyfield,
						  String keyword){
	  
	  Map<String, Object> map = new HashMap<String, Object>();
	  	map.put("keyfield", keyfield);
	  	map.put("keyword", keyword);
	  
	  //글의 총 개수
	  int count = cafeService.selectCafeCount(map);
	  
	  logger.debug("개수" + count);
	  
	  PagingUtil page = new PagingUtil(keyfield, null, currentPage, count, 10, 5, "cafeList.do");
	  
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
	 
	/*
	@RequestMapping("/cafe/cafeList.do")
	public String setCoord(Model model) {
		
		List<CafeVO> cafe = null;
		cafe = cafeService.selectCafeList();
		
		model.addAttribute("cafe", cafe);
		
		return "cafeList";
	}
	*/
	/*
	//사용 끝
	@RequestMapping("/cafe/insertCoords.do")
	@ResponseBody
	public void insertCoords(@RequestParam(value = "coord_x") String coord_x, @RequestParam(value = "coord_y") String coord_y,@RequestParam(value = "h_num") Integer h_num) {
		cafeService.updateCoords(coord_x, coord_y, h_num);
	}
	*/
	
	@RequestMapping("/cafe/cafeDetail.do")
	public ModelAndView detail(@RequestParam int cafe_num) {
		
		CafeVO cafe = cafeService.selectCafedetail(cafe_num);
		
		logger.debug("카페 번호 : " + cafe_num);
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cafeDetail");
		mav.addObject("cafe", cafe);
		
		return mav;
	}
	
	@GetMapping("/cafe/cafeWrite.do")
	public String form() {
		return "cafeWrite";
	}
	
	
	
}

