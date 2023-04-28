<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<div>
		<c:if test="${count >= 0}">
	<table>
		<tr>
			<th>회원번호</th>
			<th>이름</th>
			<th>아이디</th>
			<th>이메일</th>
			<th>가입일</th>
		</tr>
		<c:forEach var="user" items="${user}">
		<tr>
			<td>${member.mem_num}</td>
			<td>${member.mem_name}</td>
			<td>${member.mem_email}</td>
			<td>${member.mem_regdate}</td>
		</tr>
	</c:forEach>
	</table>
	</c:if>
	</div>
</div>