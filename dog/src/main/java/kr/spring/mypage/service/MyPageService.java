package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.member.vo.MemberVO;

public interface MyPageService {
	//회원 정보 싸그리 가져오기
	public MemberVO getMemInfo(Integer mem_num);
	
	//회원탈퇴
	public void deleteAccount(Integer mem_num);
	
	//북마크 해논 게시물 갯수
	public Integer getBookmarkCount(Integer mem_num);
	
	//카테고리별 리스트
	public List<BookmarkVO> getBookmarkListByCategories(Map<String, Object> map);
	
	public Integer getBookmarkCountByCategories(Map<String, Object> map);
	
	public void updateProfile(MemberVO member);
}
