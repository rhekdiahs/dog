<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">

<!-- 초기 리스트 값을 띄우기 위해 id="alarmlist" 사용 -->
<div id="alarmlist" class="page-main">
	<h2>알림 목록</h2>
	<%-- <form action="alarmlist.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>ID</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</li>
		</ul>
	</form> --%>


	<c:if test="${count == 0 }">
	<div class="result-display">표시할 알림이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table2">
		
	</table>
	</c:if>
</div>