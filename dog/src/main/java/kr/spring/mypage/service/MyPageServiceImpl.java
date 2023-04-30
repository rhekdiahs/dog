package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.bookmark.vo.BookmarkVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.dao.MyPageMapper;

@Service
@Transactional
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	private MyPageMapper mypageMapper;
	
	@Override
	public MemberVO getMemInfo(Integer mem_num) {
		return mypageMapper.getMemInfo(mem_num);
	}

	@Override
	public void deleteAccount(Integer mem_num) {
		mypageMapper.deleteBookmark(mem_num);
		mypageMapper.changeAuth(mem_num);
		mypageMapper.deleteAcoount(mem_num);
	}
	
	@Override
	public List<BookmarkVO> getBookmarkListByCategories(Map<String, Object> map) {
		return mypageMapper.getBookmarkListByCategories(map);
	}

	@Override
	public Integer getBookmarkCountByCategories(Map<String, Object> map) {
		return mypageMapper.getBookmarkCountByCategories(map);
	}

	@Override
	public Integer getBookmarkCount(Integer mem_num) {
		return mypageMapper.getBookmarkCount(mem_num);
	}

	@Override
	public void updateProfile(MemberVO member) {
		mypageMapper.updateProfile(member);
	}
}
