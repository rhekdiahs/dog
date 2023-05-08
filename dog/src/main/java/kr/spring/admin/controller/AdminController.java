package kr.spring.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.admin.service.AdminService;
import kr.spring.cafe.service.CafeService;
import kr.spring.cafe.vo.CafeVO;
import kr.spring.hospital.service.HospitalService;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.walk.vo.WalkVO;

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
	
	@Autowired
	private HospitalService hospitalService;
	
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	@ModelAttribute
	public CafeVO initCafeCommand() {
		return new CafeVO();
	}
	
	@ModelAttribute
	public HospitalVO initHosCommand() {
		return new HospitalVO();
	}
	
	@ModelAttribute
	public WalkVO initWalkCommand() {
		return new WalkVO();
	}
	
	@RequestMapping("/admin/adminMain.do")
	public String main(Model model) {
		return "adminMain";//타일스 설정값
	}
	
	//회원 관리
	@RequestMapping("/admin/adminMember.do")
	public ModelAndView memberList(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								  String keyfield, String keyword){
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = memberService.selectRowCount(map);
		
		logger.debug("count>>" + count);
		
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 5 ,"adminMember.do");
		
		List<MemberVO> userList = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			userList = memberService.selectList(map);
		}
		
		logger.debug("user>>" + userList);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminMember");
			mav.addObject("count", count);
			mav.addObject("userList", userList);
			mav.addObject("page", page.getPage());
	
		return mav;
	}
	
	//카페 관리
	@RequestMapping("/admin/admincafe.do")
	public ModelAndView cafeList(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								  String keyfield, String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = cafeService.selectCafeAdminCount(map);
		
		logger.debug("count>>" + count);
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5 ,"admincafe.do");
		
		List<CafeVO> cafe = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			cafe = cafeService.selectCafeAdminList(map);
		}
		
		logger.debug("cafe>>" + cafe);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admincafe");
		
		mav.addObject("count", count);
		mav.addObject("cafe", cafe);
		mav.addObject("page", page.getPage());	
		
		return mav;
	}
	
	//병원 관리
	@RequestMapping("/admin/adminhospital.do")
	public ModelAndView hospitalList(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								  String keyfield, String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = adminService.selectHosAdminCount(map);
		
		logger.debug("count>>" + count);
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5 ,"adminhospital.do");
		
		List<HospitalVO> hospital = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			hospital = adminService.selectHosAdminList(map);
		}
		
		logger.debug("hos>>" + hospital);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminhospital");
		
		mav.addObject("count", count);
		mav.addObject("hospital", hospital);
		mav.addObject("page", page.getPage());	
		
		return mav;
	}
	
	//산책로 관리
	@RequestMapping("/admin/adminwalk.do")
	public ModelAndView walkList(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								  String keyfield, String keyword){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = adminService.selectWalkAdminCount(map);
		
		logger.debug("count>>" + count);
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 5, 5 ,"adminwalk.do");
		
		List<WalkVO> walk = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			walk = adminService.selectWalkAdminList(map);
		}
		
		logger.debug("walk>>" + walk);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminwalk");
		
		mav.addObject("count", count);
		mav.addObject("walk", walk);
		mav.addObject("page", page.getPage());	
		
		return mav;
	}
	
	
	
	@PostMapping(value={"/cafe/cafeDetail.do","/hospital/hospitalDetail.do","/walk/viewWalk.do"})
	public String updateStatus(@RequestParam(value="p_num")int p_num, HttpServletRequest request){
		
		String url = request.getHeader("referer").split("/")[3];
		
		if(url.equals("cafe")) {
				CafeVO cafe = new CafeVO();
				cafe.setCafe_num(p_num);
				adminService.updateCafeStatus(cafe);
			}else if(url.equals("hospital")) {
				HospitalVO hos = new HospitalVO();
				hos.setHospital_num(p_num);
				adminService.updateHosStatus(hos);
			}else if(url.equals("walk")) {
				WalkVO walk = new WalkVO();
				walk.setWalk_num(p_num);
				adminService.updateWalkStatus(walk);
			}else {

			}
		return "redirect:/admin/admin"+url+".do";
	}
	
}
