package kr.spring.cafe.service;

import java.util.Map;

import kr.spring.cafe.vo.CafeVO;

public interface CafeService {
	//카페 목록
	public int selectCafeCount(Map<String, Object> map);
	
	//카페 상세
	public int selectCafedetailnum();
	
	//카페 등록
	public void insertCafeDetail(CafeVO cafeVO);
	
}
