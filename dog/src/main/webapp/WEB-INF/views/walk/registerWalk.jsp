<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<script src="${pageContext.request.contextPath}/js/main_coord.js"></script>
<script src="${pageContext.request.contextPath}/js/main_findLocation.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/walk.css">
<form:form action="selectRegionFromRegister.do" method="get">
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
		location.href = "/walk/selectRegionFromRegister.do?keyfield=" + $(this).val();
	});
</script>
</form:form>
<div style="width:100%;">
	<form style="min-width:300px;" onsubmit="searchPlaces(); return false;">
		<input type="text" value="" placeholder="장소를 입력하세요" id="keyword" size="15" style="width:85%;">
		<button type="submit" style="width:13%;">검색</button>
	</form>
</div>
<p class="modes">
	    <button id="draw_btn" onclick="selectOverlay('POLYLINE');" >그리기</button>
	    <button id="drawEnd_btn" disabled="disabled" onclick="end();" >그리기 종료</button>
	    <button id="reset_btn" disabled="disabled" onclick="resetMap();" >초기화</button>
	    <button id="register_btn" onclick="getPointsAndPost();">저장</button>
	</p>
<div id="map" style="width:100%;height:400px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing,services"></script>
<script type="text/javascript">

	var keyfield = decodeURI(link);
	var curLink = window.location.href;
	
	var mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	if(curLink.split('mapCen=')[1] == null){
		var mapOption = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(coordY,coordX), //지도의 중심좌표.
			level: 4 //지도의 레벨(확대, 축소 정도)
		};
	}else{
		var a = curLink.split('mapCen=')[1].split(',')[0];
		var b = curLink.split('mapCen=')[1].split(',')[1];
		var mapOption = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(a,b), //지도의 중심좌표.
			level: 2 //지도의 레벨(확대, 축소 정도)
		};
	}
	
	
	var map = new kakao.maps.Map(mapContainer, mapOption), //지도 생성 및 객체 리턴
		overlays = [];
	var options = {
		
		// Drawing Manager를 생성할 때 사용할 옵션입니다
		map : map, 		// Drawing Manager로 그리기 요소를 그릴 map 객체입니다
		drawingMode : [ // Drawing Manager로 제공할 그리기 요소 모드입니다
			kakao.maps.drawing.OverlayType.MARKER,
			kakao.maps.drawing.OverlayType.POLYLINE 
		],
		
		// 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    markerOptions: { // 마커 옵션입니다 
	        draggable: false, // 마커를 그리고 나서 드래그 가능하게 합니다 
	        removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
	    },
	    polylineOptions: { // 선 옵션입니다
	        draggable: false, // 그린 후 드래그가 가능하도록 설정합니다
	        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
	        editable: false, // 그린 후 수정할 수 있도록 설정합니다 
	        strokeColor: '#8cdcfc', // 선 색
	        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
	        hintStrokeOpacity: 0.5  // 그리중 마우스를 따라다니는 보조선의 투명도
	    }	    
	};
	
	// 위에 작성한 옵션으로 Drawing Manager 생성
	var manager = new kakao.maps.drawing.DrawingManager(options);
	
  	var drawingFlag = false;						
  	var drawable = document.getElementById('draw_btn');
  	var undrawable = document.getElementById('drawEnd_btn');
  	var reset = document.getElementById('reset_btn');
  	var saveMap = document.getElementById('register_btn');
    var clickLtnlng = [];
    var clickPos = '';
    var clickDistance = 0;	
	var clickPolyline = new kakao.maps.Polyline({
           map: '',
           path: clickLtnlng
    }); 
	function resetMap(){
		var mapCen = map.getCenter();
		location.href = '/walk/register.do?keyfield='+keyfield + '&mapCen=' + mapCen.Ma + ','+mapCen.La;
	}
	
	// 버튼 클릭 시 호출되는 핸들러 입니다
	function selectOverlay(type) {
	    // 그리기 중이면 그리기를 취소합니다
	    manager.cancel();

	    // 클릭한 그리기 요소 타입을 선택합니다
	    manager.select(kakao.maps.drawing.OverlayType[type]);
	}
	function end(){
		manager.cancel();
		clickPolyline = new kakao.maps.Polyline({
            map: map,
            path: clickLtnlng,//pathsOfList,
            strokeColor: '#fb6f41',
            strokeOpacity: 1
	    }); 
		 
		$('#moveOverlay').hide();
		
		if(clickDistance > 0){
			 var distanceOverlay = new kakao.maps.CustomOverlay({
		            map: map, // 커스텀오버레이를 표시할 지도입니다
		            content: '<div id="clickOverlay" class="dotOverlay distanceInfo" style = "background : white;">총거리 <span class="number">' + clickDistance + '</span>m</div>',  // 커스텀오버레이에 표시할 내용입니다
		            position: clickLtnlng[clickLtnlng.length-1], // 커스텀오버레이를 표시할 위치입니다.
		            xAnchor: 0,
		            yAnchor: 0,
		            zIndex: 3  
		        });   
		}
		
		//clickLtnlng = [];
	    drawingFlag=false;
		drawable.disabled = true;
		undrawable.disabled = true;
		reset.disabled = false;
		saveMap.disabled = false;
	}
	
		//그리기 시작하고 맨처음 누른 좌표를 좌표배열에 저장
		manager.addListener('drawstart', function(mouseEvent) {
			undrawable.disabled = false;
			reset.disabled = false;
			drawingFlag = true;
			saveMap.disabled = true;
			
			var coords = new kakao.maps.Coords(mouseEvent.coords.La,mouseEvent.coords.Ma);
   			coords = coords.toLatLng();	//WGS84로 변환
   			clickLtnlng.push(coords);
   			console.log(coords); 
		});
		
		//그리기 끝나면 더 클릭 못함
		manager.addListener('state_changed', function(e) {
		    clickLtnlng = [];
		    drawingFlag=false;
		});
		
		//그리기 끝나면 그리기버튼 비활성화
		manager.addListener('drawend', function(e){
			console.log(e);
			drawable.disabled = true;
			undrawable.disabled = true;
			distanceOverlay = false;
			drawingFlag = false;
			saveMap.disabled = false;
		});
		
		//그린 선 삭제 버튼 활성화
		manager.addListener('remove', function(e) {
			console.log(e);
			drawable.disabled = false;
			allReset();
		});
		
		var moveDistance = 0;
		var distanceOverlay ='';
		
		//해당 지점까지의 거리 계산
		kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
			if (drawingFlag){

					clickPolyline = new kakao.maps.Polyline({
			            map: '',
			            path: clickLtnlng,//pathsOfList,
			            strokeColor: '#fb6f41',
			            strokeOpacity: 1
				    }); 
					
					var mousePos = mouseEvent.latLng;
					
					var curPath = clickLtnlng;
					var movePath = [curPath[curPath.length-1], mousePos];
					
					var moveLine = new kakao.maps.Polyline({
			            map: '',
			            path: movePath,//pathsOfList,
			            strokeColor: '#fb6f41',
			            strokeOpacity: 1
				    }); 
					
					moveDistance = Math.round(clickPolyline.getLength() + moveLine.getLength());
					content = '<div id="moveOverlay" class="dotOverlay distanceInfo" style = "background : white; z-index : 1000; position : relative; top : 25px;">총거리 <span class="number">' + moveDistance + '</span>m</div>';
					//console.log('끌어당긴 데까지 거리' + moveDistance);					
					
					showDistance(content, mousePos);
			}
		});
		
   		kakao.maps.event.addListener(map,'click', function(mouseEvent) {
		/* 	console.log('클릭할 때마다 나와야되는데' + mouseEvent.coords);
			
   			var coords = new kakao.maps.Coords(mouseEvent.coords.La,mouseEvent.coords.Ma);
   			coords = coords.toLatLng();	//WGS84로 변환
   			
   			console.log(coords); */
			//mouseEvent.coords.La,
    		//mouseEvent.coords.Ma;

   			if(drawingFlag){
   				console.log('클릭할 때마다 나와야되는데' + mouseEvent.latLng);
	   		    clickPos = mouseEvent.latLng;	// 마우스로 클릭한 위치 좌표(object type)
	   		 	clickLtnlng.push(clickPos);		//배열에 넣어줌
	   		    
				if(clickLtnlng.length >= 2){
					//두 좌표의 거리를 구해서 eachDistance에다가 더해줌.
					clickPolyline = new kakao.maps.Polyline({
			            map: '',
			            path: clickLtnlng,//pathsOfList,
			            strokeColor: '#fb6f41',
			            strokeOpacity: 1
				    }); 
					
					//console.log('<<<<' + clickLtnlng);
					clickDistance = Math.round(clickPolyline.getLength());
					console.log('클릭한 데까지 거리 = ' + clickDistance);
					
					if(clickDistance >= 1500){
						console.log('초과');
		   				alert('1.5km까지만 등록할 수 있음');
		   				manager.cancel();
		   				distanceOverlay.setMap(null);
		   				distanceOverlay = false;
		   				clickLtnlng = [];
		   				clickDistance = 0;
		   				clickPolyline = '';
		   				drawingFlag=false;
		   				undrawable.disabled = true;
		   				saveMap.disabled = true;
		   				return;
		   			}
					//console.log(clickPolyline.Sg);
				}
					
   			}
   		});
   		
   		//그려놓은 선, 거리, 좌표 다 초기화
   		function allReset(){
   			moveDistance = 0;
   			clickLtnlng = [];
   			clickPos = '';
   			clickPolyline = new kakao.maps.Polyline({
   	           map: '',
   	           path: clickLtnlng
   	   		});  
   			clickDistance = 0;
   		}
   		
  	function showDistance(content, position) {
	    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
	    	
		        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
		        distanceOverlay.setPosition(position);
		        distanceOverlay.setContent(content);
	    	
	    }else { // 커스텀 오버레이가 생성되지 않은 상태이면
		        // 커스텀 오버레이를 생성하고 지도에 표시합니다
		        distanceOverlay = new kakao.maps.CustomOverlay({
		            map: map, // 커스텀오버레이를 표시할 지도입니다
		            content: content,  // 커스텀오버레이에 표시할 내용입니다
		            position: position, // 커스텀오버레이를 표시할 위치입니다.
		            xAnchor: 0,
		            yAnchor: 0,
		            zIndex: 3  
		        });
	    }
 	}
  	
		//장소검색하기
		var ps = new kakao.maps.services.Places(); 
		var region = $('#keyfield').val();
		if(region == ''){
			console.log('지역 없음');
		}
		
		function searchPlaces() {
			console.log(region);
			
		    var keyword = $('#keyword').val();
			var link = decodeURI(document.location.href.split('keyfield=')[1]);
			
			//링크를 키워드 맨 앞에 넣어서 검색되게
			//DB에 저장될 때는 범위 좌표 -> if(link != 좌표로 얻어낸 장소 맨앞 시) -> 주소값 -> 맨앞에 있는 거 저장
			
		   /*  if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('검색어를 입력해주세요');
		        return false;
		    }
 */
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch(link + ' ' + keyword, placesSearchCB); 
		}
		
		function placesSearchCB (data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		        
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
		    }else if (status === kakao.maps.services.Status.ERROR) {
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;

		    }
		}
		
		console.log(region);
	
	var geocoder = new kakao.maps.services.Geocoder();
	//좌표로 주소 얻어오기
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
	}
	
	function getPointsAndPost() {		//저장하기
	    // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
	    /* var data = manager.getData();
	    var polylinedata = data[kakao.maps.drawing.OverlayType.POLYLINE][0];
	    var points = polylinedata.points; */			//찍은 좌표들
	    var points = clickLtnlng;
	    //console.log(data);
	    //console.log(polylinedata);
	    
	    console.log(points);
		let xAndY = [];								//DB 좌표 담을 배열
		
	    for(var i=0; i<points.length; i++){
	    	console.log(points[i]);
		    console.log(points[i].Ma);				//경도
		    console.log(points[i].La);				//위도
		    
		    
		    //xAndY.push('(');
		    xAndY.push(points[i].La);		//문자열로 변환 후 저장
		    //xAndY.push(',');
		    xAndY.push(points[i].Ma);
		    //xAndY.push(')');
		    
		   /*  if(i<points.length-1){
		    	xAndY.push(',');
		    } */		    
	    }
		
		console.log(xAndY);							//String[]	
		console.log(points[Math.round(points.length /2)]);
		
		searchDetailAddrFromCoords(points[Math.round(points.length /2)], function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	        		region = result[0].region_1depth_name;
	        }
		});

		$.ajax({
			url : 'insertPoints.do',
			traditional : true,						//필수
			data : {pointsArr : xAndY, region : region, distance : clickDistance},
			type : 'post',
			dataType : 'json',
			//status :: null/success/fail
			success : function(result){
				if(result.status == 'success'){
					alert('dB 저장 성공');
				}else if(result.status == 'null'){
					alert('null');
				}else if(result.status == 'fail'){
					alert('DB 저장 실패');
				}else{
					alert('NETWORK ERROR');
				}
			},
			error : function(){
				alert('에러');
			}
		});  
	}
		
		
</script>
