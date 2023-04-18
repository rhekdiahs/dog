package kr.spring.hospital.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.hospital.service.HospitalService;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;

@Controller
public class HospitalController {
	
	private static final Logger logger = LoggerFactory.getLogger(HospitalController.class);

	@Autowired
	private HospitalService hospitalService;
	
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
	
	@RequestMapping("/hospital/main.do")
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
	public String selectedMain(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage, @RequestParam(value = "keyfield", defaultValue = "서울특별시") String keyfield, HttpSession session, Model model) {
		
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
		
		return "hospitalMain";
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
	@RequestMapping("/mypage/photoView.do")
	public String getProfile(@RequestParam(value = "hospital_num", defaultValue = "1") int hospital_num,HttpServletRequest request, Model model) {
		
		HospitalVO hospital = hospitalService.selectHospital(hospital_num);

		viewProfile(hospital,request,model);
		
		return "imageView";
	}
}
