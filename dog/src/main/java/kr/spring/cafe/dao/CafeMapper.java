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
	@Select("SELECT * FROM "
		  + "cafe c LEFT OUTER JOIN cafe_detail d "
		  + "ON c.cafe_num = d.cafe_num WHERE c.cafe_num = #{cafe_num}")
	public CafeVO selectCafedetail(Integer cafe_num);
	
	
	//카페 등록
	@Select("SELECT cafe_seq.nextval FROM dual")
	public int selectCafe_num();
	
	@Insert("INSERT INTO cafe (cafe_num, cafe_region, cafe_addr1, cafe_cate,"
			+ "cafe_x, cafe_y, cafe_name, cafe_phone, cafe_site, cafe_addr2) VALUES "
			+ "(#{cafe_num}, #{cafe_region}, #{cafe_addr1}, #{cafe_cate}, #{cafe_x}, #{cafe_y}, "
			+ "#{cafe_name}, #{cafe_phone}, #{cafe_site}, #{cafe_addr2})")
	public void insertCafe(CafeVO cafe);
	
	@Insert("INSERT INTO cafe_detail (cafe_detail_num, cafe_num, mem_num, cafe_content, cafe_status,"
		  + " cafe_image_name, cafe_image) VALUES (cafe_detail_seq.nextval, #{cafe_num}, #{mem_num}, "
		  + "#{cafe_content}, 0, #{cafe_image_name}, #{cafe_image})")
	public void insertCafeDetail(CafeVO cafe);
	
	
	@Update("UPDATE cafe SET cafe_x = ${coord_x}, cafe_y = ${coord_y} WHERE cafe_num = ${hospital_num}")
	public void updateCoords(@Param(value="coord_x") String coord_x, 
			                @Param(value="coord_y") String coord_y,
			                @Param(value="hospital_num") Integer hospital_num);
	
	
	//관리자
	//카페 관리
	//승인 요청 개수
	public List<CafeVO> selectCafeAdminList(Map<String, Object> map);
		
		
	//승인 요청 리스트
	public int selectCafeAdminCount(Map<String, Object> map);
	
	
}
