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
<script src="${pageContext.request.contextPath}/js/setBookmark.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/walk_overlays.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/walk.css">
<div class = "wrap">
<form:form action="selectOption.do" id="search_region" method="get">
	<ul id = "searchBar" class="search" style="list-style: none;">
	<li>
	<div class = "inputWrap">
	<select name="keyfield" id="keyfield">
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
			location.href = "/walk/selectOption.do?keyfield=" + $(this).val();
		});
	</script>
	<input type="search" name="keyword" id="keyword" value="${param.keyword}">
	<input type="submit" id="submitBtn" value="찾기">
	</div>
	</li>
	</ul>
</form:form>

<div id="map" style="border : 1px solid gray; border-radius : 5px;"></div>
	<div class="custom_zoomcontrol radius_border"> 
       		<span onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></span>  
        	<span onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></span>
    </div>
    <div id = "forFit"></div>
<!-- list scroll -->
<c:if test="${list == null}">
<ul  id="place-list" class="place-list">
	리스트 없음
</ul>
</c:if>
<c:if test="${list != null}">
<div>
	<ul id="place-list" class="place-list">
		<c:forEach var="list" items="${list}" varStatus="status">
			<li id="${list.walk_num}">
				<div class = "place-bookmark">
					<div onclick = "bookmark(this)" data-num = "${list.walk_num}">
						<img src = "${pageContext.request.contextPath}/image_bundle/bookmark0.png">
					</div>
					<script>
							getBookmark("${list.walk_num}");
					</script>
				</div>
				<div class="list-title">
					<a href="/walk/viewWalk.do?walk_num=${list.walk_num}"
						class="title-index"><strong class = "index-bound">${status.count}</strong></a> 
					<a href="/walk/viewWalk.do?walk_num=${list.walk_num}"
						class="title-index">
					<strong style = "color : #494949;">
					<c:if test="${list.mem_name != null}">${list.mem_name}</c:if>
					<c:if test="${list.mem_name == null}">🐶🐶</c:if>
					님의 산책로</strong></a>
				</div>
				<div class="list-content">
					<p><small>${list.walk_region}</small></p>
					<p><small>${list.walk_distance}m</small></p>
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
</c:if>
	<div id = "pageDiv" style = "text-align : center;">
		${page}
	</div>
</div>
<script type="text/javascript">
		//지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomIn() {
		    map.setLevel(map.getLevel() - 1);
		}
		
		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomOut() {
		    map.setLevel(map.getLevel() + 1);
		}
		
	    
		var mapContainer = document.getElementById('map'),
	    mapOptions = {
	        center: new kakao.maps.LatLng(coordY, coordX), // 지도의 중심좌표
	        level: zoomLevel // 지도의 확대 레벨
	    };
		
		var mapWidth = document.getElementById('place-list').firstElementChild;
		if(mapWidth != null){
			var rectPage = mapWidth.getBoundingClientRect();
			mapContainer.style.width = rectPage.width + 'px';
			mapContainer.style.height = rectPage.width + 'px';
		}else{
			var inputWarp = document.getElementsByClassName('inputWrap')[0];
			var rectPage = inputWarp.getBoundingClientRect();
			mapContainer.style.width = (parseInt(rectPage.width)) + 'px';
			mapContainer.style.height = (parseInt(rectPage.width)) + 'px';
		    $('#place-list').hide();
		}
		
		//container.style.width = (visualViewport.width*0.92) + 'px';
	    //container.style.height = (visualViewport.width*0.92) + 'px';
	    
	    mapContainer.style.width = rectPage.width + 'px';
	    mapContainer.style.height = rectPage.width + 'px';
		// 지도 div와 지도 옵션으로 지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOptions), overlays = []; // 지도에 그려진 도형을 담을 배열
		    
		var pageDiv = document.getElementById('pageDiv');
		var rectPage = pageDiv.getBoundingClientRect();
		var rect = mapContainer.getBoundingClientRect();
		$('.place-list').css("height", parseInt(visualViewport.height) - parseInt(rect.bottom) - parseInt(rectPage.height+20) + 'px');
		
		
		let walk_array = [];
		
		let walk_dict = {};
		
		<c:forEach var="path" items="${list}">
			walk_dict['walk_num'] = '${path.walk_num}';
			walk_dict['path'] = '${path.walk_position}';
			walk_dict['city'] = '${path.walk_region}';
			walk_dict['mem_name'] = '${path.mem_name}';
			walk_dict['addr'] = '${path.walk_address}';
			walk_dict['walk_distance'] = '${path.walk_distance}';
			walk_array.push(walk_dict);
			walk_dict = {};
		</c:forEach>
		
		
	    var coord = [];
	    var clickedOverlay = null;
		var clickedTr = null;
	 // Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
		function drawPolyline() {
			//var len = lines.length, i = 0;
			walk_array.forEach(function(pos, index){
				var pathsOfList = pos.path.split(",");		//구분자
				console.log(pathsOfList);
				for(var j=0; j<pathsOfList.length; j+=2){
		    	  	var latlng = new kakao.maps.LatLng(pathsOfList[j+1],pathsOfList[j]);
		    	  	coord.push(latlng);
		    	}
				
				var polyline = new kakao.maps.Polyline({
		            map: map,
		            path: coord,
		            strokeColor: '#39f',
		            strokeOpacity: 1
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
				
				var content = document.createElement('div');
				content.className = 'cont-wrap';
				
			    var info = document.createElement('div');
			    info.className = 'info';
			    content.appendChild(info);
			    
			    var contentName = document.createElement("div");
			    contentName.className = "title";
			    
			    var contentLink = document.createElement("a");
				contentLink.className = "link";
				contentLink.appendChild(document.createTextNode(pos.mem_name + ' 님의 산책로'));
			    contentLink.href = "viewWalk.do?walk_num=" + pos.walk_num;
			    contentName.appendChild(contentLink);
				info.appendChild(contentName);

			    var closeBtn = document.createElement('div');
			    closeBtn.className = "close";
			    // 닫기 이벤트 추가
			    closeBtn.onclick = function() {
			        overlay.setMap(null);
			    };
			    contentName.appendChild(closeBtn);
				
			    var contentImg = document.createElement("img");
			    contentImg.className = "image";
			    contentImg.setAttribute("src", "${pageContext.request.contextPath}/image_bundle/sitting-dog.png");
			    contentImg.setAttribute("width", "55");
			    contentImg.setAttribute("height", "55");
			    contentImg.setAttribute("style", "margin-left : 5px; margin-top : 5px;");
				info.appendChild(contentImg);
				
			    var contentRoad = document.createElement("div");
			    contentRoad.className = "addr1";
			    contentRoad.appendChild(document.createTextNode(pos.addr));
			    info.appendChild(contentRoad);
			    
/* 			    var contentAddr = document.createElement("div");
			    contentAddr.className = "addr2";
			    contentAddr.appendChild(document.createTextNode("(지번) " + pos.h_address));
			    info.appendChild(contentAddr);
			    
			    var contentPhone = document.createElement("div");

			    if(pos.h_phone != ""){
				    contentPhone.className = "phone";
				    var contentPhoneImg = document.createElement('img');
				    contentPhoneImg.className = "phoneImg";
				    contentPhoneImg.src = "${pageContext.request.contextPath}/image_bundle/phone_img.png";
				    contentPhoneImg.setAttribute("style", "margin-top: 2px;");
				    contentPhone.appendChild(contentPhoneImg)
				    contentPhone.appendChild(document.createTextNode(" " + pos.h_phone));
			    }
			    info.appendChild(contentPhone); */
			    
			    var contentDetail = document.createElement("a");
			    contentDetail.className = "detail";
			    contentDetail.innerHTML = "상세보기";
			    contentDetail.href = "viewWalk.do?walk_num=" + pos.walk_num;
			    info.appendChild(contentDetail);
			    
				var overlay = new daum.maps.CustomOverlay({
			        position: new kakao.maps.LatLng(coord[center].Ma,coord[center].La),
			        content: content
			    });
				
				kakao.maps.event.addListener(marker, 'click', function() {
			    	var elem = document.getElementById(pos.walk_num);
			    	let rect = elem.getBoundingClientRect();
			    	 $('.place-list').animate({scrollTop:index * rect.height}, 680);
			        if (clickedOverlay) {
			        	clickedOverlay.setMap(null);
			        	clickedTr.style.background = '';
			        }
			        clickedTr = document.getElementById(pos.walk_num);
			        clickedTr.style.background = '#faf5ef';
			        overlay.setMap(map);
			        clickedOverlay = overlay;
			        map.setLevel(map.getLevel());
			        map.panTo(marker.getPosition());
			    });
				var clicked = document.getElementById(pos.walk_num);
			    
			    clicked.addEventListener('click', function(){
			    	var elem = document.getElementById(pos.walk_num);
			    	let rect = elem.getBoundingClientRect();
			    	//$(".place-list").scrollTop(rect.top);
			    	//$('.place-list').scrollTop(index * rect.height);
			    	 $('.place-list').animate({scrollTop:index * rect.height}, 680);
			    	if (clickedOverlay) {
			        	clickedOverlay.setMap(null);
			        	clickedTr.style.background = '';
			        }
			        clickedTr = document.getElementById(pos.walk_num);
			        clickedTr.style.background = '#faf5ef';
			        overlay.setMap(map);
			        clickedOverlay = overlay;
			        map.setLevel(5);
			        map.panTo(marker.getPosition());
			    });
				coord =[];
			});
/* 		    for (var i=0; i < walk_array.length; i++) {	//x좌표,y좌표
		    	var pathsOfList = walk_array[i].path.split(", ");
		    	
		    	for(var j=0; j<pathsOfList.length; j+=2){
		    	  	var latlng = new kakao.maps.LatLng(pathsOfList[j+1],pathsOfList[j]);
		    	  	coord.push(latlng);
		    	}
		        //var style = lines.options;
		        var polyline = new kakao.maps.Polyline({
		            map: map,
		            path: coord,
		            strokeColor: '#39f',
		            strokeOpacity: 1
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
				var overlay = new daum.maps.CustomOverlay({
			        position: new kakao.maps.LatLng(coord[center].Ma,coord[center].La),
			        content: '가나다라마ㅏ바'
			    });
				
				kakao.maps.event.addListener(marker, 'click', function() {
			    	var elem = document.getElementById('183');
			    	let rect = elem.getBoundingClientRect();
			    	 $('.place-list').animate({scrollTop:index * rect.height}, 680);
			        if (clickedOverlay) {
			        	clickedOverlay.setMap(null);
			        	clickedTr.style.background = '';
			        }
			        clickedTr = document.getElementById('183');
			        clickedTr.style.background = '#feea3e';
			        overlay.setMap(map);
			        clickedOverlay = overlay;
			        map.setLevel(map.getLevel());
			        map.panTo(marker.getPosition());
			    });
				coord =[];
				
		    } */
		    
		}	
		walk_array.forEach(function(pos, index){
			var imageSize = new kakao.maps.Size
		});
 	//선그리기 
	$(function() {
		drawPolyline();
	}); 
</script>