<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="map" style="width:500px;height:400px;"></div>
<c:forEach var="walk" items="${list}" varStatus="status">
<span>${walk[0]}</span>
</c:forEach>
<span id="centerPoint" data-point="${center}" style="display:none;"></span>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<script type="text/javascript">
	var center = $('#centerPoint').attr('data-point');			//중간좌표
	console.log("center는" + center);
	
	//Drawing Manager에서 데이터를 가져와 도형을 표시할 아래쪽 지도 div
	var mapContainer = document.getElementById('map'),
	    mapOptions = { 
			<c:forEach var="center" items="${list}" begin="${center}" end="${center}">
	        center: new kakao.maps.LatLng(${center[1]}, ${center[0]}), // 지도의 중심좌표
	        </c:forEach>
	        level: 3 // 지도의 확대 레벨
	    };
	
	// 지도 div와 지도 옵션으로 지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOptions),
	    overlays = []; // 지도에 그려진 도형을 담을 배열
	
	//지도에 가져온 데이터로 도형들을 그립니다
	//drawPolyline(data[kakao.maps.drawing.OverlayType.POLYLINE]); 
    var fullPath = [];
    var markerPath = [];								//중간 좌표 담을 배열
//    var markerLength = ${fn:length(list)};				//List의 길이
//    var markerPoint = Math.floor(markerLength / 2);		//중간 좌표
    
    <c:forEach var = "walk" items = "${list}" varStatus="status">
	    var latlng = new kakao.maps.LatLng("${walk[1]}", "${walk[0]}");
	    fullPath.push(latlng); 
	    
	    if(${status.index} == center){
	    	markerPath.push(latlng);
	    }
	</c:forEach>
	
	var xPoint = markerPath[0].Ma;	//x좌표
	var yPoint = markerPath[0].La;	//y좌표
	
	// Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
	function drawPolyline() {
		//var len = lines.length, i = 0;

	    for (var i=0; i < fullPath.length; i++) {	//x좌표,y좌표
	        //var style = lines.options;
	        var polyline = new kakao.maps.Polyline({
	            map: map,
	            path: fullPath,
	            strokeColor: '#39f',//style.strokeColor,
	            strokeOpacity: 0.5
	            //strokeStyle: style.strokeStyle,
	            //strokeWeight: style.strokeWeight
	        });
			
	        overlays.push(polyline);
	        console.log(polyline);
	    }
	    

	   //마커 표시
		var marker = new kakao.maps.Marker({
				map : map,
				position : new kakao.maps.LatLng(xPoint,yPoint),
			});
	
			overlays.push(marker); 
	}
	
	//선그리기 
	$(function() {
		drawPolyline();
	});
	
	
	//데이터 경로 저장
	function pointsToPath(points) {
	    var len = points.length, 
	        path = [],
	        i = 0;

	    for (; i < len; i++) { 
	        var latlng = new kakao.maps.LatLng(points[i].y, points[i].x);
	        path.push(latlng); 
	    }

	    return path;
	}
</script>