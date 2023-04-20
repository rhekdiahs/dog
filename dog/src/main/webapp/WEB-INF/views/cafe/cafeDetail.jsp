<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<div>
		<c:forEach var="cafe" items="${cafe}">		
		<h4>${cafe.cafe_name}</h4>
		</c:forEach>
	</div>
</div>