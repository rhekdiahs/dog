<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<button onclick="location.href='${pageContext.request.contextPath}/mypage/modifyProfile.do'">누르면 controller에 다 뜸</button>
<!-- 프로필 편집 버튼 누르면 ajax로 사진 실시간 변경 -->