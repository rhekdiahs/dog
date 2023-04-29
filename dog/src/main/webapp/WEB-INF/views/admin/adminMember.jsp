<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminList.css">
<div>
 	<div>
		<c:if test="${count > 0}">
	<table>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
		</tr>
		<c:forEach var="user" items="${userList}">
		<tr>
			<td>${user.mem_num}</td>
			<td>${user.mem_id}</td>
			<td>${user.mem_name}</td>
			<td>${user.mem_email}</td>
		</tr>
	</c:forEach>
	</table>
	</c:if> 
	</div>
</div>