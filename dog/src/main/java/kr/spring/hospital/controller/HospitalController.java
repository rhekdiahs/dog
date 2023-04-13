package kr.spring.hospital.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.hospital.service.HospitalService;
import kr.spring.hospital.vo.HospitalVO;

@Controller
public class HospitalController {
	
	private static final Logger logger = LoggerFactory.getLogger(HospitalController.class);
	private int cnt = 0;
	@Autowired
	private HospitalService hospitalService;
	
	@RequestMapping("/hospital/main.do")
	public String hospital_main(Model model) {
		
		List<HospitalVO> list = null;
		list = hospitalService.selectStoredHosList();

		logger.debug("<<한개만 가져와>> : " + list.get(1).getRoad());
				
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setRoad(list.get(i).getRoad().split(",")[0]);
		}
		
		
		model.addAttribute("list", list);
		
		return "hospitalMain";
	}
	
	@RequestMapping("/hospital/insertCoords.do")
	@ResponseBody
	public void insertCoords(@RequestParam(value = "coord_x") String coord_x, @RequestParam(value = "coord_y") String coord_y,@RequestParam(value = "h_num") Integer h_num) {
		hospitalService.updateCoords(coord_x, coord_y, h_num);
		cnt++;
		System.out.println(cnt);
	}
}
