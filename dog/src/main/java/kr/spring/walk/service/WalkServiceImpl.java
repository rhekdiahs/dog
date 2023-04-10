package kr.spring.walk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.walk.dao.WalkMapper;

@Service
@Transactional
public class WalkServiceImpl implements WalkService{
	@Autowired
	private WalkMapper walkMapper;
}
