<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/detail.css">
<div class = "wrap-detail no-scroll"> 
	<div class = "content-header">
		<div class = "nameNcat">
			<h2 class = "content-title">${walk.mem_name}님의 산책로</h2>
		</div>
		<h4 class = "content-category" style="font-size:10pt; color:#c9c9c9;">
			${walk.walk_address}
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
		<a href = "/hospital/reqUpdate.do?pk_num=${walk.walk_num}" style = "font-size : 11px; position : relative; bottom : 15px; text-decoration: underline;">정보 수정 신청</a>
		</div>
		<div class = "content-road margin-bot">
			<c:if test="${walk.walk_road == null }">
				<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/addressMarker.png">
			</c:if>
			<c:if test="${walk.walk_road != null }">
				<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/addressMarker.png">
			</c:if>
			<div class = "padding-text">
				<c:if test="${walk.walk_road == null }">
					<span style="color:#c9c9c9;">도로명 주소가 없습니다.</span><br>
				</c:if>
				<c:if test="${walk.walk_road != null }">
					<span>${walk.walk_road}</span><br>
				</c:if>
				<span><small style = "opacity : 0.8;">(지번)${walk.walk_address}</small></span>
			</div>

		</div>

		<c:if test="${!empty walk.walk_info}">
		<div class = "content-phone margin-bot">
			<img class = "detail-icon" src = "${pageContext.request.contextPath}/image_bundle/info.png">
			<div class = "padding-text">
				<div style = "font-size : 14px;">${walk.walk_info}</div>
			</div>
		</div>
		</c:if>
		<c:if test="${empty walk.walk_info}">
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
			<c:if test="${!empty walk.walk_img_name}">
			<img src = "${pageContext.request.contextPath}/walk/photoView.do?walk_num=${walk.walk_num}"  style = "width : 100%;">		
			</c:if>
			<c:if test="${empty walk.walk_img_name}">
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
<div id="map" style="width:100%; height:400px;"></div>
<span id="centerPoint" data-point="${center}" style="display:none;"></span>
<script type="text/javascript">
	var center = $('#centerPoint').attr('data-point');			//중간좌표
	
	//Drawing Manager에서 데이터를 가져와 도형을 표시할 아래쪽 지도 div
	var mapContainer = document.getElementById('map'),
	    mapOptions = { 
			<c:forEach var="center" items="${list}" begin="${center}" end="${center}">
	        center: new kakao.maps.LatLng(${center[1]}, ${center[0]}), // 지도의 중심좌표
	        </c:forEach>
	        level:4 // 지도의 확대 레벨
	    };
	
	// 지도 div와 지도 옵션으로 지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOptions),
	    overlays = []; // 지도에 그려진 도형을 담을 배열
	
	//지도에 가져온 데이터로 도형들을 그립니다
	//drawPolyline(data[kakao.maps.drawing.OverlayType.POLYLINE]); 
    var fullPath = [];
    var markerPath = [];								
    var markerCenterPath = [];								//중간 좌표 담을 배열
//    var markerLength = ${fn:length(list)};				//List의 길이
//    var markerPoint = Math.floor(markerLength / 2);		//중간 좌표
    
    <c:forEach var = "walk" items = "${list}" varStatus="status">
	    var latlng = new kakao.maps.LatLng("${walk[1]}", "${walk[0]}");
	    fullPath.push(latlng); 
	    
	    if(${status.index} == center){
	    	markerCenterPath.push(latlng);
	    }
	</c:forEach>
	
	markerPath.push(fullPath[0]);
	markerPath.push(fullPath[fullPath.length - 1]);
	console.log(markerPath);
	
	var xPoint = markerCenterPath[0].Ma;	//x좌표
	var yPoint = markerCenterPath[0].La;	//y좌표
	
	// Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
	function drawPolyline() {
		//var len = lines.length, i = 0;

	        //var style = lines.options;
	        var polyline = new kakao.maps.Polyline({
	            map: map,
	            path: fullPath,
	            strokeColor: '#fb6f41',//style.strokeColor,
	            strokeOpacity: 1
	            //strokeStyle: style.strokeStyle,
	            //strokeWeight: style.strokeWeight
	        });
	        var polyline2 = new kakao.maps.Polyline({
	            map: '',
	            path: fullPath,
	            strokeColor: '#fc1b1b',//style.strokeColor,
	            strokeOpacity: 1
	            //strokeStyle: style.strokeStyle,
	            //strokeWeight: style.strokeWeight
	        });
	        console.log(fullPath);
	        overlays.push(polyline);
	        console.log(polyline);
	        console.log('길이: ' +polyline2.getLength());
	    
/* 			
	   	//중간 마커 표시
			var marker = new kakao.maps.Marker({
					map : map,
					position : new kakao.maps.LatLng(xPoint,yPoint)
				});
		
				overlays.push(marker);  */
				
		//출발 도착 마커
		var startEnd = [
 			{
		        latlng: new kakao.maps.LatLng(fullPath[0].Ma,fullPath[0].La)
		    },
			{
		        latlng: new kakao.maps.LatLng(fullPath[fullPath.length-1].Ma,fullPath[fullPath.length-1].La)
		    } 
		];
				
		for(var i=0;i<fullPath.length;i+=5){
			if(i !=0 || i != fullPath.length-1){
				startEnd.push(
			        {latlng: new kakao.maps.LatLng(fullPath[i].Ma,fullPath[i].La)} 
			    );
			}
		}
		
		// 마커 이미지 주소
		var imageSrc = "https://cdn-icons-png.flaticon.com/512/8998/8998262.png"; 	//빨강색
		//https://cdn-icons-png.flaticon.com/512/10472/10472640.png					//검정색
		//https://cdn-icons-png.flaticon.com/512/7803/7803789.png					//테두리있는 간판
		//https://cdn-icons-png.flaticon.com/512/7803/7803886.png					//테두리없는 간판
		//https://cdn-icons-png.flaticon.com/512/4970/4970477.png		빨강노랑
		//https://cdn-icons-png.flaticon.com/512/4880/4880846.png      	검정
		//https://cdn-icons-png.flaticon.com/512/1130/1130909.png   간판
		
		for (var i = 0; i < startEnd.length; i ++) {
		    
		    // 이미지 크기
		    var imageSize = new kakao.maps.Size(25,25); 
		    
		    // 이미지 생성 
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커 생성
		    var marker = new kakao.maps.Marker({
		        map: map, 
		        position: startEnd[i].latlng,
		        image : markerImage 
		    });
		}	
	}
	
	//선그리기 
	$(function() {
		drawPolyline();
	});

</script>