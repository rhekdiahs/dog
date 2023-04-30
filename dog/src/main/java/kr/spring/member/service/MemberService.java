package kr.spring.member.service;

import java.util.List;
import java.util.Map;


import kr.spring.member.vo.MemberVO;

public interface MemberService {
	
	//회원가입
	public void insertMember(MemberVO member);
	
	//아이디 중복체크
	public MemberVO selectCheckMember(String mem_id);
	
	//카카오 로그인 확인
	public MemberVO selectKakaoCheck(String kakao_email);
	
	//아이디 찾기
	public String[] find_id(String mem_name, String mem_email);
	//비밀번호 찾기
	public String find_pw(String mem_id, String mem_email);
	
	
	//회원관리
	public List<MemberVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void updateByAdmin(MemberVO memberVO);
	
	//마이페이지
	public MemberVO getMemInfo(Integer mem_num);
}
