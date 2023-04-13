package kr.spring.walk.service;

import kr.spring.walk.vo.WalkVO;

public interface WalkService {
	//db에 좌표 등록
	public void insertPoints(WalkVO walk);
}
