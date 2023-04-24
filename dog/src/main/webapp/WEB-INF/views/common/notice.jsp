<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안내</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/setViewHeigh.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<div id = "main">
	<div id = "main_div">
		<div class="wrap-cont">
			<img id = "4orDog_title" src = "${pageContext.request.contextPath}/image_bundle/4orDog.png" style = "margin : 10px 0; width : 60vw">
			<br>
			<c:if test="${!empty accessMsg}">
				${accessMsg}
			</c:if>
			<c:if test="${empty accessMsg}">
				잘못된 접속입니다.
			</c:if>
			<p>
			<c:if test="${!empty accessUrl}">
			<input type="button" value="${accessBtn}" onclick="location.href='${accessUrl}'">
			</c:if>
			<c:if test="${empty accessUrl}">
			<input type="button" value="홈으로" class = "login-btn" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</c:if>
		</div>
	</div>
</div>
</body>
</html>