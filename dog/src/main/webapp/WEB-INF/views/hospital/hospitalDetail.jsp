<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detail.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab928e5929563772b2932e6182f6b7d9&libraries=services"></script>

<div class = "wrap-detail no-scroll"> 
	<div class = "content-header">
		<div class = "nameNcat">
			<h2 class = "content-title">${hospital.h_name}</h2>
		</div>
		<h4 class = "content-category">
		<c:if test = "${hospital.hospital_type == 0}">일반병원</c:if>
		<c:if test = "${hospital.hospital_type == 1}">24시병원</c:if>
		</h4>
		<ul class = "direct-scroll">
			<li id = "detail_info"><h5>상세</h5></li>
			<li id = "detail_review"><h5>리뷰</h5></li>
			<li id = "detail_photo"><h5>사진</h5></li>
			<li id = "detail_map"><h5>지도</h5></li>
		</ul>
	</div>
	<hr>
	<div id = "forScrollInfo" class = "margin-detail">
		<h3 class = "detail-cat">상세</h3>
		<div style = "text-align : right">
		<a href = "/hospital/reqUpdate.do?pk_num=${hospital.hospital_num}" style = "font-size : 11px; position : relative; bottom : 15px; text-decoration: underline;">정보 수정 신청</a>
		</div>
		<div class = "content-road margin-bot">
			<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/addressMarker.png">
			<div class = "padding-text">
				<span>${hospital.road}</span><br>
				<span><small style = "opacity : 0.8;">(지번)${hospital.h_address}</small></span>
			</div>

		</div>
		<c:if test="${!empty hospital.h_link}">
		<div class = "content-link margin-bot">
			<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/world-wide-web.png">
			<div  class = "padding-text">
				<a href = "https://${hospital.h_link}">${hospital.h_link}</a>
			</div>
		</div>
		</c:if>
		<c:if test="${!empty hospital.h_phone}">
		<div class = "content-phone margin-bot">
			<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/phone_img.png">
			<div class = "padding-text">
				<span>${hospital.h_phone}</span>
			</div>
		</div>
		</c:if>
		<c:if test="${!empty hospital.h_info_detail}">
		<div class = "content-phone margin-bot">
			<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/info.png">
			<div class = "padding-text">
				<div style = "font-size : 14px;">${hospital.h_info_detail}</div>
			</div>
		</div>
		</c:if>
		<c:if test="${empty hospital.h_info_detail}">
		<div class = "content-detail margin-bot">
		<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/info.png">
		<div class = "padding-text">
			<div style = "font-size : 14px;">등록된 상세설명이 없습니다.</div>
		</div>
		</div>
		</c:if>
	</div>
	<hr>
	<div id = "forScrollReview" class = "margin-detail">
		<h3 class = "detail-cat">리뷰</h3>
		<ul style = "width: 90vw; margin: 0 auto;">
			<li>
				<img src = "${pageContext.request.contextPath}/image_bundle/dog_logo.jpg" width = "40" height = "40" style = "float : left; border-radius : 30%;">
				<div style = "padding-left : 50px; margin: 10px 0;">
					<span><strong>망고</strong> | </span>
					<span>2023.04.20</span>
					<div>
						<br>
						<p>친절하고 좋습니다.</p>
					</div>
				</div>
				<hr style = "border : 1px solid whitesmoke;">
			</li>
			<li>
				<img src = "${pageContext.request.contextPath}/image_bundle/dog_logo.jpg" width = "40" height = "40" style = "float : left; border-radius : 30%;">
				<div style = "padding-left : 50px; margin: 10px 0;">
					<span><strong>까까</strong> | </span>
					<span>2023.04.17</span>
					<div>
						<br>
						<p>재방문 의사 있음</p>
					</div>
				</div>
			</li>
		</ul>
	</div>
	<hr>
	<div id = "forScrollPhoto" class = "margin-detail">
		<h3 class = "detail-cat">사진</h3>
		<div>
			<c:if test="${!empty hospital.h_info_image_name}">
			<img src = "${pageContext.request.contextPath}/hospital/photoView.do?hospital_num=${hospital.hospital_num}"  style = "width : 100%;">		
			</c:if>
			<c:if test="${empty hospital.h_info_image_name}">
			<img src = "${pageContext.request.contextPath}/image_bundle/logo.jpg" style = "width : 100%;">
			</c:if>
			<%-- <c:if test="${empty hospital.h_info_image_name}">
				<div style = "text-align : center; margin-bottom : 10px;">
					등록된 이미지가 없습니다.
				</div>
			</c:if> --%>
		</div>
	</div>
	<hr>
	<div id = "forScrollMap" class = "margin-detail" style = "margin-bottom : 30px;">
		<h3 class = "detail-cat">지도</h3>
		<div id = "map"></div>
		<div>
		<c:if test="${user.mem_auth == 9 && hospital.h_info_auth == 0}">
		<form action="hospitalDetail.do" method="post">
			<input name="p_num" type="hidden" value="${hospital.hospital_num}">
			<button type="submit" id="admin_check">승인</button>
		</form>
		</c:if>
		</div>
		<script>
			const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			
			let options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng('${hospital.coord_y}', '${hospital.coord_x}'), //지도의 중심좌표.
				level: 3 //지도의 레벨(확대, 축소 정도)
			};
			let map = new kakao.maps.Map(container, options);
			
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
			// 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35);
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: new kakao.maps.LatLng('${hospital.coord_y}', '${hospital.coord_x}'), // 마커를 표시할 위치
		        image : markerImage // 마커 이미지 
		    });
		    var content = '<div class ="label"><span class="left"></span><span class="center">${hospital.h_name}</span><span class="right"></span></div>';
		    var customOverlay = new kakao.maps.CustomOverlay({
		        content: content,
		        map: map,
		        position: marker.getPosition()
		    });
		    customOverlay.setMap(map);
		</script>
		<script type="text/javascript">
			$(function(){
				var menubar = document.getElementById('main_header');
				var menubarRect = menubar.getBoundingClientRect();
				var menubar_height = menubarRect.height;
				$('#detail_info').click(function () {
					var elem = document.getElementById('forScrollInfo');
			    	let rect = elem.getBoundingClientRect();
			    	window.scrollTo({ left: 0, top: rect.y-menubar_height, behavior: "smooth" });
				  });
				$('#detail_review').click(function () {
					var elem = document.getElementById('forScrollReview');
			    	let rect = elem.getBoundingClientRect();
			    	window.scrollTo({ left: 0, top: rect.y-menubar_height, behavior: "smooth" });
				  });
				$('#detail_photo').click(function () {
					var elem = document.getElementById('forScrollPhoto');
			    	let rect = elem.getBoundingClientRect();
			    	window.scrollTo({ left: 0, top: rect.y-menubar_height, behavior: "smooth" });
				  });
				$('#detail_map').click(function () {
					var elem = document.getElementById('forScrollMap');
			    	let rect = elem.getBoundingClientRect();
			    	window.scrollTo({ left: 0, top: rect.y-menubar_height, behavior: "smooth" });
				  });
			});
		</script>
	</div>
</div>