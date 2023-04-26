<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<script src="${pageContext.request.contextPath}/js/main_findLocation.js"></script>
<script src="${pageContext.request.contextPath}/js/main_coord.js"></script>
<form:form action="selectRegionFromList.do" method="get">
	<select name="keyfield" id="keyfield" style="width:100%;">
		<option selected="selected">--선택--</option>
		<option value="서울특별시"
			<c:if test="${param.keyfield == '서울특별시'}">selected</c:if>>서울</option>
		<option value="부산광역시"
			<c:if test="${param.keyfield == '부산광역시'}">selected</c:if>>부산</option>
		<option value="대구광역시"
			<c:if test="${param.keyfield == '대구광역시'}">selected</c:if>>대구</option>
		<option value="인천광역시"
			<c:if test="${param.keyfield == '인천광역시'}">selected</c:if>>인천</option>
		<option value="광주광역시"
			<c:if test="${param.keyfield == '광주광역시'}">selected</c:if>>광주</option>
		<option value="대전광역시"
			<c:if test="${param.keyfield == '대전광역시'}">selected</c:if>>대전</option>
		<option value="울산광역시"
			<c:if test="${param.keyfield == '울산광역시'}">selected</c:if>>울산</option>
		<option value="세종특별자치시"
			<c:if test="${param.keyfield == '세종특별자치시'}">selected</c:if>>세종</option>
		<option value="경기도"
			<c:if test="${param.keyfield == '경기도'}">selected</c:if>>경기</option>
		<option value="강원도"
			<c:if test="${param.keyfield == '강원도'}">selected</c:if>>강원</option>
		<option value="충청북도"
			<c:if test="${param.keyfield == '충청북도'}">selected</c:if>>충북</option>
		<option value="충청남도"
			<c:if test="${param.keyfield == '충청남도'}">selected</c:if>>충남</option>
		<option value="전라북도"
			<c:if test="${param.keyfield == '전라북도'}">selected</c:if>>전북</option>
		<option value="전라남도"
			<c:if test="${param.keyfield == '전라남도'}">selected</c:if>>전남</option>
		<option value="경상북도"
			<c:if test="${param.keyfield == '경상북도'}">selected</c:if>>경북</option>
		<option value="경상남도"
			<c:if test="${param.keyfield == '경상남도'}">selected</c:if>>경남</option>
		<option value="제주특별자치도"
			<c:if test="${param.keyfield == '제주특별자치도'}">selected</c:if>>제주</option>
	</select>
<script type="text/javascript">
	$('#keyfield').change(function(){
		location.href = "/walk/selectRegionFromList.do?keyfield=" + $(this).val();
	});
</script>
</form:form>
<div id="map"></div>
<c:forEach var="walk" items="${list}">
	<p><a href="${pageContext.request.contextPath}/walk/viewWalk.do?walk_num=${walk.walk_num}">${walk.walk_num}번 경로</a></p>
</c:forEach>
<c:if test="${user != null}"></c:if>
<button onclick="withWalkCityRegister();">🚩경로등록하기🚩</button>
<script>
	$(function(){
		console.log('a');
		for(var i = 0; i < 8; i++){
			var bookmarkImage = $('#bookmark_img'+i);
	 		var walk_num = bookmarkImage.attr('data-img');
			// var bookmarkIndex = bookmarkImage.attr('data-index');
			
			//console.log(walk_num);
	 		 		console.log(bookmarkImage.attr('id'));
		 		$.ajax({
	 			url : '${pageContext.request.contextPath}/bookmark/presentBookmark.do',
	 			data : {walk_num : walk_num},
	 			type : 'post',
	 			dataType : 'json',
	 			//status :: null/success/fail
	 			success : function(result){
	 				if(result.status == 'full'){
	 					console.log(bookmarkImage.attr('id'));
	 					bookmarkImage.attr('src','${pageContext.request.contextPath}/image_bundle/bookmark1.png');
	 				}else if(result.status == 'null'){
	 					console.log('logout');
	 				}else if(result.status == 'empty'){
	 					console.log('empty');
	 					bookmarkImage.attr('src','${pageContext.request.contextPath}/image_bundle/bookmark0.png');
	 				}else{
	 					alert('NETWORK ERROR');
	 				}
	 			},
	 			error : function(){
	 				alert('에러');
	 			}
	 		});	//end of ajax 
		}
		
	});
</script>
<!-- list scroll -->
<div>
	<ul id="place-list" class="place-list">
		<c:forEach var="list" items="${list}" varStatus="status">
			<li id="${list.walk_num}">
				<div class="place-bookmark">
				<!-- BookmarkController 북마크 로직 -->
				<c:if test=""></c:if><!-- 북마크 되어있는 경우 까만색 이미지 -->
				<c:if test="${user != null}"></c:if><!-- 안되어이 잇는 경우 하얀색 이미지 -->
				<img id="bookmark_img${status.index}" data-img="${list.walk_num}"
					 onclick="bookmark(this)"
					 style="position:relative; top:50px; right:-175px;" 
					 width="50">
				</div>
				<div class="list-title">
					<a href="/walk/viewWalk.do?walk_num=${list.walk_num}"
						class="title-index"><strong>${status.count}</strong></a> 
					<a href="/walk/viewWalk.do?walk_num=${list.walk_num}"
						class="title-index">
					<c:if test="${list.mem_id != null}"><strong>${list.mem_id}</strong></c:if>
					<c:if test="${list.mem_id == null}"><strong>🐶🐶</strong></c:if>님의 산책로</a>
				</div>
			</li>
			<script type="text/javascript">
		 		/* var bookmarkImage = $('#bookmark_img${status.index}');
		 		var walk_num = bookmarkImage.attr('data-img');
				// var bookmarkIndex = bookmarkImage.attr('data-index');
				
				console.log(walk_num);
		 		 		
 		 		$.ajax({
		 			url : '${pageContext.request.contextPath}/bookmark/presentBookmark.do',
		 			data : {walk_num : walk_num},
		 			type : 'post',
		 			dataType : 'json',
		 			//status :: null/success/fail
		 			success : function(result){
		 				if(result.status == 'full'){
		 					bookmarkImage.attr('src','../image_bundle/bookmark1.png');
		 				}else if(result.status == 'null'){
		 					console.log('logout');
		 				}else if(result.status == 'empty'){
		 					bookmarkImage.attr('src','../image_bundle/bookmark0.png');
		 				}else{
		 					alert('NETWORK ERROR');
		 				}
		 			},
		 			error : function(){
		 				alert('에러');
		 			}
		 		});	//end of ajax  */
		 		
			</script>
		</c:forEach>
	</ul>
</div>
<script type="text/javascript">
		var mapContainer = document.getElementById('map'),
	    mapOptions = {
	        center: new kakao.maps.LatLng(coordY, coordX), // 지도의 중심좌표
	        level: zoomLevel // 지도의 확대 레벨
	    };
		
		mapContainer.style.width = visualViewport.width + 'px';
		mapContainer.style.height = visualViewport.width + 'px';
		
		// 지도 div와 지도 옵션으로 지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOptions), overlays = []; // 지도에 그려진 도형을 담을 배열
		    
		let path = [];
		
		<c:forEach var="path" items="${list}">
			path.push('${path.walk_position}');
		</c:forEach>
		
		console.log(path);
		console.log(typeof(path));				//object
		console.log(Array.isArray(path));		//배열이다
		console.log(path.length);				//8
		console.log(path[0]);
		
		
		//지도에 가져온 데이터로 도형들을 그립니다
		//drawPolyline(data[kakao.maps.drawing.OverlayType.POLYLINE]); 
	    //var pathsOfList = [];
	    var coord = [];
	    let len = path.length;
	    
	 // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
		function drawPolyline() {
			//var len = lines.length, i = 0;

		    for (var i=0; i < path.length; i++) {	//x좌표,y좌표
		    	var pathsOfList = path[i].split(", ");
		    	
		    	for(var j=0; j<pathsOfList.length; j+=2){
		    	  	var latlng = new kakao.maps.LatLng(pathsOfList[j+1],pathsOfList[j]);
		    	  	coord.push(latlng);
		    	}
		        //var style = lines.options;
		        var polyline = new kakao.maps.Polyline({
		            map: map,
		            path: coord,//pathsOfList,
		            strokeColor: '#39f',//style.strokeColor,
		            strokeOpacity: 1
		            //strokeStyle: style.strokeStyle,
		            //strokeWeight: style.strokeWeight
		        });
		        
		        var center = Math.floor(coord.length / 2);					//중간좌표
		        
		     	var imageSrc = "https://cdn-icons-png.flaticon.com/512/8845/8845799.png"; 
		        
			    var imageSize = new kakao.maps.Size(42,42); 
			    
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			    
				//마커 표시
				var marker = new kakao.maps.Marker({
					map : map,
					position : new kakao.maps.LatLng(coord[center].Ma,coord[center].La),
					image : markerImage 
				});
		        
				coord =[];
				
				overlays.push(marker); 
		        overlays.push(polyline);
		    }
		    
		}	
	 
 	//선그리기 
	$(function() {
		drawPolyline();
	}); 
 		
 	//북마크
 	function bookmark(e){
 		var walk_num = e.closest('li').getAttribute('id');
 		console.log(walk_num);
 		
$.ajax({
	url : '${pageContext.request.contextPath}/bookmark/insert.do',
	data : {walk_num : walk_num},
	type : 'post',
	dataType : 'json',
	//status :: null/success/fail
	success : function(result){
		if(result.status == 'insertOK'){
			e.setAttribute('src','/image_bundle/bookmark1.png');
		}else if(result.status == 'null'){
			alert('null');
		}else if(result.status == 'deleteOK'){
			e.setAttribute('src','/image_bundle/bookmark0.png');
		}else{
			alert('NETWORK ERROR');
		}
	},
	error : function(){
		alert('에러');
	}
});
 	}
 	
/* 	//데이터 경로 저장
	function pointsToPath(points) {
	    var len = points.length, 
	        path = [],
	        i = 0;

	    for (; i < len; i++) { 
	        var latlng = new kakao.maps.LatLng(points[i].y, points[i].x);
	        path.push(latlng)
	    }

	    return path;
	} */
	
/*     // 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 10 // 클러스터 할 최소 지도 레벨 
    });
	
    // 데이터를 가져오기 위해 jQuery를 사용합니다
    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
    $.get("/download/web/data/chicken.json", function(data) {
        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        var markers = $(data.positions).map(function(i, position) {
            return new kakao.maps.Marker({
                position : new kakao.maps.LatLng(position.lng, position.lat)
            });
        });

        // 클러스터러에 마커들을 추가합니다
        clusterer.addMarkers(markers);
    }); */
    
</script>