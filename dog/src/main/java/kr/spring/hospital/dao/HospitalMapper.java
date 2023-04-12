package kr.spring.hospital.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.hospital.vo.HospitalVO;

@Mapper
public interface HospitalMapper {
	/*=================================
	  			 모은 데이터 추출
	 ==================================*/
	@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE d.h_info_num IS NULL")
	public List<HospitalVO> selectStoredHosList();
	
	@Select("SELECT * FROM hospital h LEFT OUTER JOIN hospital_detail d ON h.hospital_num = d.hospital_num WHERE d.h_info_num IS NOT NULL")
	public List<HospitalVO> selectInsertedHosList();
	/*=================================
	   		 	회원이 데이터 등록
	==================================*/

}
