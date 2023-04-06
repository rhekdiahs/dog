package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	
	//회원가입
	public void insertMember(MemberVO member);
	
	//아이디 중복체크
	public MemberVO selectCheckMember(String mem_id);
}