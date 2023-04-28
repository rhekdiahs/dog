package kr.spring.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.member.vo.MemberVO;

@Mapper
public interface MyPageMapper {
/*======================
  		PROFILE	
 =======================*/
	//회원정보 가져오기
	@Select("select * from MEMBER_detail WHERE mem_num=${mem_num}")
	public MemberVO getMemInfo(Integer mem_num);
	
/*======================
  		BOOKMARK	
 =======================*/
	//북마크해논 목록 갯수 가져오기
	@Select("SELECT COUNT(*) FROM BOOKMARK_MAP WHERE mem_num=${mem_num}")
	public Integer getBookmarkCount(Integer mem_num);
	
	//카테고리별 북마크 갯수
	public Integer getBookmarkCountByCategories(Map<String, Object> map);
	
	//카테고리별 리스트 불러오기
	public List<BookmarkVO> getBookmarkListByCategories(Map<String, Object> map);
	
/*======================
  	  DELETE ACCOUNT	
 =======================*/
	//회원탈퇴
	@Update("UPDATE MEMBER SET mem_auth=0 WHERE mem_num=#{mem_num}")
	public void changeAuth(Integer mem_num);
	
	@Delete("DELETE FROM MEMBER_DETAIL WHERE mem_num = ${mem_num}")
	public void deleteAcoount(Integer mem_num);
}
