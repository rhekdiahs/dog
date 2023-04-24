package kr.spring.walk.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.beust.jcommander.internal.Console;

import kr.spring.hospital.vo.HospitalVO;
import kr.spring.util.PagingUtil;
import kr.spring.walk.service.WalkService;
import kr.spring.walk.vo.WalkVO;

@Controller
public class WalkController {
	private static final Logger logger = LoggerFactory.getLogger(WalkController.class);
	@Autowired
	private WalkService walkService;
	
	
	@ModelAttribute("walkVO")
	public WalkVO initCommand() {
		return new WalkVO();
	}
	
	//모든 산책경로 리스트
	@RequestMapping("/walk/list.do")
	public String walkList(@RequestParam(value = "keyfield", defaultValue = "서울특별시") String keyfield, Model model) {
		List<WalkVO> list = walkService.getWalkList();
		/*
		 * List<String> path = new ArrayList<String>(); int len = list.size();
		 * 
		 * for(int i=0;i<len;i++) { path.add(i,list.get(i).getWalk_position()); }
		 * 
		 * logger.debug("타입확인 ㅈ같네 레알 ~~ *.*.*." + path.get(0).getClass().getName());
		 * logger.debug("String 인가요?" + path.get(0));
		 * 
		 * logger.debug("이게무슨" + list.get(0).getWalk_position()); //String 타입 확인 완료
		 * 
		 * model.addAttribute("path",path);
		 */
		model.addAttribute("list", list);
		
		return "walkList";
	}
	
	//산책경로 등록
	@RequestMapping("/walk/register.do")
	public String registerWalk(@RequestParam(value = "keyfield", defaultValue = "서울특별시") String keyfield) {
		return "registerWalk";
	}
	
	@RequestMapping("/walk/curCityAjax.do")
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
			keyfield = "--선택--";
		}
		
		System.out.println(keyfield);
		mapAjax.put("result", keyfield);
		
		return mapAjax;
	}
	
	//지역 설정
	@RequestMapping("/walk/selectRegionFromList.do")
	public String selectRegionFromList(@RequestParam(value = "keyfield", defaultValue = "서울특별시") String keyfield, Model model) {
			List<WalkVO> list = walkService.getWalkList();
			System.out.println(list);
			model.addAttribute("list", list);
			
			return "walkList";
		}
	
	//지역 설정
	@RequestMapping("/walk/selectRegionFromRegister.do")
	public String selectRegionFromRegister(@RequestParam(value = "keyfield", defaultValue = "서울특별시", required = false) String keyfield) {
		return "registerWalk";
	}
	
	//DB에 산책경로 좌표 저장
	@RequestMapping("/walk/insertPoints.do")
	@ResponseBody
	public Map<String, String> insertPointsArr(@RequestParam(value="pointsArr") String[] arr, @RequestParam(value="region") String region){
		
		logger.debug("region = " + region);
		Map<String, String> map = new HashMap<String, String>();
		
		if(arr == null) {
			logger.debug("NULL인데요");
			map.put("status", "null");
		}
		
		logger.debug("<< 첫번째 좌표의 X >>::" + arr[0]);
		
		WalkVO walkVO = initCommand();
		for(int i=0; i<arr.length-1; i++) {
			walkVO.setWalk_position(Arrays.toString(arr));
		}
		walkVO.setWalk_region(region);
		walkVO.setMem_id("❤❤❤❤");
		
		logger.debug("<<제대로 들어갔는지 확인해볼까>> " + walkVO.getWalk_position().substring(1,walkVO.getWalk_position().length()-1));
		logger.debug("<<WalkVO도 확인해볼까>> " + walkVO);
		
		walkVO.setWalk_position(walkVO.getWalk_position().substring(1,walkVO.getWalk_position().length()-1));
		walkService.insertPoints(walkVO);
		
		map.put("status", "success");
		
		return map;
	}
	
	//선택한 산책경로 보기
	@RequestMapping("/walk/viewWalk.do")
	public String viewWalk(@RequestParam Integer walk_num, Model model) {
		String walk_position = walkService.getWalkPosition(walk_num);
		logger.debug("좌표확인좀? " + walk_position);
		
		String[] walk_position_arr = walk_position.split(", ");
		
		List<String[]> list = new ArrayList<String[]>();
		for(int i=0; i<walk_position_arr.length; i+=2) {
			list.add(Arrays.copyOfRange(walk_position_arr, i, i+2));
		}
		
		for(int i=0;i<list.size();i++) {
		logger.debug("리스트확인좀? " + Arrays.toString(list.get(i)));
		}
		
		Integer center = (int)Math.round(Math.floor(list.size() /2));
		
		logger.debug("<<<<< 중간 좌표 index >>>>>" + center);
		logger.debug("<<<<<<<< 중간 (x,y) 좌표>>>>" + Arrays.toString(list.get(center)));
		
		model.addAttribute("list", list);
		model.addAttribute("center",center);
		
		return "viewWalk";
	}
}
