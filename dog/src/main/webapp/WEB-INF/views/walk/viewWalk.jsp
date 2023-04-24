<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="map" style="width:100%; height:400px;"></div>
<span id="centerPoint" data-point="${center}" style="display:none;"></span>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<script src="${pageContext.request.contextPath}/js/main_coord.js"></script>
<script src="${pageContext.request.contextPath}/js/main_findLocation.js"></script>
<script type="text/javascript">
	var center = $('#centerPoint').attr('data-point');			//중간좌표
	
	//Drawing Manager에서 데이터를 가져와 도형을 표시할 아래쪽 지도 div
	var mapContainer = document.getElementById('map'),
	    mapOptions = { 
			<c:forEach var="center" items="${list}" begin="${center}" end="${center}">
	        center: new kakao.maps.LatLng(${center[1]}, ${center[0]}), // 지도의 중심좌표
	        </c:forEach>
	        level: 4 // 지도의 확대 레벨
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
				
		for(var i=0;i<fullPath.length;i+=2){
			if(i !=0 || i != fullPath.length-1){
				startEnd.push(
			        {latlng: new kakao.maps.LatLng(fullPath[i].Ma,fullPath[i].La)} 
			    );
			}
		}
		
		// 마커 이미지 주소
		var imageSrc = "https://cdn-icons-png.flaticon.com/512/9922/9922172.png"; 	//빨강색
		//https://cdn-icons-png.flaticon.com/512/10472/10472640.png					//검정색
		//https://cdn-icons-png.flaticon.com/512/7803/7803789.png					//테두리있는 간판
		//https://cdn-icons-png.flaticon.com/512/7803/7803886.png					//테두리없는 간판
		//https://cdn-icons-png.flaticon.com/512/4970/4970477.png		빨강노랑
		//https://cdn-icons-png.flaticon.com/512/4880/4880846.png      	검정
		
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