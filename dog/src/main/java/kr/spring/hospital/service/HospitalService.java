package kr.spring.hospital.service;

import java.util.List;


import kr.spring.hospital.vo.HospitalVO;


public interface HospitalService {
	
	public List<HospitalVO> selectStoredHosList();
	
	public List<HospitalVO> selectInsertedHosList();
}
