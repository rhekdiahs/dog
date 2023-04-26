package kr.spring.bookmark.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import kr.spring.bookmark.vo.BookmarkVO;

@Mapper
public interface BookmarkMapper {
	//북마크하기
	@Insert("INSERT INTO BOOKMARK_MAP VALUES(bookmark_map_seq.nextval,#{walk_num},#{hospital_num},#{cafe_num},#{mem_num},#{categories})")
	public void insertBookmark(BookmarkVO bookmark);
	
	//북마크 해논건지 체크
	public Integer checkBookmark(BookmarkVO bookmark);
	
	public void deleteBookmark(BookmarkVO bookmark);
}
