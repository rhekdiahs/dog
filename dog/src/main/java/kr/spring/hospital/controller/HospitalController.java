package kr.spring.hospital.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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

import kr.spring.cafe.vo.CafeVO;
import kr.spring.hospital.service.HospitalService;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import kr.spring.walk.service.WalkService;
import kr.spring.walk.vo.WalkVO;
import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.cafe.controller.CafeController;
import kr.spring.cafe.service.CafeService;

@Controller
public class HospitalController {
	
	private static final Logger logger = LoggerFactory.getLogger(HospitalController.class);

	@Autowired
	private HospitalService hospitalService;
	
	@Autowired
	private CafeService cafeService;
	
	@Autowired
	private WalkService walkService;
	
	@ModelAttribute
	public HospitalVO initCommand() {
		return new HospitalVO();
	}
	public static String getClientIP(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
	    logger.info("> X-FORWARDED-FOR : " + ip);

	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
	        logger.info("> Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	        logger.info(">  WL-Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	        logger.info("> HTTP_CLIENT_IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	        logger.info("> HTTP_X_FORWARDED_FOR : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
	        logger.info("> getRemoteAddr : "+ip);
	    }
	    logger.info("> Result : IP Address : "+ip);

	    return ip;
	}
	
	/*
	 * @RequestMapping("/bookmark/insertBookmark.do")
	 * 
	 * @ResponseBody public Map<String, String> bookAjax(int pk_num, HttpSession
	 * session, HttpServletRequest request) {
	 * 
	 * Map<String, String> mapAjax = new HashMap<String, String>(); String hostURL =
	 * request.getHeader("referer").split("/")[3];
	 * 
	 * MemberVO user = (MemberVO)session.getAttribute("user"); if(user == null) {
	 * mapAjax.put("status", "null");
	 * 
	 * }else { BookmarkVO bookmark = new BookmarkVO();
	 * 
	 * bookmark.setMem_num(user.getMem_num());
	 * 
	 * if(hostURL.equals("walk")) { bookmark.setWalk_num(pk_num); }else
	 * if(hostURL.equals("hospital")) { bookmark.setHospital_num(pk_num); }else
	 * if(hostURL.equals("cafe")) { bookmark.setCafe_num(pk_num); } Integer cnt =
	 * hospitalService.selectBookmark(bookmark);
	 * 
	 * if(cnt == 1) { hospitalService.deleteBookmark(bookmark);
	 * System.out.println('a'); mapAjax.put("status", "deleteOK"); }else if(cnt ==
	 * 0) { hospitalService.insertBookmark(bookmark); mapAjax.put("status",
	 * "insertOK"); } }
	 * 
	 * return mapAjax; }
	 * 
	 * @RequestMapping("/bookmark/getBookmark.do")
	 * 
	 * @ResponseBody public Map<String, String> getBookAjax(int pk_num, HttpSession
	 * session, HttpServletRequest request) {
	 * 
	 * Map<String, String> mapAjax = new HashMap<String, String>(); String hostURL =
	 * request.getHeader("referer").split("/")[3];
	 * 
	 * MemberVO user = (MemberVO)session.getAttribute("user"); if(user == null) {
	 * mapAjax.put("status", "null");
	 * 
	 * }else { BookmarkVO bookmark = new BookmarkVO();
	 * 
	 * bookmark.setMem_num(user.getMem_num());
	 * 
	 * if(hostURL.equals("walk")) { bookmark.setWalk_num(pk_num); }else
	 * if(hostURL.equals("hospital")) { bookmark.setHospital_num(pk_num); }else
	 * if(hostURL.equals("cafe")) { bookmark.setCafe_num(pk_num); } Integer cnt =
	 * hospitalService.selectBookmark(bookmark);
	 * 
	 * if(cnt == 1) { mapAjax.put("status", "full"); mapAjax.put("pk_num",
	 * Integer.toString(pk_num)); } }
	 * 
	 * return mapAjax; }
	 */
	
	@RequestMapping("/hospital/curCityAjax.do")
	@ResponseBody
	public Map<String, String> curCityAjax(String curCity){
		String keyfield;
		System.out.println(curCity);
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		if(curCity.equals("Seoul")) {
			keyfield = "서울특별시";
		}else if(curCity.equals("Busan")) {
			keyfield = "부산광역시";
		}else if(curCity.equals("Daegu")) {
			keyfield = "대구광역시";
		}else if(curCity.equals("Incheon")) {
			keyfield = "인천광역시";
		}else if(curCity.equals("Gwangju")) {
			keyfield = "광주광역시";
		}else if(curCity.equals("Daejeon")) {
			keyfield = "대전광역시";
		}else if(curCity.equals("Ulsan")) {
			keyfield = "울산광역시";
		}else if(curCity.equals("Sejong-si")) {
			keyfield = "세종특별자치시";
		}else if(curCity.equals("Gyeonggi-do")) {
			keyfield = "경기도";
		}else if(curCity.equals("Gangwon-do")) {
			keyfield = "강원도";
		}else if(curCity.equals("Chungcheongbuk-do")) {
			keyfield = "충청북도";
		}else if(curCity.equals("Chungcheongnam-do")) {
			keyfield = "충청남도";
		}else if(curCity.equals("Jeollabuk-do")) {
			keyfield = "전라북도";
		}else if(curCity.equals("Jeollanam-do")) {
			keyfield = "전라남도";
		}else if(curCity.equals("Gyeongsangbuk-do")) {
			keyfield = "경상북도";
		}else if(curCity.equals("Gyeongsangnam-do")) {
			keyfield = "경상남도";
		}else if(curCity.equals("Jeju City")) {
			keyfield = "제주특별자치도";
		}else {
			keyfield = "--선택";
		}
		
		System.out.println(keyfield);
		mapAjax.put("result", keyfield);
		
		return mapAjax;
	}
	
	@RequestMapping("/hospital/hospitalList.do")
	public String hospital_main(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage, 
								Model model, HttpServletRequest request, 
								@RequestParam(value = "keyfield", defaultValue = "--선택") String keyfield) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		
		
		int count = hospitalService.selectRegionListCount(map);
		
		PagingUtil page = new PagingUtil(keyfield, null, currentPage, count, 10, 5, "h_selectOption.do");
		
		List<HospitalVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = hospitalService.selectStoredHosList(map);
		}
		
		model.addAttribute("list",list);
		model.addAttribute("page", page.getPage());
		
		//List<HospitalVO> list = null;
		//list = hospitalService.selectStoredHosList();

		/*logger.debug("<<한개만 가져와>> : " + list.get(1).getRoad());
				
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setRoad(list.get(i).getRoad().split(",")[0]);
		}*/
		String ip = getClientIP(request);
		
		//model.addAttribute("list", list);
		model.addAttribute("ip", ip);
		return "hospitalMain";
	}
	
	@RequestMapping("/hospital/h_selectOption.do")
	public String selectedMain(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage, @RequestParam(value = "keyfield", defaultValue = "서울특별시") String keyfield, String keyword, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		System.out.println(keyword);
		int count = hospitalService.selectRegionListCount(map);
		
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 5, "h_selectOption.do");
		
		List<HospitalVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = hospitalService.selectStoredHosList(map);
		}
		
		model.addAttribute("list",list);
		model.addAttribute("page", page.getPage());
		
		return "hospitalMain";
	}
	
	@RequestMapping("/hospital/hospitalDetail.do")
	public ModelAndView hospital_detail(@RequestParam int hospital_num) {
		
		HospitalVO hospital = hospitalService.selectHospital(hospital_num);
		
		hospital.setH_name(StringUtil.useNoHtml(hospital.getH_name()));
		if(hospital.getH_info_detail() != null) {
			hospital.setH_info_detail(StringUtil.useBrNoHtml(hospital.getH_info_detail()));
		}

		return new ModelAndView("hospitalDetail", "hospital", hospital);
	}
	@GetMapping("/hospital/hospitalSelect.do")
	public String send() {		

		
		return "hospitalSelect";
	}

	@GetMapping("/hospital/hospitalWrite.do")
	public String form(HospitalVO hospital,
	  		   		   Model model) {
		CafeController cafectrl = new CafeController();
		System.out.println(hospital.getRoad());
		System.out.println(hospital.getH_address());
		model.addAttribute("h_name", hospital.getH_name());
		model.addAttribute("road", hospital.getRoad());
		model.addAttribute("h_address", hospital.getH_address());
		model.addAttribute("coord_y", hospital.getCoord_y());
		model.addAttribute("coord_x", hospital.getCoord_x());
		model.addAttribute("hospital_region", cafectrl.setCity(hospital.getHospital_region()));

		return "hospitalWrite";
	}
	

	 @PostMapping("/hospital/hospitalWrite.do") 
	 public String submit(@Valid HospitalVO hospital, BindingResult result, Model model, HttpSession session ) {
		 
		 String encodedParam = ""; 
		 
		 if(hospital.getH_info_image().length >= 5*1024*1024) {
		 result.reject("limitUploadSize", new Object[] {"5MB"}, null); }
		 
		 
		 if(result.hasErrors()) { return form(hospital, model); }
		 
		 hospital.setMem_num(((MemberVO) session.getAttribute("user")).getMem_num());
		 
		 hospital.setH_info_auth(0);
		 
		 hospitalService.insertHospitalDetail(hospital);
		 String returnString = hospital.getHospital_region(); 
		 try { 
			 encodedParam = URLEncoder.encode(returnString, "UTF-8"); 
		 } catch (UnsupportedEncodingException e) { 
			 e.printStackTrace(); 
		 }
		 
		 
		 return "redirect:/hospital/hospitalList.do?keyfield="+encodedParam; 
	 }
	 
	 @RequestMapping("/hospital/reqUpdate.do")
	 public String reqUpdate(@RequestParam int pk_num, HttpServletRequest request, HttpSession session, Model model) {
		 
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("message", "로그인 후 이용가능합니다.");
			model.addAttribute("url", "/member/login.do");
			return "common/resultView";
		}
		 String hostURL = request.getHeader("referer").split("/")[3];
		 
		 model.addAttribute("hostURL", hostURL);
		 
		 model.addAttribute("pk_num", pk_num);
		 if(hostURL.equals("walk")) {
			 //WalkVO walk = walkService.
		 }else if(hostURL.equals("hospital")) {
			 HospitalVO hospital = hospitalService.selectHospital(pk_num);
			 model.addAttribute("coord_x", hospital.getCoord_x());
			 model.addAttribute("coord_y", hospital.getCoord_y());
		 }else if(hostURL.equals("cafe")) {
			 CafeVO cafe = cafeService.selectCafedetail(pk_num);
			 model.addAttribute("coord_x", cafe.getCafe_x());
			 model.addAttribute("coord_y", cafe.getCafe_y());
		 }
		 return "reqUpdateForm";
	 }
	/* 사용 끝
	 * @RequestMapping("/hospital/insertCoords.do")
	@ResponseBody
	public void insertCoords(@RequestParam(value = "coord_x") String coord_x, @RequestParam(value = "coord_y") String coord_y,@RequestParam(value = "h_num") Integer h_num) {
		hospitalService.updateCoords(coord_x, coord_y, h_num);
		cnt++;
		System.out.println(cnt);
	}
	*/
	//프로필 사진 공통코드
	public void viewProfile(HospitalVO hospital, HttpServletRequest request, Model model) {
		if(hospital.getH_info_image_name() == null) {
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/defaltHospitalImg.png"));
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "defaltHospitalImg.png");
		}else {
			model.addAttribute("imageFile", hospital.getH_info_image());
			model.addAttribute("filename", hospital.getH_info_image_name());
		}
	}
	@RequestMapping("/hospital/photoView.do")
	public String getProfile(@RequestParam int hospital_num,HttpServletRequest request, Model model) {
		
		HospitalVO hospital = hospitalService.selectHospital(hospital_num);
		logger.debug("<hospital>:" + hospital);
		viewProfile(hospital,request,model);
		
		return "imageView";
	}
}
