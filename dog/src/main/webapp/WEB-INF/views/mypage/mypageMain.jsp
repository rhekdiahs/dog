<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
<div id="main_body">
      <div id="my_profile" class="mypage-cate">
          <div id="profile_main" class="profile-cate">
              <div id="profile_img">
                  <img src="${pageContext.request.contextPath}/image_bundle/profile.png" width="150" height="150">
              </div>
              <div id="profile_edit">
                  <button id="profile_edit_btn" 
                          onclick="location.href='${pageContext.request.contextPath}/mypage/editMain.do'">프로필 편집</button>
              </div>
          </div>
          <div id="profile_info" class="profile-cate">
              <p id="user_name"><span id="user_name">${member.mem_name}</span>님
              <br>환영합니다!!!</p>
              <p id="user_email" style="text-align: start;">${member.mem_email}</p>
              <p id="user_register_date" style="color:gray;text-align: start;"><fmt:formatDate value="${member.mem_regdate}" pattern="yyyy년 MM월 가입"/></p>
              <p id="user_intro" style="text-align: start;">시베리아 허스키 견주🐺 안녕하세요!</p>
              
          </div>
      </div>
      <div id="bookmark_list" class="mypage-cate">
          <div id="bm_title" class="bm-categories">
              <p>북마크 <span class="bm-count" style="font-size: 20pt; color:#feb69f;">${totalCount}</span>개</p>
          </div>
          <div id="bm_content" class="bm-categories">
              <div id="wrap_top" class="wrap">
                  <div id="bm_walk" class="bm-category">
                      <p class="bm-kind">산책로</p> <p class="bm-count"><span id="walk_count">5</span> 개</p>
                  </div>
                  <div id="bm_cafe" class="bm-category">
                      <p class="bm-kind">펫존</p> <p class="bm-count"><span id="cafe_count">7</span> 개</p>
                  </div>
              </div>
              <div id="wrap_bottom" class="wrap">
                  <div id="bm_hos" class="bm-category">
                      <p class="bm-kind">병원</p> <p class="bm-count"><span id="hos_count">0</span> 개</p>
                  </div>
                  <div id="bm_pro" class="bm-category">
                      <p class="bm-kind">임시보호소</p><p class="bm-count"><span id="pro_count">0</span> 개</p>
                  </div>
              </div>
          </div>
      </div>
      <div id="my_ext">
          <div id="my_list" class="ext_cate"><a>내 게시물 관리</a></div>
          <div id="request_list" class="ext_cate"><a>신청 현황</a></div>
          <div id="delete_btn" class="ext_cate">
              <a onclick="location.href='${pageContext.request.contextPath}/mypage/delete.do'">회원탈퇴</a>
          </div>
      </div>
</div>