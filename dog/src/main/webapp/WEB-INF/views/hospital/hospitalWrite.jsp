<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab928e5929563772b2932e6182f6b7d9&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/write.css">
<div id="main_body">
	<div id="form_wrap">
	<form:form action="hospitalWrite.do" method="post" 
			   modelAttribute="hospitalVO" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<div class="cafe_cate">
				<p>카페 종류</p>
			     <input type="radio" id="cafe_cate0" name="hospital_type" checked="checked" value="0">
			     <label for="cafe_cate0">일반병원</label>
			     <input type="radio" id="cafe_cate1" name="hospital_type" value="1">
			     <label for="cafe_cate1">24시병원</label>
				</div>
			</li>
			<li>
				<p><label for="h_name">병원명</label><p>
				<form:input path="h_name" id="cafe_name" name="h_name" value="${h_name}"/>			
				<p><form:errors path="h_name" cssClass="error-color"/></p>
			</li>
			<li>
				<p><label for="cafe_addr">주소</label></p>
				<c:if test="${!empty road}">
				<input type="text" id="cafe_addr1"  name="road" value="${road}">
				<input type="hidden" id="cafe_addr2"  name="h_address" value ="${h_address}">		
				</c:if>
				<c:if test="${empty road}">
				<input type="hidden" id="cafe_addr1"  name="road" value=""/>
				<input type="text" id="cafe_addr2"  name="h_address" value="${h_address}">
				</c:if>
			</li>
			<li>
				<input type="hidden" id="cafe_y" name="coord_y" value="${coord_y}"/>
				<input type="hidden" id="cafe_x" name="coord_x" value="${coord_x}"/>
			</li>
			<li>
				<input type="hidden" id="cafe_region" name="hospital_region" value="${hospital_region}"/>
			</li>
			<li>
				<p><label for="cafe_phone">전화번호</label></p>
				<input type="text" id="cafe_phone" name="h_phone"/>
			</li>
			<li>
				<p><label for="cafe_site">홈페이지</label></p>
				<input type="text" id="cafe_site" name="h_link"/>
			</li>
			<li>
				<p><label for="cafe_content">내용</label></p>
				<form:textarea rows="8" cols="33" path="h_info_detail" id="cafe_content" name="h_info_detail"/>
				<p><form:errors path="h_info_detail" cssClass="error-color"/></p>
			</li>
			<li>
				<p><label for="upload">사진 등록</label></p>
				<input type="file" name="upload" id="upload">
				
			</li>
			<li style="margin-top: 10px;">
				<input type="submit" id="regi_btn" value="신청하기">
				<input type="button" id="back_btn" value="뒤로가기" onclick="location.href='hospitalSelect.do'">
			</li>
		</ul>
	</form:form>
	</div>
	<div id="map" style="width:100%;height:350px; margin-top: 15px;"></div>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng('${coord_y}', '${coord_x}'), // 지도의 중심좌표
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
	        position: new kakao.maps.LatLng('${coord_y}', '${coord_x}'), // 마커를 표시할 위치
	        image : markerImage // 마커 이미지 
	    });
	</script>
</div>