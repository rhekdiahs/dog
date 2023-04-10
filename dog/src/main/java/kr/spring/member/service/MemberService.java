package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	
	//회원가입
	public void insertMember(MemberVO member);
	
	//아이디 중복체크
	public MemberVO selectCheckMember(String mem_id);
	
	//카카오 로그인 확인
	public MemberVO selectKakaoCheck(String kakao_email);
}
