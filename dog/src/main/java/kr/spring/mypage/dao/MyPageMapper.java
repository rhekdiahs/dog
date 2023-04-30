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
	
	//프로필 사진 정보 입력
	@Update("UPDATE MEMBER_DETAIL SET mem_name=#{mem_name}, mem_intro=#{mem_intro}, mem_photo=#{mem_photo}, mem_photo_name = #{mem_photo_name} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);
	
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
	//회원 상태 탈퇴로 변경
	@Update("UPDATE MEMBER SET mem_auth=0 WHERE mem_num=#{mem_num}")
	public void changeAuth(Integer mem_num);
	
	//해당 회원의 상세정보는 모두 삭제
	@Delete("DELETE FROM MEMBER_DETAIL WHERE mem_num = ${mem_num}")
	public void deleteAcoount(Integer mem_num);
	
	//해당 회원이 북마크 해놨던 정보도 삭제
	@Delete("DELETE FROM BOOKMARK_MAP WHERE mem_num=${mem_num}")
	public void deleteBookmark(Integer mem_num);
}
