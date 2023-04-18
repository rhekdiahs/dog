<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="map" style="width:500px;height:400px;"></div>
<c:forEach var="walk" items="${list}">
	<p><a href="${pageContext.request.contextPath}/walk/viewMap.do?walk_num=${walk.walk_num}">${walk.walk_num}번 경로</a></p>
</c:forEach>
<button onclick="location.href='${pageContext.request.contextPath}/walk/register.do'">🚩경로등록하기🚩</button>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<script type="text/javascript">
</script>