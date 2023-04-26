package kr.spring.hospital.service;

import java.util.List;
import java.util.Map;

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
	public List<HospitalVO> selectStoredHosList(Map<String, Object> map) {
		return hospitalMapper.selectStoredHosList(map);
	}

	@Override
	public List<HospitalVO> selectInsertedHosList() {
		return hospitalMapper.selectInsertedHosList();
	}

	@Override
	public void updateCoords(String coord_x, String coord_y, Integer hospital_num) {
		hospitalMapper.updateCoords(coord_x, coord_y, hospital_num);
	}

	@Override
	public int selectRegionListCount(Map<String, Object> map) {
		System.out.println(map.get("keyfield"));
		return hospitalMapper.selectRegionListCount(map);
	}

	@Override
	public HospitalVO selectHospital(Integer hospital_num) {
		return hospitalMapper.selectHospital(hospital_num);
	}

	@Override
	public void insertHospitalDetail(HospitalVO hospital) {
		hospital.setHospital_num(hospitalMapper.selectHospital_num());
		hospitalMapper.insertHospital(hospital);
		hospitalMapper.insertHospitalDetail(hospital);
	}
	
}
