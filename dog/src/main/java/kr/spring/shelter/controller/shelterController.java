package kr.spring.shelter.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.shelter.service.shelterService;
import kr.spring.shelter.vo.shelterVO;

@Controller
public class shelterController {
	private static final Logger logger = LoggerFactory.getLogger(shelterController.class);
	@Autowired
	private shelterService shelterService;

    @GetMapping("/shelter/shelterList.do")
    public String news(Model model) throws Exception{
		 
		 List<shelterVO> list = shelterService.process();
		 logger.debug("<<크롤링 리스트>> : " + list); 
		 model.addAttribute("shelterVO", list);
        
        return "shelter";
    }
    
    //=======주소 좌표로 바꾸기=========//
 	@RequestMapping("/shelter/shelterAddress.do")
 	@ResponseBody // json
 	public Map<String, Object> SearchMember() {

 		Map<String, Object> mapAjax = new HashMap<String, Object>();

 		List<shelterVO> list = shelterService.process();
 		mapAjax.put("result", "success");
 		mapAjax.put("list", list);
 		
 		logger.debug("<<주소 넘기기>> : " + list);
 		return mapAjax;
 	}

}
