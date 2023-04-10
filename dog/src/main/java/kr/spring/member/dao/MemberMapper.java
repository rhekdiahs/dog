package kr.spring.member.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	/*=================================
	  			   회원가입
	 ==================================*/
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	
	@Insert("INSERT INTO member (mem_num, mem_id) VALUES (#{mem_num}, #{mem_id})")
	public void insertMember(MemberVO member);
	
	@Insert("INSERT INTO member_detail (mem_num, mem_name, mem_pw, mem_phone, mem_email, mem_kakao) VALUES (#{mem_num}, #{mem_name}, #{mem_pw}, #{mem_phone}, #{mem_email}, #{mem_kakao})")
	public void insertMember_detail(MemberVO member);
	
	@Select("SELECT m.mem_num, m.mem_id, m.mem_auth, d.mem_pw, d.mem_email FROM member m LEFT OUTER JOIN member_detail d ON m.mem_num = d.mem_num WHERE m.mem_id = #{mem_id}")
	public MemberVO selectCheckMember(String mem_id);

	/*=================================
	   		 	카카오 회원가입
	==================================*/
	@Select("SELECT m.mem_num,m.mem_id,d.mem_pw FROM member m LEFT OUTER JOIN member_detail d ON m.mem_num = d.mem_num WHERE d.mem_kakao=#{mem_kakao}")
	public MemberVO selectKakaoCheck(String kakao_email);
}
