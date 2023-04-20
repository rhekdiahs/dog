<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
  	<p class="modes">
	    <button onclick="selectOverlay('POLYLINE');">선</button>
	    <button onclick="getPointsAndPost();">저장</button>
	</p>
<div id="map" style="width:500px;height:400px;"></div>
<form:form>
	<select>
		<option selected="selected">--선택</option>
		<option value="서울특별시"
			<c:if test="${param.keyfield == '서울특별시'}">selected</c:if>>서울특별시</option>
		<option value="부산광역시"
			<c:if test="${param.keyfield == '부산광역시'}">selected</c:if>>부산광역시</option>
		<option value="대구광역시"
			<c:if test="${param.keyfield == '대구광역시'}">selected</c:if>>대구광역시</option>
		<option value="인천광역시"
			<c:if test="${param.keyfield == '인천광역시'}">selected</c:if>>인천광역시</option>
		<option value="광주광역시"
			<c:if test="${param.keyfield == '광주광역시'}">selected</c:if>>광주광역시</option>
		<option value="대전광역시"
			<c:if test="${param.keyfield == '대전광역시'}">selected</c:if>>대전광역시</option>
		<option value="울산광역시"
			<c:if test="${param.keyfield == '울산광역시'}">selected</c:if>>울산광역시</option>
		<option value="세종특별자치시"
			<c:if test="${param.keyfield == '세종특별자치시'}">selected</c:if>>세종특별자치시</option>
		<option value="경기도"
			<c:if test="${param.keyfield == '경기도'}">selected</c:if>>경기도</option>
		<option value="강원도"
			<c:if test="${param.keyfield == '강원도'}">selected</c:if>>강원도</option>
		<option value="충청북도"
			<c:if test="${param.keyfield == '충청북도'}">selected</c:if>>충청북도</option>
		<option value="충청남도"
			<c:if test="${param.keyfield == '충청남도'}">selected</c:if>>충청남도</option>
		<option value="전라북도"
			<c:if test="${param.keyfield == '전라북도'}">selected</c:if>>전라북도</option>
		<option value="전라남도"
			<c:if test="${param.keyfield == '전라남도'}">selected</c:if>>전라남도</option>
		<option value="경상북도"
			<c:if test="${param.keyfield == '경상북도'}">selected</c:if>>경상북도</option>
		<option value="경상남도"
			<c:if test="${param.keyfield == '경상남도'}">selected</c:if>>경상남도</option>
		<option value="제주특별자치도"
			<c:if test="${param.keyfield == '제주특별자치도'}">selected</c:if>>제주특별자치도</option>
	</select>
</form:form>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing"></script>
<script>
	var mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var mapOption = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.45115170127237, 126.57331344620394), //지도의 중심좌표.
		level: 4 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); //지도 생성 및 객체 리턴
	
	var options = {
		
		// Drawing Manager를 생성할 때 사용할 옵션입니다
		map : map, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
		drawingMode : [ // Drawing Manager로 제공할 그리기 요소 모드입니다
			kakao.maps.drawing.OverlayType.MARKER,
			kakao.maps.drawing.OverlayType.POLYLINE 
		],
		
		// 사용자에게 제공할 그리기 가이드 툴팁입니다
	    // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
	    guideTooltip: ['draw', 'drag', 'edit'], 
	    markerOptions: { // 마커 옵션입니다 
	        draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
	        removable: true // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
	    },
	    polylineOptions: { // 선 옵션입니다
	        draggable: false, // 그린 후 드래그가 가능하도록 설정합니다
	        removable: true, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
	        editable: true, // 그린 후 수정할 수 있도록 설정합니다 
	        strokeColor: '#39f', // 선 색
	        hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
	        hintStrokeOpacity: 0.5  // 그리중 마우스를 따라다니는 보조선의 투명도
	    }	    
	};
	
	// 위에 작성한 옵션으로 Drawing Manager를 생성합니다
	var manager = new kakao.maps.drawing.DrawingManager(options);
	
	// 버튼 클릭 시 호출되는 핸들러 입니다
	function selectOverlay(type) {
	    // 그리기 중이면 그리기를 취소합니다
	    manager.cancel();

	    // 클릭한 그리기 요소 타입을 선택합니다
	    manager.select(kakao.maps.drawing.OverlayType[type]);
	}
	
   		kakao.maps.event.addListener(map,'mousemove',function (mouseEvent) {
   			// 마우스 커서의 현재 위치
   	        var mousePos = mouseEvent.latLng;
   		});
   		
   		var drawingFlag = false;						//선이 그려지고 있는 상태
	    var clickLtnlng = [];
	    var clickPos = '';
	    var clickDistance = 0;	
		var clickPolyline = new kakao.maps.Polyline({
            map: '',
            path: clickLtnlng,//pathsOfList,
            strokeColor: '#39f',//style.strokeColor,
            strokeOpacity: 5
            //strokeStyle: style.strokeStyle,
            //strokeWeight: style.strokeWeight
	    }); 
	    
   		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			console.log('클릭할 때마다 나와야되는데' + mouseEvent.latLng);
   		    clickPos = mouseEvent.latLng;	// 마우스로 클릭한 위치 좌표(object type)
   		 	clickLtnlng.push(clickPos);		//배열에 넣어줌
   		    
			if(clickLtnlng.length >= 2){
				//두 좌표의 거리를 구해서 eachDistance에다가 더해줌.
				clickPolyline = new kakao.maps.Polyline({
		            map: '',
		            path: clickLtnlng,//pathsOfList,
		            strokeColor: '#39f',//style.strokeColor,
		            strokeOpacity: 5
		            //strokeStyle: style.strokeStyle,
		            //strokeWeight: style.strokeWeight
			    }); 
				
				clickDistance = Math.round(clickPolyline.getLength());
				console.log(clickDistance);
			}
   		});
   		
	function getPointsAndPost() {		//저장하기
	    // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
	    var data = manager.getData();
	    var polylinedata = data[kakao.maps.drawing.OverlayType.POLYLINE][0];
	    var points = polylinedata.points;			//찍은 좌표들
	    
	    //console.log(data);
	    console.log(polylinedata);
	    
		let xAndY = [];								//DB 좌표 담을 배열
		
	    for(var i=0; i<points.length; i++){
	    	console.log(points[i]);
		    console.log(points[i].x);				//경도
		    console.log(points[i].y);				//위도
		    
		    
		    //xAndY.push('(');
		    xAndY.push(points[i].x.toString());		//문자열로 변환 후 저장
		    //xAndY.push(',');
		    xAndY.push(points[i].y.toString());
		    //xAndY.push(')');
		    
		   /*  if(i<points.length-1){
		    	xAndY.push(',');
		    } */		    
	    }
		console.log(xAndY);							//String[]
   		
		$.ajax({
			url : 'insertPoints.do',
			traditional : true,						//필수
			data : {pointsArr : xAndY},
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
	
	// Drawing Manager에서 가져온 데이터 중 
	// 선과 다각형의 꼭지점 정보를 kakao.maps.LatLng객체로 생성하고 배열로 반환하는 함수입니다 
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