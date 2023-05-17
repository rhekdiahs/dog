package kr.spring.community.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.community.vo.CommunityAlarmVO;
import kr.spring.community.vo.CommunityFavVO;
import kr.spring.community.vo.CommunityReplyVO;
import kr.spring.community.vo.CommunityVO;
import kr.spring.member.vo.MemberVO;

@Mapper
public interface CommunityMapper {
	//게시판
	//게시판 리스트
	public List<CommunityVO> selectList(Map<String, Object> map);
	//게시판 갯수
	public int selectCount(Map<String, Object> map);
	//게시판 상세보기
	@Select("SELECT * FROM lost_found l join member m using(mem_num) join member_detail d using(mem_num) "
			+ "WHERE l.lf_num=#{lf_num}")
	public CommunityVO selectCommunity(Integer lf_num);
	//조회수 증가
	@Update("UPDATE lost_found set lf_hit = lf_hit + 1 where lf_num = #{lf_num}")
	public void updateHit(Integer lf_num);
	//게시판 생성
	@Insert("INSERT INTO lost_found(lf_num, lf_title, lf_content, lf_imgsrc, lf_ufile, mem_num) "
			+ "VALUES(lost_found_seq.nextval, #{lf_title}, #{lf_content}, #{lf_imgsrc}, #{lf_ufile}, #{mem_num})")
	public void insertCommunity(CommunityVO community);
	//게시판 수정
	public void updateCommunity(CommunityVO community);
	//게시판 삭제
	@Delete("DELETE FROM lost_found where lf_num = #{lf_num}")
	public void deleteCommunity(Integer lf_num);
	//이미지 삭제
	@Update("UPDATE lost_found set lf_imgsrc='', lf_ufile='' where lf_num = #{lf_num}")
	public void deleteImage(Integer lf_num);

	//좋아요
	//좋아요한 게사판
	@Select("SELECT * FROM fav_lost_found where lf_num=#{lf_num} and mem_num=#{mem_num}")
	public CommunityFavVO selectFav(CommunityFavVO fav);
	//게시판 좋아요 갯수
	@Select("SELECT count(*) FROM fav_lost_found where lf_num=#{lf_num}")
	public int selectFavCount(Integer lf_num);
	//좋아요 추가하기
	@Insert("INSERT INTO fav_lost_found(fav_num, lf_num, mem_num) VALUES(fav_lost_found_seq.nextval, #{lf_num}, #{mem_num})")
	public void insertFav(CommunityFavVO fav);
	//좋아요 지우기
	@Delete("DELETE FROM fav_lost_found where fav_num=#{fav_num}")
	public void deleteFav(Integer fav_num);
	//게시판이 지워지면 좋아요 삭제
	@Delete("DELETE FROM fav_lost_found where lf_num=#{lf_num}")
	public void deleteFavByCommunityNum(Integer lf_num); 

	//댓글
	//댓글 리스트
	public List<CommunityReplyVO> selectListReply(Map<String,Object> map);
	//댓글 갯수
	@Select("SELECT count(*) FROM reply_lost_found join member using(mem_num) where lf_num=#{lf_num}")
	public int selectCountReply(Map<String,Object> map);
	//댓글 정보
	@Select("SELECT * FROM reply_lost_found where re_num=#{re_num}")
	public CommunityReplyVO selectReply(Integer re_num);
	//댓글 추가
	@Insert("INSERT INTO reply_lost_found (re_num, re_content, lf_num, mem_num) "
			+ "VALUES(reply_lost_found_seq.nextval,#{re_content},#{lf_num},#{mem_num})")
	public void insertReply(CommunityReplyVO communityReply);
	//댓글 수정
	@Update("UPDATE reply_lost_found SET re_content=#{re_content}, re_modify_date=SYSDATE where re_num=#{re_num}")
	public void updateReply(CommunityReplyVO communityReply);
	//댓글 삭제
	@Delete("DELETE FROM reply_lost_found where re_num=#{re_num}")
	public void deleteReply(Integer re_num);
	//게시판이 지워지면 댓글 삭제
	@Delete("DELETE FROM reply_lost_found where lf_num=#{lf_num}")
	public void deleteReplyByCommunityNum(Integer lf_num);

	//최신 댓글
	@Select("SELECT re_num FROM (select re_num from reply_lost_found order by re_date desc) where rownum = 1")
	public int nowre_num();
	//수정한 최신 댓글
	@Select("SELECT re_num FROM (select re_num from reply_lost_found order by re_modify_date desc) where rownum = 1")
	public int modifyre_num();
	
	//댓글, 태그 좋아요 알림
	//알림 갯수
	@Select("SELECT count(*) FROM alarmcount where mem_num=#{mem_num} AND al_read = 1")
	public int alarmCount(Integer mem_num);
	//알림 생성 문제점 re_num을 가지고 올 수 없다
	@Insert("INSERT INTO alarmcount (al_num, al_type, re_num, mem_num, lf_num, mem_id) "
			+ "VALUES (alarmcount_seq.nextval, #{al_type}, #{re_num}, #{mem_num}, #{lf_num}, #{mem_id})")
	public void insertAlarm(CommunityAlarmVO alarm);

	//안읽은 알림 목록
	public List<CommunityAlarmVO> selectAlarm(Integer mem_num);
	//전체 알림 목록
	public List<CommunityAlarmVO> selectAllAlarm(Integer mem_num);

	//알림 상세
	@Select("SELECT * FROM alarmcount where al_num = #{al_num}")
	public CommunityAlarmVO selectAlarmDetail(Integer al_num);
	
	
	//알림 읽음 처리
	@Update("UPDATE alarmcount SET al_read = 0 where mem_num=#{mem_num}")
	public void updateAlarm(Integer mem_num);
	//알림 삭제
	//게시판 삭제, 댓글 수정 또는 삭제, 좋아요 취소, 태그 삭제, 알림 삭제
	@Delete("DELETE FROM alarmcount where re_num = #{re_num}")
	public void deleteAlarmReply(Integer re_num);
	@Delete("DELETE FROM alarmcount where lf_num = #{lf_num}")
	public void deleteAlarmCommunity(Integer lf_num);
	@Delete("DELETE FROM alarmcount where lf_num = #{lf_num} AND al_type=0")
	public void deleteAlarmFav(Integer lf_num);
	@Delete("DELETE FROM alarmcount where al_num = #{al_num}")
	public void deleteAlarm(Integer al_num);
	
	//아이디 존재 여부 확인
	//어이디가 없으면 값을 -1로 바꾼다
	@Select("SELECT nvl(avg(mem_num), -1) FROM member where mem_id=#{mem_id}")
	public int selectMember(String mem_id);





















}
