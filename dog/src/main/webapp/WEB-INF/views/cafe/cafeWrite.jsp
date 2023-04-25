<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f51f9d8c2a383e5820415bbc36c1551a&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/write.css">
<div id="main_body">
	<div id="form_wrap">
	<form:form action="cafeWrite.do" method="post" 
			   modelAttribute="cafeVO" enctype="multipart/form-data">
		<ul>
			<li>
				<label for="cafe_cate">카페 종류</label>
				<form:radiobutton path="cafe_cate"
						value="0" id="cafe_cate0" checked="checked"/>애견카페
				<form:radiobutton path="cafe_cate"
					value="1" id="cafe_cate1"/>애견 동반 카페
			</li>
			<li>
				<label for="cafe_name">카페명</label>
				<input type="text" id="cafe_name" name="cafe_name" value="${cafe_name}">
			</li>
			<li>
				<label for="cafe_addr">주소</label>
				<c:if test="${!empty cafe_addr1}">
				<input type="text" id="cafe_addr1" name="cafe_addr1" value="${cafe_addr1}">
				<input type="hidden" id="cafe_addr2" name="cafe_addr2" value ="${cafe_addr2}">
				</c:if>
				<c:if test="${empty cafe_addr1}">
				<input type="hidden" id="cafe_addr1" name="cafe_addr1" value="">
				<input type="text" id="cafe_addr2" name="cafe_addr2" value="${cafe_addr2}">
				</c:if>
			</li>
			<li>
				<input type="hidden" id="cafe_y" name="cafe_y" value="${cafe_y}">
				<input type="hidden" id="cafe_x" name="cafe_x" value="${cafe_x}">
			</li>
			<li>
				<input type="hidden" id="cafe_region" name="cafe_region" value="${cafe_region}">
			</li>
			<li>
				<label for="cafe_phone">전화번호</label>
				<input type="text" id="cafe_phone" name="cafe_phone">
			</li>
			<li>
				<label for="cafe_site">홈페이지</label>
				<input type="text" id="cafe_site" name="cafe_site">
			</li>
			<li>
				<label for="cafe_content">내용</label>
				<textarea rows="5" cols="24" id="cafe_content" name="cafe_content"></textarea>
			</li>
			<li>
				<label for="upload">사진 등록</label>
				<input type="file" name="upload" id="upload">
				
			</li>
			<li style="margin-top: 10px;">
				<input type="submit" id="regi_btn" value="신청하기">
				<input type="button" id="back_btn" value="뒤로가기" onclick="location.href='cafeSelect.do'">
			</li>
		</ul>
	</form:form>
	</div>
	<div id="map" style="width:100%;height:350px; margin-top: 15px;"></div>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng('${cafe_y}', '${cafe_x}'), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		// 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35);
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: new kakao.maps.LatLng('${cafe_y}', '${cafe_x}'), // 마커를 표시할 위치
	        image : markerImage // 마커 이미지 
	    });
	</script>
</div>