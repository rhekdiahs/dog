package kr.spring.cafe.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.cafe.vo.CafeVO;

@Mapper
public interface CafeMapper {
	
	//카페 목록
	public List<CafeVO> selectCafeList(Map<String, Object> map);
	
	//@Select("SELECT * FROM cafe WHERE cafe_x is null")
	//public List<CafeVO> selectCafeList();
	
	//카페 목록 개수
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
	
	@Update("UPDATE cafe SET cafe_x = ${coord_x}, cafe_y = ${coord_y} WHERE cafe_num = ${hospital_num}")
	public void updateCoords(@Param(value="coord_x") String coord_x, 
			                @Param(value="coord_y") String coord_y,
			                @Param(value="hospital_num") Integer hospital_num);
}
