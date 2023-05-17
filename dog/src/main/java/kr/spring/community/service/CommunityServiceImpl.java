package kr.spring.community.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.community.dao.CommunityMapper;
import kr.spring.community.vo.CommunityAlarmVO;
import kr.spring.community.vo.CommunityFavVO;
import kr.spring.community.vo.CommunityReplyVO;
import kr.spring.community.vo.CommunityVO;
import kr.spring.member.vo.MemberVO;
@Service
@Transactional
public class CommunityServiceImpl implements CommunityService{
	
	@Autowired
	private CommunityMapper communityMapper;
	
	@Override
	public List<CommunityVO> selectList(Map<String, Object> map) {
		return communityMapper.selectList(map);
	}

	@Override
	public int selectCount(Map<String, Object> map) {
		return communityMapper.selectCount(map);
	}

	@Override
	public CommunityVO selectCommunity(Integer lf_num) {
		return communityMapper.selectCommunity(lf_num);
	}

	@Override
	public void updateHit(Integer lf_num) {
		communityMapper.updateHit(lf_num);
	}

	@Override
	public void insertCommunity(CommunityVO community) {
		communityMapper.insertCommunity(community);
	}

	@Override
	public void updateCommunity(CommunityVO community) {
		communityMapper.updateCommunity(community);
	}

	@Override
	public void deleteCommunity(Integer lf_num) {
		communityMapper.deleteReplyByCommunityNum(lf_num);
		communityMapper.deleteFavByCommunityNum(lf_num);
		communityMapper.deleteCommunity(lf_num);
	}

	@Override
	public void deleteImage(Integer lf_num) {
		communityMapper.deleteImage(lf_num);
	}

	@Override
	public CommunityFavVO selectFav(CommunityFavVO fav) {
		return communityMapper.selectFav(fav);
	}

	@Override
	public int selectFavCount(Integer lf_num) {
		return communityMapper.selectFavCount(lf_num);
	}

	@Override
	public void insertFav(CommunityFavVO fav) {
		communityMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(Integer fav_num) {
		communityMapper.deleteFav(fav_num);
	}

	@Override
	public List<CommunityReplyVO> selectListReply(Map<String, Object> map) {
		return communityMapper.selectListReply(map);
	}

	@Override
	public int selectCountReply(Map<String, Object> map) {
		return communityMapper.selectCountReply(map);
	}

	@Override
	public CommunityReplyVO selectReply(Integer re_num) {
		return communityMapper.selectReply(re_num);
	}

	@Override
	public void insertReply(CommunityReplyVO communityReply) {
		communityMapper.insertReply(communityReply);
	}

	@Override
	public void updateReply(CommunityReplyVO communityReply) {
		communityMapper.updateReply(communityReply);
	}

	@Override
	public void deleteReply(Integer re_num) {
		communityMapper.deleteReply(re_num);
	}

	@Override
	public int alarmCount(Integer mem_num) {
		return communityMapper.alarmCount(mem_num);
	}

	@Override
	public void insertAlarm(CommunityAlarmVO alarm) {
		communityMapper.insertAlarm(alarm);
	}

	@Override
	public List<CommunityAlarmVO> selectAlarm(Integer mem_num) {
		return communityMapper.selectAlarm(mem_num);
	}

	@Override
	public void updateAlarm(Integer mem_num) {
		communityMapper.updateAlarm(mem_num);
	}

	@Override
	public void deleteAlarmReply(Integer re_num) {
		communityMapper.deleteAlarmReply(re_num);
	}

	@Override
	public void deleteAlarmCommunity(Integer lf_num) {
		communityMapper.deleteAlarmCommunity(lf_num);
	}

	@Override
	public void deleteAlarmFav(Integer fav_num) {
		communityMapper.deleteAlarmFav(fav_num);
	}

	@Override
	public int nowre_num() {
		return communityMapper.nowre_num();
	}

	@Override
	public int modifyre_num() {
		return communityMapper.modifyre_num();
	}
	
	@Override
	public int selectMember(String mem_id) {
		return communityMapper.selectMember(mem_id);
	}

	@Override
	public List<CommunityAlarmVO> selectAllAlarm(Integer mem_num) {
		return communityMapper.selectAllAlarm(mem_num);
	}

	@Override
	public void deleteAlarm(Integer al_num) {
		communityMapper.deleteAlarm(al_num);
	}

	@Override
	public CommunityAlarmVO selectAlarmDetail(Integer al_num) {
		return communityMapper.selectAlarmDetail(al_num);
	}

}
