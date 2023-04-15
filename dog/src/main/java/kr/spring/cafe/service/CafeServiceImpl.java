package kr.spring.cafe.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.cafe.dao.CafeMapper;
import kr.spring.cafe.vo.CafeVO;

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
	public int selectCafedetailnum() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertCafeDetail(CafeVO cafeVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCoords(String coord_x, String coord_y, Integer hospital_num) {
		cafeMapper.updateCoords(coord_x, coord_y, hospital_num);
	}

	/*
		@Override
		public List<CafeVO> selectCafeList() {
			return cafeMapper.selectCafeList();
		}
	*/
}
