package kr.spring.kakao.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

@Controller
public class KakaoController {
private static final Logger logger = LoggerFactory.getLogger(KakaoController.class);
	
	@Autowired
	private MemberService memberService; 
	@Autowired
	private KakaoService kakao;


	//자바빈(VO) 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	
	//카카오 데이터 가져오기 및 로그인
	@RequestMapping("/member/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) {

		String access_Token = kakao.getToken(code);
		System.out.println("controller access_token : " + access_Token);
		
		session.setAttribute("access_Token", access_Token);
		
		
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
		
		//mem_id
		String kakao_id = (String)userInfo.get("kakao_email");
		int idx = kakao_id.indexOf("@"); 
		kakao_id = kakao_id.substring(0,idx);
		System.out.println(kakao_id);

		//mem_name
		String kakao_name = (String)userInfo.get("kakao_name");     	
		//mem_email
		String kakao_email = (String)userInfo.get("kakao_email");

		MemberVO member = memberService.selectKakaoCheck(kakao_email);
		
		if(member != null) { //회원가입 했음
			logger.debug("<<카카오톡 인증 성공>> : " + member.getMem_id());
			
			member.setMem_id(member.getMem_id());
			member.setMem_pw(member.getMem_pw());
			
			member = memberService.selectCheckMember(member.getMem_id());
			
			session.setAttribute("user", member);
			session.setAttribute("user_num", member.getMem_num());
			
			return "redirect:/main/main.do";
			
		}else { //회원가입한 적 없음
			
			model.addAttribute("code", access_Token);
			model.addAttribute("kakao_email", kakao_email);
			model.addAttribute("kakao_name", kakao_name);
			
			return "memberKakaoRegister";
		}

	}
}
