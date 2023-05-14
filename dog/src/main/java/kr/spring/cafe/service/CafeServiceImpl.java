package kr.spring.cafe.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.cafe.dao.CafeMapper;
import kr.spring.cafe.vo.CafeVO;
import kr.spring.hospital.vo.UpdateVO;

@Service
@Transactional
public class CafeServiceImpl implements CafeService{
	
	@Autowired
	private CafeMapper cafeMapper;
	
	
	@Override
	public List<CafeVO> selectCafeList(Map<String, Object> map) {
	  return cafeMapper.selectCafeList(map);
	}
	 
	

	@Override
	public int selectCafeCount(Map<String, Object> map) {
		return cafeMapper.selectCafeCount(map);
	}
	
	@Override
	public CafeVO selectCafedetail(Integer cafe_num) {
		return cafeMapper.selectCafedetail(cafe_num);
	}

	@Override
	public void insertCafeDetail(CafeVO cafeVO) {
		cafeVO.setCafe_num(cafeMapper.selectCafe_num());
		cafeMapper.insertCafe(cafeVO);
		cafeMapper.insertCafeDetail(cafeVO);
		
	}

	@Override
	public void updateCoords(String coord_x, String coord_y, Integer hospital_num) {
		cafeMapper.updateCoords(coord_x, coord_y, hospital_num);
	}



	@Override
	public List<CafeVO> selectCafeAdminList(Map<String, Object> map) {
		return cafeMapper.selectCafeAdminList(map);
	}



	@Override
	public int selectCafeAdminCount(Map<String, Object> map) {
		return cafeMapper.selectCafeAdminCount(map);
	}



	@Override
	public void updateInfo(UpdateVO update) {
		cafeMapper.updateInfo(update);
		
	}
}
