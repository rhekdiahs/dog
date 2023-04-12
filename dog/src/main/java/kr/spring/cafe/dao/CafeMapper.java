package kr.spring.cafe.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cafe.vo.CafeVO;

@Mapper
public interface CafeMapper {
	
	//카페 목록
	public int selectCafeCount(Map<String, Object> map);
	
	//카페 상세
	@Select("SELECT cafe_detail_seq.nextval FROM dual")
	public int selectCafedetailnum();
	
	//카페 등록
	@Insert("INSERT INTO cafe_detail (cafe_detail_num,cafe_name,cafe_type, "
		  + "cafe_content,cafe_image_name,cafe_image,cafe_status,cafe_num,mem_num) "
		  + "VALUES (cafe_detail_seq.nextval,#{cafe_name},#{cafe_type},#{cafe_content},"
		  + "#{cafe_image_name},#{cafe_image},#{cafe_status},#{cafe_num},#{mem_num})")
	public void insertCafeDetail(CafeVO cafeVO);
	
	
}
