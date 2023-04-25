package kr.spring.cafe.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.cafe.service.CafeService;
import kr.spring.cafe.vo.CafeVO;
import kr.spring.member.vo.MemberVO;
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
	
	public String setCity(String cafe_region){
		
		if(cafe_region.equals("서울")) {
			cafe_region = "서울특별시";
		}else if(cafe_region.equals("부산")) {
			cafe_region = "부산광역시";
		}else if(cafe_region.equals("대구")) {
			cafe_region = "대구광역시";
		}else if(cafe_region.equals("인천")) {
			cafe_region = "인천광역시";
		}else if(cafe_region.equals("광주")) {
			cafe_region = "광주광역시";
		}else if(cafe_region.equals("대전")) {
			cafe_region = "대전광역시";
		}else if(cafe_region.equals("울산")) {
			cafe_region = "울산광역시";
		}else if(cafe_region.equals("세종")) {
			cafe_region = "세종특별자치시";
		}else if(cafe_region.equals("경기")) {
			cafe_region = "경기도";
		}else if(cafe_region.equals("강원")) {
			cafe_region = "강원도";
		}else if(cafe_region.equals("충북")) {
			cafe_region = "충청북도";
		}else if(cafe_region.equals("충남")) {
			cafe_region = "충청남도";
		}else if(cafe_region.equals("전북")) {
			cafe_region = "전라북도";
		}else if(cafe_region.equals("전남")) {
			cafe_region = "전라남도";
		}else if(cafe_region.equals("경북")) {
			cafe_region = "경상북도";
		}else if(cafe_region.equals("경남")) {
			cafe_region = "경상남도";
		}else if(cafe_region.equals("제주")) {
			cafe_region = "제주특별자치도";
		}else {
			cafe_region = " ";
		}
		
		return cafe_region;
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
	
	@GetMapping("/cafe/cafeSelect.do")
	public String send() {		

		
		return "cafeSelect";
	}

	//등록 폼 호출
	@GetMapping("/cafe/cafeWrite.do")
	public String form(CafeVO cafe,
	  		   		   Model model) {
		System.out.println(cafe);
		model.addAttribute("cafe_name", cafe.getCafe_name());
		model.addAttribute("cafe_addr1", cafe.getCafe_addr1());
		model.addAttribute("cafe_addr2", cafe.getCafe_addr2());
		model.addAttribute("cafe_y", cafe.getCafe_y());
		model.addAttribute("cafe_x", cafe.getCafe_x());
		model.addAttribute("cafe_region", setCity(cafe.getCafe_region()));
		
		return "cafeWrite";
	}
	
	//폼 데이터 처리
	@PostMapping("/cafe/cafeWrite.do")
	public String submit(@Valid CafeVO cafe,
					     Model model, HttpSession session,
					     BindingResult result) {

		logger.debug("<<업로드 파일 용량>> : " + cafe.getCafe_image().length);
		
		
		if(cafe.getCafe_image().length >= 5*1024*1024) {
			result.reject("limitUploadSize", new Object[] {"5MB"}, null);
		}
		
		
		if(result.hasErrors()) {
			return form(cafe, model);
		}
		
		cafe.setMem_num(((MemberVO) session.getAttribute("user")).getMem_num());

		cafeService.insertCafeDetail(cafe);
		
		return "redirect:/cafe/cafeList.do";
	}
	
	
	
}

