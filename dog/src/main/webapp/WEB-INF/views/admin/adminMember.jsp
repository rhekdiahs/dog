<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<c:if test="${count > 0}">
	<table>
		<tr>
			<th>회원번호</th>
			<th>이름</th>
			<th>아이디</th>
			<th>가입일</th>
		</tr>
		<tr>
			<td>${user.mem_num}</td>
		</tr>
	</table>
	</c:if>
</div>