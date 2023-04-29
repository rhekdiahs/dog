package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.cafe.vo.CafeVO;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.walk.vo.WalkVO;

@Mapper
public interface AdminMapper {

	//회원 관리
	public List<MemberVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	@Update("UPDATE member SET mem_auth=#{mem_auth} WHERE mem_num=#{mem_num}")
	public void updateByAdmin(MemberVO memberVO);
	
	//카페 승인
	@Update("UPDATE cafe_detail SET cafe_status=1 WHERE cafe_num=#{cafe_num}")
	public void updateCafeStatus(CafeVO cafeVO);
	
	@Update("UPDATE hospital_detail SET h_info_auth=1 WHERE hospital_num=#{hospital_num}")
	public void updateHosStatus(HospitalVO hospitalVO);
	
	@Update("UPDATE walk_detail SET walk_perm=1 WHERE walk_num=#{walk_num}")
	public void updateWalkStatus(WalkVO walkVO);
	
}

