package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import kr.spring.cafe.vo.CafeVO;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.walk.vo.WalkVO;

public interface AdminService {
	
	public List<MemberVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	public void updateByAdmin(MemberVO memberVO);
	public void updateCafeStatus(CafeVO cafeVO);
	public void updateHosStatus(HospitalVO hospitalVO);
	public void updateWalkStatus(WalkVO walkVO);
}
