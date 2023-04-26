package kr.spring.bookmark.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.bookmark.dao.BookmarkMapper;
import kr.spring.bookmark.vo.BookmarkVO;

@Service
@Transactional
public class BookmarkServiceImpl implements BookmarkService{
	@Autowired
	private BookmarkMapper bookmarkMapper;

	@Override
	public void insertBookmark(BookmarkVO bookmark) {
		bookmarkMapper.insertBookmark(bookmark);
	}

	@Override
	public Integer checkBookmark(BookmarkVO bookmark) {
		return bookmarkMapper.checkBookmark(bookmark);
	}

	@Override
	public void deleteBookmark(BookmarkVO bookmark) {
		bookmarkMapper.deleteBookmark(bookmark);		
	}
}
