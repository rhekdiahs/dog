package kr.spring.hospital.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HospitalController {

	@RequestMapping("/hospital/main.do")
	public String hospital_main() {
		return "hospitalMain";
	}
}
