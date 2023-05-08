package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.admin.dao.AdminMapper;
import kr.spring.cafe.vo.CafeVO;
import kr.spring.hospital.vo.HospitalVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.walk.vo.WalkVO;

@Service
@Transactional
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminMapper adminMapper;

	@Override
	public List<MemberVO> selectList(Map<String, Object> map) {
		return adminMapper.selectList(map);
	}


	@Override
	public int selectRowCount(Map<String, Object> map) {
		return adminMapper.selectRowCount(map);
	}

	@Override
	public void updateByAdmin(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void updateCafeStatus(CafeVO cafeVO) {
		adminMapper.updateCafeStatus(cafeVO);
		
	}


	@Override
	public void updateHosStatus(HospitalVO hospitalVO) {
		adminMapper.updateHosStatus(hospitalVO);
		
	}


	@Override
	public void updateWalkStatus(WalkVO walkVO) {
		adminMapper.updateWalkStatus(walkVO);
		
	}


	@Override
	public List<HospitalVO> selectHosAdminList(Map<String, Object> map) {
		return adminMapper.selectHosAdminList(map);
	}


	@Override
	public int selectHosAdminCount(Map<String, Object> map) {
		return adminMapper.selectHosAdminCount(map);
	}


	@Override
	public List<WalkVO> selectWalkAdminList(Map<String, Object> map) {
		return adminMapper.selectWalkAdminList(map);
	}


	@Override
	public int selectWalkAdminCount(Map<String, Object> map) {
		return adminMapper.selectHosAdminCount(map);
	}

	
}
