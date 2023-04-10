package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;

@Controller
public class MemberController {
	
	private static final Logger logger= LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	//자바빈 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	/*=====================================
	                 회원가입
	  ====================================*/
	
	//아이디 중복 체크
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String, String> process(@RequestParam String mem_id){
		logger.debug("<<id>> : " + mem_id);
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		MemberVO member = memberService.selectCheckMember(mem_id);
		
		if(member != null) {
			//아이디 중복
			mapAjax.put("result", "idDuplicated");
		}else {
			if(!Pattern.matches("^[a-z0-9]{4,12}$", mem_id)) {
				//패턴 불일치
				mapAjax.put("result", "notMatchPattern");
			}else {
				//패턴 일치 + 미중복
				mapAjax.put("result", "idNotFound");
			}
		}
		return mapAjax;
	}
	
	//회원 등록 폼 호출
	@GetMapping("/member/registerUser.do")
	public String form() {
		return "memberRegister";
	}
	
	@PostMapping("/member/registerUser.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result, Model model) {
		
		logger.debug("<<회원가입>> : " + memberVO);
		
		//유효성 체크
		if(result.hasErrors()) {
			return form();
		}
		memberVO.setMem_kakao("");
		//회원가입
		memberService.insertMember(memberVO);
		
		System.out.println(memberVO.getMem_id());
		System.out.println(memberVO.getMem_name());
		System.out.println(memberVO.getMem_pw());
		System.out.println(memberVO.getMem_email());
		//model.addAttribute("accessMsg", "회원가입이 완료되었습니다.");
		model.addAttribute("message", "회원가입 완료");
        model.addAttribute("url", "/main/main.do");
		//return "common/notice";
		return "common/resultView";
	}
	/*=====================================
    				로그인
	====================================*/
	
	//-----------------일반-----------------//
	
	//로그인 폼 호출
	@GetMapping("/member/login.do")
	public String formLogin() {
		return "memberLogin";
	}
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberVO memberVO, BindingResult result, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		logger.debug("<<로그인>> : " + memberVO);
		
		//유효성 체크
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("mem_pw")) {
			return formLogin();
		}
		
		MemberVO member = null;
		try {
			member = memberService.selectCheckMember(memberVO.getMem_id());
			
			boolean check = false;
			
			if(member != null) {
				check = member.isCheckedPassword(memberVO.getMem_pw());
			}
			
			if(check) {
				session.setAttribute("user", member);
				session.setAttribute("user_num", member.getMem_num());
				
				logger.debug("<<인증 성공>> : " + member.getMem_id());
				
				return "redirect:/main/main.do";
			}
			
			//인증 실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			if(member != null && member.getMem_auth() == 0) {
				//정지회원
				model.addAttribute("message", "탈퇴한 계정입니다.");
				model.addAttribute("url", "/main/main.do");
				return "common/resultView";
			}else {//아이디 또는 비밀번호 불일치
				model.addAttribute("message", "아이디 또는 비밀번호 불일치");
	            model.addAttribute("url", "/main/main.do");
	            return "common/resultView";
			}
		}
	}
	
	//-----------------카카오-----------------//
	@GetMapping("/member/kakaoForm.do")
	public String kakaoForm() {
		return "memberKakaoRegister";
	}
	
	@PostMapping("/member/registerKakaoUser.do")
	public String submitKakao(@Valid MemberVO memberVO, BindingResult result, HttpSession session, Model model) {
		
		logger.debug("<<카카오톡 회원가입>> : " + memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return kakaoForm();
		}
		memberVO.setMem_phone("");
		//회원가입
		memberService.insertMember(memberVO);
		
		MemberVO member = null;
		member = memberService.selectCheckMember(memberVO.getMem_id());
		
		session.setAttribute("user", member);
		session.setAttribute("user_num", member.getMem_num());
		
		model.addAttribute("accessMsg", "회원가입이 완료되었습니다.");

		return "common/notice";
		
		
	}
	/*=====================================
					로그아웃
	 ====================================*/	
	
	@RequestMapping("/member/logout.do")
	public String processLogout(HttpSession session, HttpServletResponse response) {
		
		session.invalidate();
		
		return "redirect:/main/main.do";
	}
}
