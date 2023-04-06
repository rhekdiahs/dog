package kr.spring.cafe.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.cafe.vo.CafeVO;

@Mapper
public interface CafeMapper {
	
	//카페 디테일 리스트
	@Select("SELECT cafe_detail_seq.nextval FROM dual")
	public int selectCafedetailnum();
	
	//카페 내용 입력
	@Insert("INSERT INTO cafe_detail (cafe_detail_num,cafe_name,cafe_type, "
		  + "cafe_content,cafe_image_name,cafe_image,cafe_status,cafe_num,mem_num) "
		  + "VALUES (cafe_detail_seq.nextval,#{cafe_name},#{cafe_type},#{cafe_content},"
		  + "#{cafe_image_name},#{cafe_image},#{cafe_status},#{cafe_num},#{mem_num})")
	public void insertCafeDetail(CafeVO cafeVO);
	
	
	
}
