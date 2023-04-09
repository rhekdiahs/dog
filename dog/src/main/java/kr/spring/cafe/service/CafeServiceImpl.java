package kr.spring.cafe.service;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.cafe.vo.CafeVO;

@Service
@Transactional
public class CafeServiceImpl implements CafeService{

	@Override
	public int selectCafeCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
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
	
}
