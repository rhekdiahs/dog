package kr.spring.cafe.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.spring.cafe.vo.CafeVO;

public interface CafeService {
	
	//카페 목록
	public List<CafeVO> selectCafeList(Map<String, Object> map);
	
	//public List<CafeVO> selectCafeList();
	
	//카페 목록 개수
	public int selectCafeCount(Map<String, Object> map);
	
	//카페 상세
	public CafeVO selectCafedetail(Integer cafe_num);
	
	//카페 등록
	public void insertCafeDetail(CafeVO cafeVO);
	
	public void updateCoords(String coord_x,String coord_y,
             				 Integer hospital_num);
	
	
	//관리자
	//카페 관리
	//승인 요청 개수
	public List<CafeVO> selectCafeAdminList(Map<String, Object> map);
		
		
	//승인 요청 리스트
	public int selectCafeAdminCount(Map<String, Object> map);
	
}
