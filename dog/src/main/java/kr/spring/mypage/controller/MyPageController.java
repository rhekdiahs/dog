package kr.spring.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MyPageService;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.walk.controller.WalkController;
import kr.spring.walk.vo.WalkVO;

@Controller
public class MyPageController {
	private static final Logger logger = LoggerFactory.getLogger(WalkController.class);
	@Autowired
	private MyPageService mypageService;
	
	@Autowired
	private MemberService memberService;
	
	@ModelAttribute("memberVO")
	   public MemberVO initCommand() {
	      return new MemberVO();
	   }
	
	@RequestMapping("/mypage/main.do")
	public String mypageMain(HttpSession session, Model model) {
		//로그인 검사
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null) {
			logger.debug("어랏 도둑인가");
		}
		
		Integer mem_num = member.getMem_num();
		member = mypageService.getMemInfo(mem_num);
		
		int count = mypageService.getBookmarkCount(mem_num);
		
		model.addAttribute("member", member);
		model.addAttribute("totalCount", count);
		
		return "mypageMain";
	}
	
	@RequestMapping("/mypage/editMain.do")
	public String editProfileMain(@RequestParam Integer mem_num, HttpSession session, Model model) {
		MemberVO member = memberService.getMemInfo(mem_num);
		logger.debug("member = " + member.toString());
		
		model.addAttribute("member",member);
		
		return "editForm";
	}
	
	@RequestMapping("/mypage/bookmark.do")
	public String bookmark(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
							@RequestParam(value = "categories", defaultValue = "0") String categories, 
							Model model, HttpSession session) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null) {
			logger.debug("어랏 도둑인가");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categories", categories);
		
		int count = mypageService.getBookmarkCountByCategories(map);
		
		PagingUtil page	= new PagingUtil(categories, null, currentPage, count, 10, 5, "bookmark.do");
		
		List<BookmarkVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = mypageService.getBookmarkListByCategories(map);
		}

		model.addAttribute("list", list);
		model.addAttribute("member",member);
		model.addAttribute("page", page.getPage());
		
		return "myBookmark";
	}
	
	@PostMapping("/mypage/modifyProfile.do")
	public String modifyProfile(@ModelAttribute("memberVO") MemberVO member, HttpSession session, Model model) {
		if(member == null) {
			logger.debug("어랏 도둑인가");
			model.addAttribute("message","로그인 먼저");
			return "common/resultView";
		}
		Integer mem_num = member.getMem_num();
		logger.debug("이름 대 : " + mem_num);
		
		member = mypageService.getMemInfo(mem_num);
		logger.debug("이름 대 : " + member.getMem_name() + "/이메일도 : " + member.getMem_email());
		
		model.addAttribute("member", member);
		return "";
	}
	
	@PostMapping("/mypage/delete.do")
	public String deleteMyId(@RequestParam("mem_pw") String mem_pw, HttpSession session, Model model) {
		MemberVO member = (MemberVO)session.getAttribute("user");
		
		if(member == null) {
			logger.debug("어랏 도둑인가");
		}
		
		Integer mem_num = member.getMem_num();
		String mem_db_pw = mypageService.getMemInfo(mem_num).getMem_pw();
		
		if(!mem_pw.equals(mem_db_pw)) {
			logger.debug("안ㅁ자아");
			model.addAttribute("message", "비밀번호가 맞지 않습니다.");
			model.addAttribute("url", "/mypage/main.do");
		}else {
			logger.debug("ok");
			
			mypageService.deleteAccount(mem_num);
			
			model.addAttribute("message", "회원탈퇴가 완료되었습니다.");
			model.addAttribute("url", "/main/main.do");
			
			session.removeAttribute("user");
			
		}
		return "common/resultView";
	}

	
}
