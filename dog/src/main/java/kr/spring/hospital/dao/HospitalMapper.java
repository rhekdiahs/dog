package kr.spring.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.hospital.vo.HospitalVO;

@Mapper
public interface HospitalMapper {
	/*=================================
	  			 모은 데이터 추출
	 ==================================*/
	@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE d.h_info_num IS NULL AND LENGTH(coord_x) <= 12")
	public List<HospitalVO> selectStoredHosList();
	
	@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE d.h_info_num IS NOT NULL")
	public List<HospitalVO> selectInsertedHosList();
	
	@Update("UPDATE hospital SET coord_x = ${coord_x}, coord_y = ${coord_y} WHERE hospital_num = ${hospital_num}")
	public void updateCoords(@Param(value="coord_x") String coord_x, 
			                @Param(value="coord_y") String coord_y,
			                @Param(value="hospital_num") Integer hospital_num);
	/*=================================
	   		 	회원이 데이터 등록
	==================================*/

}
