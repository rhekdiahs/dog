<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab928e5929563772b2932e6182f6b7d9&libraries=services"></script>
<script src="${pageContext.request.contextPath}/js/main_coord.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/hospital.css">
<div id = "map"></div>
	<div class = "wrap">
		<form action="h_selectOption.do" id="search_region" method="get">
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
							location.href = "/hospital/h_selectOption.do?keyfield=" + $(this).val();
						});
					</script>	
					<input type="search" name="keyword" id="keyword" value="${param.keyword}">
					<input type="submit" value="찾기">
			</ul>
		</form>
		<div>
			<table>
			    <tr>
			     	<th>번호</th>
			        <th>지역</th>
			        <th>x좌표</th>
			        <th>y좌표</th>
			        <th>24시</th>
			        <th>도로명주소</th>
			    </tr>
			    <c:forEach var="list" items="${list}">
		     	<tr>
		     	<td>${list.hospital_num }</td>
			        <td>${list.hospital_region}</td>
			        <td>${list.coord_x}</td>
			        <td>${list.coord_y}</td>
			        <td>
		         	<c:if test = "${list.hospital_type == 0}">일반</c:if>
		         	<c:if test = "${list.hospital_type == 1}">24시</c:if>
			        </td>
			        <td>${list.road }</td>
			    </tr>
			    </c:forEach>
			</table>
		</div>
		<div>
			${page }
			<br>
			${ip}
		</div>
	</div>
<script>
	const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	
	let options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(coordY, coordX), //지도의 중심좌표.
		level: zoomLevel //지도의 레벨(확대, 축소 정도)
	};
	
	let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var geocoder = new kakao.maps.services.Geocoder();
	
    var test_dicts = {};

    var hospital_arrays = [];
	
    <c:forEach var="list" items="${list}">
    	test_dicts['type'] = '${list.hospital_type}'; //타입
    	test_dicts['road'] = '${list.road}';	//도로명주소
    	test_dicts['h_name'] = '${list.h_name}';	//상호명
    	test_dicts['h_address'] = '${list.h_address}';	//지번주소
    	test_dicts['h_phone'] = '${list.h_phone}';	//지번주소
    	test_dicts['latlng'] = new kakao.maps.LatLng("${list.coord_y}", "${list.coord_x}"); //좌표

    	hospital_arrays.push(test_dicts);
    	var test_dicts = {};    
    </c:forEach>

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	var clickedOverlay = null;
	hospital_arrays.forEach(function (pos) {
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: pos.latlng, // 마커를 표시할 위치
	        title : pos.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });

	    var content = document.createElement('div');
		content.className = 'cont-wrap';
		
	    var info = document.createElement('div');
	    info.className = 'info';
	    content.appendChild(info);
	    
	    var contentName = document.createElement("div");
	    contentName.className = "h-name";
	    contentName.appendChild(document.createTextNode(pos.h_name));
		info.appendChild(contentName);

	    var closeBtn = document.createElement('button');
	    closeBtn.appendChild(document.createTextNode('닫기'));
	    // 닫기 이벤트 추가
	    closeBtn.onclick = function() {
	        overlay.setMap(null);
	    };
	    contentName.appendChild(closeBtn);

	    var contentRoad = document.createElement("div");
	    contentRoad.className = "road";
	    contentRoad.appendChild(document.createTextNode("도로명주소: " + pos.road));
	    info.appendChild(contentRoad);
	    
	    var contentAddr = document.createElement("div");
	    contentAddr.className = "h_address";
	    contentAddr.appendChild(document.createTextNode("지번주소: " + pos.h_address));
	    info.appendChild(contentAddr);
	    
	    var contentPhone = document.createElement("div");
	    contentPhone.className = "h_phone";
	    contentPhone.appendChild(document.createTextNode("전화번호: " + pos.h_phone));
	    info.appendChild(contentPhone);
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
