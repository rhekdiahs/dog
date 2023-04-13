package kr.spring.hospital.service;

import java.util.List;


import kr.spring.hospital.vo.HospitalVO;


public interface HospitalService {
	
	public List<HospitalVO> selectStoredHosList();
	
	public List<HospitalVO> selectInsertedHosList();
	
	public void updateCoords(String coord_x, String coord_y, Integer hospital_num);
}
