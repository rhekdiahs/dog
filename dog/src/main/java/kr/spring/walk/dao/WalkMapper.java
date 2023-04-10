package kr.spring.walk.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import kr.spring.walk.vo.WalkVO;

@Mapper
public interface WalkMapper {
	//산책경로 등록
	@Insert("INSERT INTO WALK")
	public void regsiterWalk(WalkVO walk);
	
	//산책경로 정보 불러오기(회원 이름도 같이 불러와야함)
	
	//북마크(?) 어떻게 해야함 ..
}
