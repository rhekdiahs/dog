<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

  	<p class="modes">
	    <button onclick="selectOverlay('POLYLINE');">선</button>
	    <button onclick="getPointsAndPost();">저장</button>
	</p>
<div id="map" style="width:500px;height:400px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing"></script>
<script>
	var mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var mapOption = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.45115170127237, 126.57331344620394), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
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
	
	function getPointsAndPost() {
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
		console.log(xAndY);
		
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