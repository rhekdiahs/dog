package kr.spring.bookmark.service;

import kr.spring.bookmark.vo.BookmarkVO;

public interface BookmarkService {
	public void insertBookmark(BookmarkVO bookmark);
	public Integer checkBookmark(BookmarkVO bookmark);
	public void deleteBookmark(BookmarkVO bookmark);
}
