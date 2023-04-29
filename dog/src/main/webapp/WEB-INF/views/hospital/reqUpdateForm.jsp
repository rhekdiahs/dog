<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>    
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reqUpdateForm.css">  
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab928e5929563772b2932e6182f6b7d9&libraries=services"></script>
<div class = "req-wrap">
	<h3>정보 수정 제안</h3>
	<hr>
	<div class = "content-header">
		<img src = "${pageContext.request.contextPath}/image_bundle/dogquestion.png" style = "width : 80px; height : 75px;">
		<p>지도 정보가 실제 정보와 다른가요?</p>
		<br>
		<p>수정 신청을 해주세요.</p>
	</div>
	<div>
		<input id = "hostURL" type = "text" style = "display : none;" value = "${hostURL}">
		<input id = "pk_num" type = "text" style = "display : none;" value = "${pk_num}">
	</div>
	<ul class = "select-section">
		<li onclick = "linkTo(this)" data-li = "Pdelete">> 해당 위치에 지정된 장소가 없어요.</li>
		<li class = "hide" id ="PdeleteLi"></li>
		<hr>
		<li onclick = "linkTo(this)" data-li = "Pname">> 장소명을 수정해주세요.</li>
		<li class = "hide" id ="PnameLi"></li>
		<hr>
		<li onclick = "linkTo(this)" data-li = "Pdetail">> 상세 내용을 수정해주세요.</li>
		<li class = "hide" id ="PdetailLi"></li>
		<hr>
		<li onclick = "linkTo(this)" data-li = "Pphoto">> 사진을 수정해주세요.</li>
		<li class = "hide" id ="PphotoLi"></li>
		<hr>
		<li onclick = "linkTo(this)" data-li = "Ploc">> 위치를 수정해주세요.</li>		
		<li class = "hide" id ="PlocLi" style = "margin-bottom : 20px;" ></li>
		<hr>
		<li></li>	
	</ul>
	<div class = "submit-btn">
		<button id = "submit">제출하기</button>
	</div>
</div>
<script>
var clickedLi;
var a;
var geocoder = new kakao.maps.services.Geocoder();
	function linkTo(e){
		var hostURL = $('#hostURL').val();
		var pk_num = $('#pk_num').val();
		var reqType = $(e).attr('data-li');
	
		var submenu = $(e).next("li");
		if(clickedLi){
			clickedLi.slideUp();
			clickedLi = '';
		}
		if(submenu.is(":visible")){
	    	submenu.slideUp('slow', function(){
	    		$('.reqContWrap').remove();
	    	});
			clickedLi = '';
		}else{
	   		submenu.slideDown('slow', function(){
	   		if(reqType == 'Pdelete'){
	   			createPdel(reqType);
	   			
	   		}else if (reqType == 'Pname'){
	   			createPname(reqType);
	   		}else if (reqType == 'Pdetail'){
	   			createPdetail(reqType);
	   		}else if (reqType == 'Pphoto'){
	   			createPphoto(reqType);
	   		}else if (reqType == 'Ploc'){
	   			createPloc(reqType);
	   			
	   			const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	   			
	   			let options = { //지도를 생성할 때 필요한 기본 옵션
	   				center: new kakao.maps.LatLng('${coord_y}', '${coord_x}'), //지도의 중심좌표.
	   				level: 3 //지도의 레벨(확대, 축소 정도)
	   			};
	   			let map = new kakao.maps.Map(container, options);
	   			
	   			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	 			// 마커 이미지의 이미지 크기 입니다
		   	 	var imageSize = new kakao.maps.Size(24, 35);
		   		// 마커 이미지를 생성합니다    
		    	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		   		
	   			var marker = new kakao.maps.Marker({
	   		        map: map, // 마커를 표시할 지도
	   		        position: new kakao.maps.LatLng('${coord_y}', '${coord_x}'), // 마커를 표시할 위치
	   		        image : markerImage // 마커 이미지 
	   		    });
	   			searchDetailAddrFromCoords(map.getCenter(), function(result, status) {
					if (status === kakao.maps.services.Status.OK) {
						var road = document.getElementById('road');
						road.value = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
					}
				});
	   			kakao.maps.event.addListener(map, 'center_changed', function() {
	   			 	var position = map.getCenter();
	    			marker.setPosition(position);
	    			searchDetailAddrFromCoords(map.getCenter(), function(result, status) {
	    				if (status === kakao.maps.services.Status.OK) {
	    					var road = document.getElementById('road');
	    					road.value = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
	    				}
	    			});
	   			});
	   		}
	   		
		});
			clickedLi = submenu;
		}
	
		curURL = document.location.href.split('&')[0];
		history.pushState(null, null,curURL+'&reqType='+ reqType);
	}
	
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/reqUpdateForm.js"></script>