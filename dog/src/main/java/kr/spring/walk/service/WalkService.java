package kr.spring.walk.service;

import java.util.List;
import java.util.Map;

import kr.spring.walk.vo.WalkVO;

public interface WalkService {
	//db에 좌표 등록
	public void insertWalkInfoAll(WalkVO walk);
	
	//산책경로 리스트 뽑기
	public List<WalkVO> getWalkList();
	
	//좌표 뽑기
	public String getWalkPosition(Integer walk_num);
	
	//해당 지역 리스트 갯수
	public Integer getListCount(Map<String, Object> map);
	
	//해당 지역의 리스트 뽑기
	public List<WalkVO> getListByRegion(Map<String, Object> map);
	
	//회원이름 가져와
	public String getName(int mem_num);
}
