package kr.spring.walk.service;

import java.util.List;
import java.util.Map;

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
	public void insertWalkInfoAll(WalkVO walk) {
		walk.setWalk_num(walkMapper.selectWalkNum());
		walkMapper.regsiterWalk(walk);
		walkMapper.registerWalkDetail(walk);
	}

	@Override
	public WalkVO getWalkList(int walk_num) {
		return walkMapper.getWalkList(walk_num);
	}

	@Override
	public String getWalkPosition(Integer walk_num) {
		return walkMapper.getWalkPosition(walk_num);
	}

	@Override
	public Integer getListCount(Map<String, Object> map) {
		return walkMapper.getListCount(map);
	}

	@Override
	public List<WalkVO> getListByRegion(Map<String, Object> map) {
		return walkMapper.getListByRegion(map);
	}

	@Override
	public String getName(int mem_num) {
		return walkMapper.getName(mem_num);
	}
	
	
}
