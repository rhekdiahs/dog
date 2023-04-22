<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<div style="text-align: center; border: 1px solid;">
		<h2>${cafe.cafe_name}</h2>
		<c:choose>
			<c:when test="${cafe.cafe_cate == 0}"> </c:when>
			<c:when test="${cafe.cafe_cate == 1}"> 카페, 디저트 </c:when>
		</c:choose>
		<p>${cafe.cafe_addr1}</p>
		<p>${cafe.cafe_addr2}</p>
	</div>
	<div>
	
	</div>
</div>