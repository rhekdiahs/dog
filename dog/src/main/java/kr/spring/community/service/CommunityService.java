package kr.spring.community.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.community.vo.CommunityAlarmVO;
import kr.spring.community.vo.CommunityFavVO;
import kr.spring.community.vo.CommunityReplyVO;
import kr.spring.community.vo.CommunityVO;
import kr.spring.member.vo.MemberVO;

public interface CommunityService {
	//게시판 리스트
		public List<CommunityVO> selectList(Map<String, Object> map);
		//게시판 갯수
		public int selectCount(Map<String, Object> map);
		//게시판 상세보기
		public CommunityVO selectCommunity(Integer lf_num);
		//조회수 증가
		public void updateHit(Integer lf_num);
		//게시판 생성
		public void insertCommunity(CommunityVO community);
		//게시판 수정
		public void updateCommunity(CommunityVO community);
		//게시판 삭제
		public void deleteCommunity(Integer lf_num);
		//이미지 삭제
		public void deleteImage(Integer lf_num);
		
		//좋아요
		//좋아요한 게사판
		public CommunityFavVO selectFav(CommunityFavVO fav);
		//게시판 좋아요 갯수
		public int selectFavCount(Integer lf_num);
		//좋아요 추가하기
		public void insertFav(CommunityFavVO fav);
		//좋아요 지우기
		public void deleteFav(Integer fav_num);
		
		
		//댓글
		//댓글 리스트
		public List<CommunityReplyVO> selectListReply(Map<String,Object> map);
		//댓글 갯수
		public int selectCountReply(Map<String,Object> map);
		//댓글 정보
		public CommunityReplyVO selectReply(Integer re_num);
		//댓글 추가
		public void insertReply(CommunityReplyVO communityReply);
		//댓글 수정
		public void updateReply(CommunityReplyVO communityReply);
		//댓글 삭제
		public void deleteReply(Integer re_num);
		//최신 댓글
		public int nowre_num();
		//수정한 최신 댓글
		public int modifyre_num();
		
		//알림
		//알림 갯수
		public int alarmCount(Integer mem_num);
		//알림 생성
		public void insertAlarm(CommunityAlarmVO alarm);
		//않읽은 알림 표시
		public List<CommunityAlarmVO> selectAlarm(Integer mem_num);
		//알림 읽음 처리
		public void updateAlarm(Integer mem_num);
		
		//알림 상세		
		public CommunityAlarmVO selectAlarmDetail(Integer al_num);
		//전체 알림 목록
		public List<CommunityAlarmVO> selectAllAlarm(Integer mem_num);
		//알림 삭제
		//게시판 삭제, 댓글 수정 또는 삭제, 좋아요 취소, 알림 삭제
		public void deleteAlarmReply(Integer re_num);
		public void deleteAlarmCommunity(Integer lf_num);
		public void deleteAlarmFav(Integer fav_num);
		public void deleteAlarm(Integer al_num);
		//아이디 존재 여부 확인
		public int selectMember(String mem_id);
}
