<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f51f9d8c2a383e5820415bbc36c1551a&libraries=services,clusterer,drawing"></script>

<!-- 중앙컨텐츠 시작 -->
<div id="main_body">
	<div id="map" style="width:500px;height:400px;"></div>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
	</script>	
	<form action="cafeList.do" id="search_region" method="get">
		<ul class="search" style="list-style: none;">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>서울특별시</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>부산광역시</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>대구광역시</option>
					<option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>인천광역시</option>
					<option value="5" <c:if test="${param.keyfield == 5}">selected</c:if>>광주광역시</option>
					<option value="6" <c:if test="${param.keyfield == 6}">selected</c:if>>대전광역시</option>
					<option value="7" <c:if test="${param.keyfield == 7}">selected</c:if>>울산광역시</option>
					<option value="8" <c:if test="${param.keyfield == 8}">selected</c:if>>세종특별자치시</option>
					<option value="9" <c:if test="${param.keyfield == 9}">selected</c:if>>경기도</option>
					<option value="10" <c:if test="${param.keyfield == 10}">selected</c:if>>강원도</option>
					<option value="11" <c:if test="${param.keyfield == 11}">selected</c:if>>충청북도</option>
					<option value="12" <c:if test="${param.keyfield == 12}">selected</c:if>>충청남도</option>
					<option value="13" <c:if test="${param.keyfield == 13}">selected</c:if>>전라북도</option>
					<option value="14" <c:if test="${param.keyfield == 14}">selected</c:if>>전라남도</option>
					<option value="15" <c:if test="${param.keyfield == 15}">selected</c:if>>경상북도</option>
					<option value="16" <c:if test="${param.keyfield == 16}">selected</c:if>>경상남도</option>
					<option value="17" <c:if test="${param.keyfield == 17}">selected</c:if>>제주특별자치도</option>
				</select>	
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
				<input type="submit" value="찾기">
		</ul>
	</form>
	<div>	
	</div>
</div>
<!-- 중앙컨텐츠 끝 -->