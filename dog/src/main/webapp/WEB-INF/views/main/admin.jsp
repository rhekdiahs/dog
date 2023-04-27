<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main_findLocation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/setViewHeigh.js"></script>
<div id = "main_div">
	<img id = "main_logo" src = "${pageContext.request.contextPath}/image_bundle/logo1.png">
	<div class = "menu-grid">
		<a class = "menu-list" href="javascript:void(0);" onclick="withWalkCityList()">산책경로</a>

		<a class = "menu-list" href="javascript:void(0);" onclick="withCafeCity()">카페 목록</a>

		<a class = "menu-list" href="${pageContext.request.contextPath}/shelter/shelterList.do">임시보호소</a>
		<a class = "menu-list" href = "javascript:void(0);" onclick="withCurCity()">병원</a>
	</div>
	<div class = "menu-login">
		<c:if test="${!empty user}">
		<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		<a href = "${pageContext.request.contextPath}/admin/adminMain.do">관리페이지</a>
		</c:if>
		<c:if test="${empty user}">
		<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
		<a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a>	
		</c:if>	
	</div>
</div>