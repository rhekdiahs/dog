package kr.spring.hospital.service;

import java.util.List;
import java.util.Map;

import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.hospital.vo.HospitalVO;


public interface HospitalService {
	
	public List<HospitalVO> selectStoredHosList(Map<String, Object> map);
	
	public List<HospitalVO> selectInsertedHosList();
	
	public void updateCoords(String coord_x, String coord_y, Integer hospital_num);
	
	public int selectRegionListCount(Map<String, Object> map);
	
	public HospitalVO selectHospital(Integer hospital_num);
	
	public void insertHospitalDetail(HospitalVO hospital);
	//북마크
	public Integer selectBookmark(BookmarkVO bookmark);
	
	public void deleteBookmark(BookmarkVO bookmark);
	
	public void insertBookmark(BookmarkVO bookmark);
}
