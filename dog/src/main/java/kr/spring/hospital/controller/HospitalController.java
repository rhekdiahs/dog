package kr.spring.hospital.controller;

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

import kr.spring.hospital.service.HospitalService;
import kr.spring.hospital.vo.HospitalVO;
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
	
	@RequestMapping("/hospital/main.do")
	public String hospital_main(Model model) {
		
		//List<HospitalVO> list = null;
		//list = hospitalService.selectStoredHosList();

		/*logger.debug("<<한개만 가져와>> : " + list.get(1).getRoad());
				
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setRoad(list.get(i).getRoad().split(",")[0]);
		}*/
		
		
		//model.addAttribute("list", list);
		
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
}
