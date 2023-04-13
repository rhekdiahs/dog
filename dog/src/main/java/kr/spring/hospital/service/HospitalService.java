package kr.spring.hospital.service;

import java.util.List;
import java.util.Map;

import kr.spring.hospital.vo.HospitalVO;


public interface HospitalService {
	
	public List<HospitalVO> selectStoredHosList(Map<String, Object> map);
	
	public List<HospitalVO> selectInsertedHosList();
	
	public void updateCoords(String coord_x, String coord_y, Integer hospital_num);
	
	public int selectRegionListCount(Map<String, Object> map);
	
	
}
