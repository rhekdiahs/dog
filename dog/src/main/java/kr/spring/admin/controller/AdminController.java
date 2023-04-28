package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.admin.service.AdminService;
import kr.spring.cafe.service.CafeService;
import kr.spring.cafe.vo.CafeVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;

@Controller
public class AdminController {
	private static final Logger logger = 
			LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private MemberService memberService;
	
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private CafeService cafeService;
	
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	@RequestMapping("/admin/adminMain.do")
	public String main(Model model) {
		return "adminMain";//타일스 설정값
	}
	

	@RequestMapping("/admin/adminMember.do")
	public ModelAndView memberList(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								  String keyfield, String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = memberService.selectRowCount(map);
		
		logger.debug("count>>" + count);
		
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 5 ,"adminMember.do");
		
		List<MemberVO> user = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			user = memberService.selectList(map);
		}
		
		logger.debug("user>>" + user);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminMember");
		
		mav.addObject("count", count);
		mav.addObject("user", user);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	@RequestMapping("/admin/adminCafe.do")
	public ModelAndView cafeList(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								  String keyfield, String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = cafeService.selectCafeCount(map);
		
		logger.debug("count>>" + count);
		
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5 ,"adminCafe.do");
		
		List<CafeVO> cafe = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			cafe = cafeService.selectCafeList(map);
		}
		
		logger.debug("cafe>>" + cafe);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminCafe");
		
		mav.addObject("count", count);
		mav.addObject("cafe", cafe);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
}
