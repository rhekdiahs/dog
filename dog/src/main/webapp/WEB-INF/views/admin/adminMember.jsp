<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminList.css">
<style>
  table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
  }
</style>
<div>
 	<div>
 	<h2>회원 목록</h2>
		<c:if test="${count > 0}">
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
		</tr>
		<c:forEach var="user" items="${userList}">
		<tr>
			<c:if test="${user.mem_auth < 9 }">
			<td>${user.mem_id}</td>
			<c:if test="${user.mem_auth == 0}">
				<td colspan="2">탈퇴한 회원입니다.</td>
			</c:if>
			<c:if test="${user.mem_auth == 1}">
			<td>${user.mem_name}</td>
			<td>${user.mem_email}</td>
			</c:if>
			</c:if>
		</tr>
	</c:forEach>
	</table>
	</c:if> 
	</div>
</div>