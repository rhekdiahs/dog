package kr.spring.community.contoller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.community.service.CommunityService;
import kr.spring.community.vo.CommunityAlarmVO;
import kr.spring.community.vo.CommunityFavVO;
import kr.spring.community.vo.CommunityReplyVO;
import kr.spring.community.vo.CommunityVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class CommunityController {
	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);

	@Autowired
	private CommunityService communityService;

	@ModelAttribute
	public CommunityVO initCOmmand() {
		return new CommunityVO();
	}

	@ModelAttribute
	public CommunityAlarmVO initCommand() {
		return new CommunityAlarmVO();
	}

	//글목록
	@RequestMapping("/community/list.do")
	public ModelAndView process(@RequestParam(value="pagenum", defaultValue="1") int currentPage, String keyfield, String keyword, String keyfield2) {
		Map<String,Object> map = new HashMap<String, Object>();

		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("keyfield2", keyfield2);

		int count = communityService.selectCount(map);

		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "/board/list.do");

		List<CommunityVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = communityService.selectList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("clist");//타일스 설정 값
		mav.addObject("keyfield", keyfield);//처음 검색값에 조회수순과 가나다순을 하기 위해
		mav.addObject("keyword", keyword);
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page",page.getPage());

		return mav;
	}




	//글쓰기
	@GetMapping("/community/write.do")
	public String form() {
		return "cwrite";
	}
	@PostMapping("/community/write.do")
	public String submit(@Valid CommunityVO communityVO, BindingResult result, HttpServletRequest request, 
			RedirectAttributes redirect, HttpSession session) {
		logger.debug("<<게시판 글쓰기>> : " + communityVO);

		//유효성 체크 결과 오류가 있으면 폼을 호출
		if(result.hasErrors()) {
			return form();
		}

		//회원번호 셋팅
		communityVO.setMem_num(((MemberVO)session.getAttribute("user")).getMem_num());

		//글쓰기
		communityService.insertCommunity(communityVO);
		//RedirectAttributes 객체는 리다이렉트 시점에 한번만 사용되는 데이터를 전송
		//브라우저에 데이터를 전송하지만 URL상에 보이지 않는 숨겨진 데이터의 형태로 전달
		//key      value
		redirect.addFlashAttribute("result","success");//이게 숨겨져서 보내진다

		return "redirect:/community/list.do";
	}

	//글상세
	@RequestMapping("/community/detail.do")
	public ModelAndView process(@RequestParam int lf_num) {
		communityService.updateHit(lf_num);

		CommunityVO c = communityService.selectCommunity(lf_num);

		c.setLf_title(StringUtil.useNoHtml(c.getLf_title()));

		//뷰이름       속성명       속성값
		return new ModelAndView("cdetail", "community", c);
	}

	//글수정
	@GetMapping("/community/update.do")
	public String formUpdate(@RequestParam int lf_num, Model model) {
		CommunityVO community = communityService.selectCommunity(lf_num);

		model.addAttribute("communityVO", community);

		return "cupdate";
	}
	//수정폼에서 전송된 데이터 처리
	@PostMapping("/community/update.do")
	public String submitUpdate(@Valid CommunityVO communityVO, BindingResult result, HttpServletRequest request, Model model) {

		if(result.hasErrors()) {
			CommunityVO vo = communityService.selectCommunity(communityVO.getLf_num());
			communityVO.setLf_imgsrc(vo.getLf_imgsrc());
			return "cupdate";
		}

		communityService.updateCommunity(communityVO);

		//View에 표시할 메시지
		model.addAttribute("message", "글수정 완료");
		model.addAttribute("url", request.getContextPath()+"/community/detail.do?lf_num=" + communityVO.getLf_num());


		return "common/resultView";
	}

	//글삭제
	@RequestMapping("/community/delete.do")
	public String submitDelete(@RequestParam int lf_num, Model model, HttpServletRequest request) {
		communityService.deleteCommunity(lf_num);

		return "redirect:/community/list.do";
	}

	//=========파일 삭제===========//
	@RequestMapping("/community/deleteFile.do")
	@ResponseBody//json                                       로그아웃이면 안됨
	public Map<String,String> processFile(int lf_num, HttpSession session){
		Map<String,String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			communityService.deleteImage(lf_num);

			mapJson.put("result", "success");
		}
		return mapJson;
	}

	//=======이미지 출력=======//
	@RequestMapping("/community/imageView.do")
	public ModelAndView viewImage(@RequestParam int lf_num, @RequestParam int community_type) {

		CommunityVO community = communityService.selectCommunity(lf_num);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");

		if(community_type == 1) {//프로필 사진
			mav.addObject("imageFile", community.getPhoto());
			mav.addObject("filename", community.getPhoto_name());
		}else if(community_type == 2) {//업로드된 이미지
			mav.addObject("imageFile", community.getLf_ufile());
			mav.addObject("filename", community.getLf_imgsrc());
		}
		return mav;
	}

	//======파일 다운로드=======//
	@RequestMapping("/community/file.do")
	public ModelAndView download(@RequestParam int lf_num) {
		CommunityVO community = communityService.selectCommunity(lf_num);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView");
		mav.addObject("downloadFile", community.getLf_ufile());
		mav.addObject("filename", community.getLf_imgsrc());

		return mav;
	}

	//좋아요
	//좋아요 읽기
	@RequestMapping("/community/getFav.do")
	@ResponseBody
	public Map<String, Object> getFav(CommunityFavVO fav, HttpSession session){
		Map<String,Object> mapJson = new HashMap<String, Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");

		if(user==null) {
			mapJson.put("status", "noFav");
		}else {
			//로그인된 아이디 셋팅
			fav.setMem_num(user.getMem_num());

			CommunityFavVO communityFav = communityService.selectFav(fav);
			if(communityFav!=null) {//좋아요가 있으면 좋아요 보이게 표시
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", communityService.selectFavCount(fav.getLf_num()));

		return mapJson;
	}


	//좋아요 등록
	@RequestMapping("/community/writeFav.do")
	@ResponseBody
	public Map<String,Object> writeFav(CommunityFavVO fav, HttpSession session){
		logger.debug("<<부모글 좋아요 등록-------------------->> : " + fav);

		Map<String,Object> mapJson = new HashMap<String,Object>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {//로그인이 안되어 있으면
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());

			logger.debug("<<부모글 좋아요 등록>> : " + fav);

			CommunityFavVO communityFav = communityService.selectFav(fav);
			logger.debug("<<lf_num>> : " + fav.getLf_num());


			//게시판 정보(누가 만든 게시판인지 확인하기 위해)
			CommunityVO communityVO = communityService.selectCommunity(fav.getLf_num());

			//초기화 필수
			CommunityAlarmVO alarm = new CommunityAlarmVO();

			alarm.setMem_num(communityVO.getMem_num());
			alarm.setAl_type(0);
			alarm.setRe_num(-1);
			alarm.setLf_num(fav.getLf_num());
			alarm.setMem_id(user.getMem_id());

			if(communityFav!=null) {//좋아요 등록된 상태
				communityService.deleteFav(communityFav.getFav_num());
				//알람 데이터 삭제
				communityService.deleteAlarmFav(communityFav.getLf_num());
				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
			}else {
				//좋아요 미등록이면 등록
				communityService.insertFav(fav);

				//알람 데이터 생성
				//본인 게시판에 좋아요 누르면 알림 x
				if(communityVO.getMem_num() != user.getMem_num()) {
					communityService.insertAlarm(alarm);
				}
				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
			}

			mapJson.put("count", communityService.selectFavCount(fav.getLf_num()));
		}

		return mapJson;
	} 

	//댓글 등록
	@RequestMapping("/community/writeReply.do")
	@ResponseBody//json
	public Map<String,String> writeReply(CommunityReplyVO vo, HttpSession session, HttpServletRequest request){
		logger.debug("<<댓글 등록>> : " + vo);

		Map<String,String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		//댓글 내용
		String recontent = vo.getRe_content();
		int a = recontent.indexOf("@");
		int b = recontent.lastIndexOf("@");

		//mem_num이 없으면 -1로 들어간다
		int mem_num = -1;

		if(a != -1 && b != -1 && a != b) {
			//태그한 아이디 값
			String id = recontent.substring(a+1, b);

			logger.debug("<<처음 인덱스 값 a>> : " + a);
			logger.debug("<<마지막 인덱스 값 b>> : " + b);
			logger.debug("<<@사이의 recontent 값>> : " + id);

			//태그에 들어간 아이디 여부 확인
			mem_num = communityService.selectMember(id);
		}
		if(user==null) {
			//로그인 안됨
			mapJson.put("result", "logout");
		}else {
			//회원번호 등록
			vo.setMem_num(user.getMem_num());
			//댓글 등록
			communityService.insertReply(vo);
			//vo 초기화
			CommunityAlarmVO alarm = new CommunityAlarmVO();

			//최신 댓글
			int re_num = communityService.nowre_num();
			//자신 태그는 알림 불가능
			if(mem_num > 0 && mem_num != user.getMem_num()) {
				alarm.setMem_num(mem_num);
				alarm.setAl_type(1);
				alarm.setRe_num(re_num);
				alarm.setLf_num(vo.getLf_num());
				alarm.setMem_id(user.getMem_id());
				communityService.insertAlarm(alarm);
			}
			logger.debug("<<글쓰기 확인--------------1>> : ");
			//게시판 정보(누가 만든 게시판인지 확인하기 위해)
			CommunityVO communityVO = communityService.selectCommunity(vo.getLf_num());
			logger.debug("<<글쓰기 확인--------------2>> : " + vo.getLf_num());

			//내가 등록한 댓글은 알림x
			if(communityVO.getMem_num() != user.getMem_num()) {
				alarm.setMem_num(communityVO.getMem_num());
				alarm.setAl_type(2);
				alarm.setRe_num(re_num);
				alarm.setLf_num(vo.getLf_num());
				alarm.setMem_id(user.getMem_id());
				//알람 데이터 생성
				logger.debug("<<글쓰기 확인--------------3>> : ");
				communityService.insertAlarm(alarm);
				logger.debug("<<글쓰기 확인--------------4>> : ");
			}

			mapJson.put("result", "success");
		}
		return mapJson;
	}

	//댓글 목록
	@RequestMapping("/community/listReply.do")
	@ResponseBody//json
	public Map<String,Object> getList(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
			@RequestParam int lf_num, HttpSession session){
		logger.debug("<<currentPage>> : " + currentPage);


		Map<String,Object> map = new HashMap<String,Object>();
		map.put("lf_num", lf_num);

		//총 글의 개수
		int count = communityService.selectCountReply(map);
		int rowCount = 20;

		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage,count,rowCount,1,null);

		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());

		//목록 데이터 읽기
		List<CommunityReplyVO> list = null;
		if(count > 0) {
			list = communityService.selectListReply(map);
		}else {
			list = Collections.emptyList();//비우다
		}
		System.out.println(19/rowCount);
		Map<String,Object> mapJson = new HashMap<String,Object>();
		mapJson.put("count", count);
		mapJson.put("rowCount", rowCount);
		mapJson.put("list", list);

		//=====로그인 한 회원정보 셋팅=====//
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user!=null) {
			mapJson.put("user_num",user.getMem_num());
		}

		return mapJson;
	}

	//=========댓글수정==========//
	@RequestMapping("/community/updateReply.do")
	@ResponseBody//json
	public Map<String,String> modifyReply(CommunityReplyVO communityReplyVO, HttpSession session, HttpServletRequest request){

		logger.debug("<<댓글 수정 communityReplyVO>> : " + communityReplyVO);

		Map<String,String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		CommunityReplyVO db_reply = communityService.selectReply(communityReplyVO.getRe_num());


		if(user==null) {
			//로그인이 안 되어있는 경우
			mapJson.put("result", "logout");
		}else if(user!=null && user.getMem_num()==db_reply.getMem_num()){//인증
			//로그인 회원번호화 작성자 회원번호 일치

			//알람 데이터 삭제
			communityService.deleteAlarmReply(communityReplyVO.getRe_num());

			//댓글 내용 태그 여부 확인
			String recontent = communityReplyVO.getRe_content();
			int a = recontent.indexOf("@");
			int b = recontent.lastIndexOf("@");

			//mem_num이 없으면 -1로 들어간다
			int mem_num = -1;

			//-1이면 @가 없다
			if(a != -1 && b!= -1) {
				//태그한 아이디 값
				String id = recontent.substring(a+1, b);

				logger.debug("<<댓글 수정 처음 인덱스 값 a>> : " + a);
				logger.debug("<<댓글 수정 마지막 인덱스 값 b>> : " + b);
				logger.debug("<<댓글 수정 @사이의 recontent 값>> : " + id);

				//태그에 들어간 아이디 여부 확인
				if(communityService.selectMember(id) !=-1 ) {
					mem_num = communityService.selectMember(id);
				}

			}

			//댓글 수정
			communityService.updateReply(communityReplyVO);

			//초기화 필수
			CommunityAlarmVO alarm = new CommunityAlarmVO();

			//게시판 정보(누가 만든 게시판인지 확인하기 위해)
			CommunityVO communityVO = communityService.selectCommunity(db_reply.getLf_num());

			//자신 태그는 알림 불가능
			if(mem_num > 0 && mem_num != user.getMem_num()) {
				alarm.setMem_num(mem_num);
				alarm.setAl_type(1);
				alarm.setRe_num(communityReplyVO.getRe_num());
				alarm.setLf_num(db_reply.getLf_num());
				alarm.setMem_id(user.getMem_id());
				communityService.insertAlarm(alarm);
			}

			if(communityVO.getMem_num() != user.getMem_num()) {
				alarm.setMem_num(communityVO.getMem_num());
				alarm.setAl_type(2);
				alarm.setRe_num(communityReplyVO.getRe_num());
				alarm.setLf_num(db_reply.getLf_num( ));
				alarm.setMem_id(user.getMem_id());

				//알람 데이터 생성
				communityService.insertAlarm(alarm);
			}
			mapJson.put("result", "success");

		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}

		return mapJson;
	}

	//=========댓글 삭제==============//
	@RequestMapping("/community/deleteReply.do")
	@ResponseBody//json
	public Map<String,String> deleteReply(@RequestParam int re_num, HttpSession session){
		logger.debug("<<댓글 삭제>> : " +re_num);

		Map<String,String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO)session.getAttribute("user");
		CommunityReplyVO db_reply = communityService.selectReply(re_num);

		if(user==null) {
			//로그인이 되어있지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null && user.getMem_num()==db_reply.getMem_num()) {
			//로그인 회원번호와 작성자 회원번호가 일치한 겨우
			communityService.deleteReply(re_num);
			//알람 데이터 삭제
			communityService.deleteAlarmReply(re_num);
			mapJson.put("result", "success");
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}

		return mapJson;
	}

	// ======읽지 않은 알림 개수=======//
	@RequestMapping("/community/alarmCountAjax.do")
	@ResponseBody // json
	public Map<String, Object> alarmCountAjax(HttpSession session) {

		MemberVO user = (MemberVO) session.getAttribute("user");
		Map<String, Object> mapAjax = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();

		int acount = communityService.alarmCount(user.getMem_num());
		logger.debug("<<알림개수>> : " + acount);

		//세션에 갯수 넣기
		session.setAttribute("acount", acount);
		mapAjax.put("result", "success");
		mapAjax.put("acount", acount);

		return mapAjax;
	}

	// ======알림 목록 ajax=======//
	@RequestMapping("/community/alarmListAjax.do")
	@ResponseBody // json
	public Map<String, Object> alarmListtAjax(HttpSession session) {

		MemberVO user = (MemberVO) session.getAttribute("user");
		Map<String, Object> mapAjax = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();

		int acount = communityService.alarmCount(user.getMem_num());
		logger.debug("<<알림개수>> : " + acount);
		
		List<CommunityAlarmVO> list = null;
		

			
		//map.put("start", page.getStartRow());
		//map.put("end", page.getEndRow());

		list = communityService.selectAllAlarm(user.getMem_num());

		
		//세션에 갯수 넣기
		session.setAttribute("acount", acount);
		mapAjax.put("list", list);
		mapAjax.put("result", "success");
		

		return mapAjax;
	}

	//알림 목록
	@RequestMapping("/community/alarmlist.do")
	public ModelAndView alarmprocess(HttpSession session) {
		Map<String,Object> map = new HashMap<String, Object>();

		//map.put("keyfield", keyfield);
		//map.put("keyword", keyword);
		//map.put("keyfield2", keyfield2);
		MemberVO user = (MemberVO) session.getAttribute("user");
		//읽음 처리 전 알림 갯수
		int bcount = communityService.selectCount(map);
		
		communityService.updateAlarm(user.getMem_num());
		//읽음 처리 후 알림 개수
		int acount = communityService.selectCount(map);
		
		//PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "/board/list.do");
		
		List<CommunityAlarmVO> list = null;
		
			//map.put("start", page.getStartRow());
			//map.put("end", page.getEndRow());

		list = communityService.selectAllAlarm(user.getMem_num());
		
		session.setAttribute("acount", acount);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("alarmlist");//타일스 설정 값
		//mav.addObject("keyfield", keyfield);//처음 검색값에 조회수순과 가나다순을 하기 위해
		//mav.addObject("keyword", keyword);
		mav.addObject("count", bcount);
		mav.addObject("list", list);
		//mav.addObject("page",page.getPage());

		return mav;
	}

	//알림 삭제
	@RequestMapping("/community/deleteAlarm.do")
	@ResponseBody//json
	public Map<String,String> deleteAlarm(@RequestParam int al_num, HttpSession session){
		logger.debug("<<알림 삭제>> : " +al_num);

		Map<String,String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO)session.getAttribute("user");

		CommunityAlarmVO db_alarm = communityService.selectAlarmDetail(al_num);

		if(user==null) {
			//로그인이 되어있지 않은 경우
			mapJson.put("result", "logout");
		}else if(user!=null && db_alarm.getMem_num() == user.getMem_num()){	
			//알람 데이터 삭제
			communityService.deleteAlarm(al_num);
			mapJson.put("result", "success");
		}else {
			//로그인 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}

		return mapJson;
	}

}
