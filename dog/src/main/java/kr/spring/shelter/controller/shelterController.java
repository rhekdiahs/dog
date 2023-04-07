package kr.spring.shelter.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.shelter.service.shelterService;
import kr.spring.shelter.vo.shelterVO;

@Controller
public class shelterController {
	private static final Logger logger = LoggerFactory.getLogger(shelterController.class);
	@Autowired
	private shelterService shelterService;

    @GetMapping("/shelter/shelterList.do")
    public String news(Model model) throws Exception{
        List<shelterVO> list = shelterService.getNewsDatas();
        logger.debug("<<크롤링 리스트>> : " + list);
        model.addAttribute("shelterVO", list);
        
        return "shelter";
    }
}
