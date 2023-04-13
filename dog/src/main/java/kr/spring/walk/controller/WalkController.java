package kr.spring.walk.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String walkList() {
		return "walkList";
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
	
	//DB에서 가져온 x,y좌표를 홀수짝수로 해가지고 저장해가지고 jsp에 보내서 JS에서 그 쌍을 가지고 drawingMap OK.
}
