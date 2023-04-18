package kr.spring.walk.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping("/walk/list.do")
	public String walkList(Model model) {
		List<WalkVO> list = walkService.getWalkList();
		List<String> path = new ArrayList<String>();
		int len = list.size();
		
		for(int i=0;i<len;i++) {
			path.add(i,list.get(i).getWalk_position());
		}
		
		model.addAttribute("list", list);
		return "walkList";
	}
	
	@RequestMapping("/walk/register.do")
	public String registerWalk() {
		return "registerWalk";
	}
	
	//DB에 산책경로 좌표 저장
	@RequestMapping("/walk/insertPoints.do")
	@ResponseBody
	public Map<String, String> insertPointsArr(@RequestParam(value="pointsArr") String[] arr){
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
		logger.debug("<<제대로 들어갔는지 확인해볼까>> " + walkVO.getWalk_position().substring(1,walkVO.getWalk_position().length()-1));
		logger.debug("<<WalkVO도 확인해볼까>> " + walkVO);
		
		walkVO.setWalk_position(walkVO.getWalk_position().substring(1,walkVO.getWalk_position().length()-1));
		walkService.insertPoints(walkVO);
		
		map.put("status", "success");
		
		return map;
	}
	

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
