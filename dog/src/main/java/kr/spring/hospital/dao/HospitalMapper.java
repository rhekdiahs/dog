package kr.spring.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.hospital.vo.HospitalVO;

@Mapper
public interface HospitalMapper {
	/*=================================
	  			 모은 데이터 추출
	 ==================================*/
	//자리수 변환 안된거 리턴
	//@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE d.h_info_num IS NULL AND LENGTH(coord_x) <= 12")
	//public List<HospitalVO> selectStoredHosList();
	
	//@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE d.h_info_num IS NULL")
	
	public List<HospitalVO> selectStoredHosList(Map<String, Object> map);
	
	@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE d.h_info_num IS NOT NULL")
	public List<HospitalVO> selectInsertedHosList();
	
	@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE h.hospital_num = ${hospital_num}")
	public HospitalVO selectHospital(Integer hospital_num);
	
	@Update("UPDATE hospital SET coord_x = ${coord_x}, coord_y = ${coord_y} WHERE hospital_num = ${hospital_num}")
	public void updateCoords(@Param(value="coord_x") String coord_x, 
			                @Param(value="coord_y") String coord_y,
			                @Param(value="hospital_num") Integer hospital_num);
	
	public int selectRegionListCount(Map<String, Object> map);
	/*=================================
	   		 	회원이 데이터 등록
	==================================*/
	@Select("SELECT hospital_seq.nextval FROM dual")
	public int selectHospital_num();
	
	@Insert("INSERT INTO hospital (hospital_num, hospital_type, hospital_region, coord_x, coord_y, road, h_name, h_phone, h_address, h_link) VALUES (#{hospital_num}, #{hospital_type}, #{hospital_region}, #{coord_x}, #{coord_y}, #{road}, #{h_name}, #{h_phone}, #{h_address}, #{h_link})")
	public void insertHospital(HospitalVO hospital);
	
	@Insert("INSERT INTO hospital_detail (h_info_num, h_info_detail, h_info_auth, hospital_num, mem_num, h_info_image, h_info_image_name) VALUES(hospital_detail_seq.nextval, #{h_info_detail}, #{h_info_auth}, #{hospital_num}, #{mem_num}, #{h_info_image}, #{h_info_image_name})")
	public void insertHospitalDetail(HospitalVO hospital);
	
	
	//북마크
	public Integer selectBookmark(BookmarkVO bookmark);
	
	public void deleteBookmark(BookmarkVO bookmark);
	
	@Insert("INSERT INTO BOOKMARK_MAP VALUES(bookmark_map_seq.nextval,#{walk_num},#{hospital_num},#{cafe_num},#{mem_num},#{categories})")
	public void insertBookmark(BookmarkVO bookmark);

}
