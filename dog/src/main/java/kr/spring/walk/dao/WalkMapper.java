package kr.spring.walk.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.walk.vo.WalkVO;

@Mapper
public interface WalkMapper {
	//산책경로 등록
	@Insert("INSERT INTO WALK (walk_num,walk_region,walk_position,mem_id) VALUES (walk_seq.nextval,#{walk_region},#{walk_position},#{mem_id})")
	public void regsiterWalk(WalkVO walk);
	
	//산책경로 리스트 뽑기
	@Select("SELECT * FROM WALK")
	public List<WalkVO> getWalkList();
	
	//좌표 불러오기
	@Select("SELECT walk_position FROM WALK WHERE walk_num=#{walk_num}")
	public String getWalkPosition(Integer walk_num);
	//산책경로 정보 불러오기(회원 이름도 같이 불러와야함)
	
	//북마크(?) 어떻게 해야함 ..
}
