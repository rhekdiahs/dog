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
	@Insert("INSERT INTO WALK (walk_num,walk_region,walk_position,mem_id,walk_distance) VALUES (walk_seq.nextval,#{walk_region},#{walk_position},#{mem_id},#{walk_distance})")
	public void regsiterWalk(WalkVO walk);
	
	//산책경로 상세정보 등록
	@Insert("INSERT INTO WALK_DETAIL")
	public void registerWalkDetail(WalkVO walk);
	
/*===========================================
 				GET DATA
  =========================================*/
	//좌표 불러오기
	@Select("SELECT walk_position FROM WALK WHERE walk_num=#{walk_num}")
	public String getWalkPosition(Integer walk_num);
	
	//산책경로 리스트 뽑기
	@Select("SELECT * FROM WALK")
	public List<WalkVO> getWalkList();

	//해당 지역의 경로 갯수
	public Integer getListCount(Map<String, Object> map);
	
	//지역별 리스트 가져오기
	public List<WalkVO> getListByRegion(Map<String, Object> map);
}
