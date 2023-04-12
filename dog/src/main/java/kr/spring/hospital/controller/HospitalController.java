package kr.spring.hospital.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.hospital.service.HospitalService;
import kr.spring.hospital.vo.HospitalVO;

@Controller
public class HospitalController {

	@Autowired
	private HospitalService hospitalService;
	
	@RequestMapping("/hospital/main.do")
	public String hospital_main(Model model) {
		
		List<HospitalVO> list = null;
		
		list = hospitalService.selectStoredHosList();
		
		model.addAttribute("list", list);
		
		return "hospitalMain";
	}
}
