package kr.spring.walk.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.walk.dao.WalkMapper;
import kr.spring.walk.vo.WalkVO;

@Service
@Transactional
public class WalkServiceImpl implements WalkService{
	@Autowired
	private WalkMapper walkMapper;

	@Override
	public void insertPoints(WalkVO walk) {
		walkMapper.regsiterWalk(walk);
	}

	@Override
	public List<WalkVO> getWalkList() {
		return walkMapper.getWalkList();
	}

	@Override
	public String getWalkPosition(Integer walk_num) {
		return walkMapper.getWalkPosition(walk_num);
	}
	
	
}
