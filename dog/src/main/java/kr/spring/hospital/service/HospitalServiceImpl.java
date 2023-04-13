package kr.spring.hospital.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.hospital.dao.HospitalMapper;
import kr.spring.hospital.vo.HospitalVO;

@Service
@Transactional
public class HospitalServiceImpl implements HospitalService{

	@Autowired
	private HospitalMapper hospitalMapper;
	
	@Override
	public List<HospitalVO> selectStoredHosList() {
		return hospitalMapper.selectStoredHosList();
	}

	@Override
	public List<HospitalVO> selectInsertedHosList() {
		return hospitalMapper.selectInsertedHosList();
	}

	@Override
	public void updateCoords(String coord_x, String coord_y, Integer hospital_num) {
		hospitalMapper.updateCoords(coord_x, coord_y, hospital_num);
	}

}
