package kr.spring.walk.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.walk.vo.WalkVO;

@Mapper
public interface WalkMapper {
/*===========================================
				INSERT DATA
  =========================================*/
	//산챙경로 번호 생성
	@Select("SELECT walk_seq.nextval FROM DUAL")
	public int selectWalkNum();
	
	//산책경로 대표정보 등록
	@Insert("INSERT INTO WALK (walk_num,walk_region,walk_position,mem_name,walk_distance) VALUES (#{walk_num},#{walk_region},#{walk_position},#{mem_name},#{walk_distance})")
	public void regsiterWalk(WalkVO walk);
	
	//산책경로 상세정보 등록
	@Insert("INSERT INTO WALK_DETAIL (walk_detail_num, walk_num, mem_num, walk_img, walk_img_name, walk_info, walk_address) VALUES (walk_detail_seq.nextval, #{walk_num},#{mem_num},#{walk_img},#{walk_img_name},#{walk_info},#{walk_address})")
	public void registerWalkDetail(WalkVO walk);
	
/*===========================================
 				GET DATA
  =========================================*/
	//좌표 불러오기
	@Select("SELECT walk_position FROM WALK WHERE walk_num=#{walk_num}")
	public String getWalkPosition(Integer walk_num);
	
	//산책경로 리스트 뽑기
	@Select("SELECT * FROM WALK w JOIN WALK_DETAIL d ON w.walk_num = d.walk_num WHERE w.walk_num=#{walk_mum}")
	public WalkVO getWalkList(int walk_num);

	//해당 지역의 경로 갯수
	public Integer getListCount(Map<String, Object> map);
	
	//지역별 리스트 가져오기
	public List<WalkVO> getListByRegion(Map<String, Object> map);
	
	//회원 이름 가져오기
	@Select("SELECT mem_name FROM MEMBER_DETAIL WHERE mem_num=${mem_num}")
	public String getName(int mem_num);
}
