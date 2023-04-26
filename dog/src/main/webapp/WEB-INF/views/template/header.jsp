<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script src="${pageContext.request.contextPath}/js/setMenuBtn.js"></script>

<ul style = "display : flex; justify-content: space-between;">
	<li>
		<a class = "menu-icon" href = "/main/main.do">
			<img id = "menu_homeBtn" src = "${pageContext.request.contextPath}/image_bundle/home_btn.png">
		</a>
	</li>
	<c:if test="${!empty user}">
	<li>
		<a class = "menu-icon">
			<img id = "menu_notiBtn">
		</a>
	</li>
	</c:if>
</ul>
