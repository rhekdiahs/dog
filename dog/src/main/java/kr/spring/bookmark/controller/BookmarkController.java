package kr.spring.bookmark.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.bookmark.service.BookmarkService;
import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.cafe.vo.CafeVO;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.walk.controller.WalkController;
import kr.spring.walk.vo.WalkVO;
import lombok.experimental.var;

@Controller
public class BookmarkController {
	private static final Logger logger = LoggerFactory.getLogger(WalkController.class);
	
	@Autowired
	private BookmarkService bookmarkService;
	
	@ModelAttribute("bookmarkVO")
	public BookmarkVO initBookmarkCommand() {
		return new BookmarkVO();
	}
	
	@ModelAttribute("walkVO")
	public WalkVO initWalkCommand() {
		return new WalkVO();
	}
	@ModelAttribute("hospitalVO")
	public HospitalVO initHosCommand() {
		return new HospitalVO();
	}
	@ModelAttribute("cafeVO")
	public CafeVO initCafeCommand() {
		return new CafeVO();
	}
	@RequestMapping("/bookmark/insertBookmark.do")
	@ResponseBody
	public Map<String, String> bookAjax(int pk_num, HttpSession session, HttpServletRequest request) {
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		String hostURL = request.getHeader("referer").split("/")[3];
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapAjax.put("status", "null");
			
		}else { 
			BookmarkVO bookmark = new BookmarkVO();
			
			bookmark.setMem_num(user.getMem_num());
			
			if(hostURL.equals("walk")) {
				bookmark.setWalk_num(pk_num);
				bookmark.setCategories(1);
			}else if(hostURL.equals("hospital")) {
				bookmark.setHospital_num(pk_num);
				bookmark.setCategories(2);
			}else if(hostURL.equals("cafe")) {
				bookmark.setCafe_num(pk_num);
				bookmark.setCategories(3);
			}
			Integer cnt = bookmarkService.checkBookmark(bookmark);
			
			if(cnt == 1) {
				bookmarkService.deleteBookmark(bookmark);
				System.out.println('a');
				mapAjax.put("status", "deleteOK");
			}else if(cnt == 0) {
				bookmarkService.insertBookmark(bookmark);
				mapAjax.put("status", "insertOK");
			}
		}

		return mapAjax;
	}
	@RequestMapping("/bookmark/getBookmark.do")
	@ResponseBody
	public Map<String, String> getBookAjax(int pk_num, HttpSession session, HttpServletRequest request) {
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		String hostURL = request.getHeader("referer").split("/")[3];
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapAjax.put("status", "null");
			
		}else { 
			BookmarkVO bookmark = new BookmarkVO();
			
			bookmark.setMem_num(user.getMem_num());
			
			if(hostURL.equals("walk")) {
				bookmark.setWalk_num(pk_num);
			}else if(hostURL.equals("hospital")) {
				bookmark.setHospital_num(pk_num);
			}else if(hostURL.equals("cafe")) {
				bookmark.setCafe_num(pk_num);
			}
			Integer cnt = bookmarkService.checkBookmark(bookmark);
			
			if(cnt == 1) {
				mapAjax.put("status", "full");
				mapAjax.put("pk_num", Integer.toString(pk_num));
			}
		}

		return mapAjax;
	}	
	
	
	
	
	
	
	
	
	/*
	 * @RequestMapping("/bookmark/insert.do")
	 * 
	 * @ResponseBody public Map<String, String>
	 * insertBookmark(@RequestParam(value="walk_num", required = false)Integer
	 * walk_num,
	 * 
	 * @RequestParam(value="hospital_num", required = false)Integer hospital_num,
	 * 
	 * @RequestParam(value="cafe_num", required = false)Integer cafe_num,
	 * HttpSession session) { MemberVO member =
	 * (MemberVO)session.getAttribute("user");
	 * 
	 * Map<String, String> map = new HashMap<String, String>();
	 * 
	 * if(member == null) { logger.debug("어랏 도둑인가"); map.put("status", "null"); }
	 * 
	 * BookmarkVO bookmark = initBookmarkCommand();
	 * 
	 * Integer mem_num = member.getMem_num();
	 * 
	 * bookmark.setMem_num(mem_num);
	 * 
	 * int categories = 0; //산책로 =1 병원=2 카페=3
	 * 
	 * if(walk_num != null) { bookmark.setWalk_num(walk_num); categories = 1; } else
	 * if(hospital_num != null) { bookmark.setHospital_num(hospital_num); categories
	 * = 2; } else if(cafe_num != null) { bookmark.setCafe_num(cafe_num); categories
	 * = 3; }
	 * 
	 * bookmark.setCategories(categories);
	 * 
	 * logger.debug(">>>VO 확인 >>>" + bookmark);
	 * 
	 * Integer checkCount = bookmarkService.checkBookmark(bookmark);
	 * 
	 * if(checkCount == 1) { //이미 북마크 되어있음 //DB에 삭제
	 * bookmarkService.deleteBookmark(bookmark); map.put("status", "deleteOK");
	 * }else if(checkCount == 0) { //DB에 추가
	 * bookmarkService.insertBookmark(bookmark); map.put("status", "insertOK"); }
	 * 
	 * return map; }
	 * 
	 * @RequestMapping("/bookmark/presentBookmark.do")
	 * 
	 * @ResponseBody public Map<String, String>
	 * presentBookmark(@RequestParam(value="walk_num", required = false)Integer
	 * walk_num,
	 * 
	 * @RequestParam(value="hospital_num", required = false)Integer hospital_num,
	 * 
	 * @RequestParam(value="cafe_num", required = false)Integer cafe_num,
	 * HttpSession session) { MemberVO member =
	 * (MemberVO)session.getAttribute("user");
	 * 
	 * Map<String, String> map = new HashMap<String, String>();
	 * 
	 * if(member == null) { logger.debug("어랏 도둑인가"); map.put("status", "null");
	 * 
	 * return map; }
	 * 
	 * BookmarkVO bookmark = initBookmarkCommand();
	 * 
	 * Integer mem_num = member.getMem_num();
	 * 
	 * bookmark.setMem_num(mem_num);
	 * 
	 * int categories = 0; //산책로 =1 병원=2 카페=3
	 * 
	 * if(walk_num != null) { bookmark.setWalk_num(walk_num); categories = 1; } else
	 * if(hospital_num != null) { bookmark.setHospital_num(hospital_num); categories
	 * = 2; } else if(cafe_num != null) { bookmark.setCafe_num(cafe_num); categories
	 * = 3; }
	 * 
	 * bookmark.setCategories(categories);
	 * 
	 * logger.debug(">>>VO 확인 >>>" + bookmark);
	 * 
	 * Integer checkCount = bookmarkService.checkBookmark(bookmark);
	 * 
	 * if(checkCount == 1) { //이미 북마크 되어있음 map.put("status", "full"); }else
	 * if(checkCount == 0) { map.put("status", "empty"); }
	 * 
	 * return map; }
	 */
}
