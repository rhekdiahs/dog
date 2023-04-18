<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f51f9d8c2a383e5820415bbc36c1551a&libraries=services,clusterer,drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/marker.css">
<!-- 중앙컨텐츠 시작 -->
<div id="main_body">
	<div id="map"></div>
	<script src="${pageContext.request.contextPath}/js/main_coord.js"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(coordY, coordX),
			level: zoomLevel
		};

		var map = new kakao.maps.Map(container, options);
	</script>	
	<form action="cafeList.do" id="search_region" method="get">
		<ul class="search" style="list-style: none;">
			<li>
				<select name="keyfield" id="keyfield" onchange="changeSelect()">
					<option selected="selected">--선택</option>
					<option value="서울특별시" <c:if test="${param.keyfield == '서울특별시'}">selected</c:if>>서울특별시</option>
					<option value="부산광역시" <c:if test="${param.keyfield == '부산광역시'}">selected</c:if>>부산광역시</option>
					<option value="대구광역시" <c:if test="${param.keyfield == '대구광역시'}">selected</c:if>>대구광역시</option>
					<option value="인천광역시" <c:if test="${param.keyfield == '인천광역시'}">selected</c:if>>인천광역시</option>
					<option value="광주광역시" <c:if test="${param.keyfield == '광주광역시'}">selected</c:if>>광주광역시</option>
					<option value="대전광역시" <c:if test="${param.keyfield == '대전광역시'}">selected</c:if>>대전광역시</option>
					<option value="울산광역시" <c:if test="${param.keyfield == '울산광역시'}">selected</c:if>>울산광역시</option>
					<option value="세종특별자치시" <c:if test="${param.keyfield == '세종특별자치시'}">selected</c:if>>세종특별자치시</option>
					<option value="경기도" <c:if test="${param.keyfield == '경기도'}">selected</c:if>>경기도</option>
					<option value="강원도" <c:if test="${param.keyfield == '강원도'}">selected</c:if>>강원도</option>
					<option value="충청북도" <c:if test="${param.keyfield == '충청북도'}">selected</c:if>>충청북도</option>
					<option value="충청남도" <c:if test="${param.keyfield == '충청남도'}">selected</c:if>>충청남도</option>
					<option value="전라북도" <c:if test="${param.keyfield == '전라북도'}">selected</c:if>>전라북도</option>
					<option value="전라남도" <c:if test="${param.keyfield == '전라남도'}">selected</c:if>>전라남도</option>
					<option value="경상북도" <c:if test="${param.keyfield == '경상북도'}">selected</c:if>>경상북도</option>
					<option value="경상남도" <c:if test="${param.keyfield == '경상남도'}">selected</c:if>>경상남도</option>
					<option value="제주특별자치도" <c:if test="${param.keyfield == '제주특별자치도'}">selected</c:if>>제주특별자치도</option>
				</select>
				<script type="text/javascript">
					$('#keyfield').change(function(){
						location.href = "/cafe/cafeList.do?keyfield=" + $(this).val();
					});
				</script>	
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
				<input type="submit" value="찾기">
		</ul>
	</form>
	<c:if test="${count > 0}">
	<div>
	 <table class="table table-sm">
	     <tr>
	         <th>카페 이름</th>
	         <th>카페 종류</th>
	         <th>카페 주소</th>
	     </tr>
	     <c:forEach var="cafe" items="${cafe}">
	     <tr>
	       <td><a href="cafeDetail.do?cafe_num=${cafe.cafe_num}">${cafe.cafe_name}</a></td>
	       <td>${cafe.cafe_cate}</td>
	       <td>${cafe.cafe_addr1}</td>
	     </tr>
	     </c:forEach>
	</table>
	</div>
	<div class="align-center">${page}</div>
	</c:if>
<script>
		/*========================= 
		지도 화면 크기에 맞춰서 사이즈 설정
		===========================*/
		var test_dicts = {};
	
	    var cafe_arrays = [];
		
	    <c:forEach var="cafe" items="${cafe}">
	    
	    	test_dicts['cafe_name'] = '${cafe.cafe_name}';
			test_dicts['cafe_type'] = '${cafe.cafe_type}';
			test_dicts['cafe_addr1'] = '${cafe.cafe_addr1}';
			test_dicts['cafe_addr2'] = '${cafe.cafe_addr2}';
			test_dicts['cafe_phone'] = '${cafe.cafe_phone}';
			test_dicts['cafe_site'] = '${cafe.cafe_site}';
	    	test_dicts['latlng'] = new kakao.maps.LatLng("${cafe.cafe_y}", "${cafe.cafe_x}");
	
	    	cafe_arrays.push(test_dicts);
	
	    	var test_dicts = {};    
	    </c:forEach>
	
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		var clickedOverlay = null;    
		cafe_arrays.forEach(function (pos) {
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: pos.latlng, // 마커를 표시할 위치
		        title : pos.cafe_name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
	
		    var content = document.createElement('div');
			content.className = 'cont-wrap';
			
		    var info = document.createElement('div');
		    info.className = 'info';
		    content.appendChild(info);
		    
		    var contentName = document.createElement("div");
		    contentName.className = "title";
		    contentName.appendChild(document.createTextNode(pos.cafe_name));
			info.appendChild(contentName);
	
		    var closeBtn = document.createElement('div');
		    closeBtn.className = "close";
		    // 닫기 이벤트 추가
		    closeBtn.onclick = function() {
		        overlay.setMap(null);
		    };
		    contentName.appendChild(closeBtn);
		    
		    /* var contentBody = document.createElement("div");
		    contentBody.className = "body";
		    info.appendChild(contentBody); */
		    
		    var contentImage = document.createElement("img");
		    contentImage.className = "image";
		    contentImage.src = "${pageContext.request.contextPath}/image_bundle/dog_cafe.png";
		    //contentImage.appendChild(document.createTextNode());
			info.appendChild(contentImage);
		    
		    var contentRoad = document.createElement("div");
		    contentRoad.className = "addr1";
		    contentRoad.appendChild(document.createTextNode(pos.cafe_addr1));
		    info.appendChild(contentRoad);
		    
		    var contentAddr = document.createElement("div");
		    contentAddr.className = "addr2";
		    contentAddr.appendChild(document.createTextNode("(지번) " + pos.cafe_addr2));
		    info.appendChild(contentAddr);
		    
		    var contentPhone = document.createElement("div");
		    contentPhone.className = "phone";
		    contentPhone.appendChild(document.createTextNode(pos.cafe_phone));
		    info.appendChild(contentPhone);
		    
		    var contentDetail = document.createElement("a");
		    contentDetail.className = "detail";
		    contentDetail.innerHTML = "상세보기";
		    <c:forEach var="cafe" items="${cafe}">
		    contentDetail.href = "cafeDetail.do?cafe_num=${cafe.cafe_num}";
		    </c:forEach>
		    info.appendChild(contentDetail);
		    
		    // customoverlay 생성, 이때 map을 선언하지 않으면 지도위에 올라가지 않습니다.
		    var overlay = new daum.maps.CustomOverlay({
		        position: pos.latlng,
		        content: content
		    });
	
		    // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
	/* 	    kakao.maps.event.addListener(marker, 'click', function() {
		        overlay.setMap(map);
		    }); */
		    kakao.maps.event.addListener(marker, 'click', function() {
		        if (clickedOverlay) {
		        	clickedOverlay.setMap(null);
		        }
		        overlay.setMap(map);
		        clickedOverlay = overlay;
		      });
		});
	</script>
</div>
<!-- 중앙컨텐츠 끝 -->