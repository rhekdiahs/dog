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
	
	//승인 요청 리스트 조회(병원)
	public List<HospitalVO> selectHosAdminList(Map<String, Object> map);
	public int selectHosAdminCount(Map<String, Object> map);
		
	//승인 요청 리스트 조회(산책로)
	public List<WalkVO> selectWalkAdminList(Map<String, Object> map);
	public int selectWalkAdminCount(Map<String, Object> map);
}
