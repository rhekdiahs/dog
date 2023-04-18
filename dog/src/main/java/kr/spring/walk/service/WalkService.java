package kr.spring.walk.service;

import java.util.List;

import kr.spring.walk.vo.WalkVO;

public interface WalkService {
	//db에 좌표 등록
	public void insertPoints(WalkVO walk);
	//산책경로 리스트 뽑기
	public List<WalkVO> getWalkList();
	//좌표 뽑기
	public String getWalkPosition(Integer walk_num);
}
