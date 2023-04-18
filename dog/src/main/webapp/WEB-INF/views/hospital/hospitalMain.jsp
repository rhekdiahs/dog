<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab928e5929563772b2932e6182f6b7d9&libraries=services"></script>
<script src="${pageContext.request.contextPath}/js/main_coord.js"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/marker.css">

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
			    <c:forEach var="list" items="${list}" varStatus="status">
		     	<tr>
		     		<td>${status.count}</td>
		     		<td>${list.h_name}</td>
			        <td>
		         	<c:if test = "${list.hospital_type == 0}">일반병원</c:if>
		         	<c:if test = "${list.hospital_type == 1}">24시병원</c:if>
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
	/*========================= 
			지도 옵션 세팅
	===========================*/
	const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	
	let options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(coordY, coordX), //지도의 중심좌표.
		level: zoomLevel //지도의 레벨(확대, 축소 정도)
	};

	let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

	/*========================= 
		   병원 리스트 가져오기
	===========================*/
    var test_dicts = {};

    var hospital_arrays = [];
	
    <c:forEach var="list" items="${list}">
    	test_dicts['type'] = '${list.hospital_type}'; //타입
    	test_dicts['h_info_image_name'] = '${list.h_info_image_name}'; //이미지이름
    	test_dicts['hospital_num'] = '${list.hospital_num}'; // 번호
    	test_dicts['road'] = '${list.road}';	//도로명주소
    	test_dicts['h_name'] = '${list.h_name}';	//상호명
    	test_dicts['h_address'] = '${list.h_address}';	//지번주소
    	test_dicts['h_phone'] = '${list.h_phone}';	//지번주소
    	test_dicts['latlng'] = new kakao.maps.LatLng("${list.coord_y}", "${list.coord_x}"); //좌표

    	hospital_arrays.push(test_dicts);
    	var test_dicts = {};    
    </c:forEach>
	/*========================= 
		   마커, 오버레이 그리기
	===========================*/
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
	    contentName.className = "title";
	    contentName.appendChild(document.createTextNode(pos.h_name));
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
	    if(pos.h_info_image_name == ''){
	    	contentImg.setAttribute("src", "${pageContext.request.contextPath}/image_bundle/defaltHospitalImg.png");
	    }else{
	    	contentImg.setAttribute("src", "${pageContext.request.contextPath}/hospital/photoView.do?" + pos.hospital_num)
	    }
	    contentImg.setAttribute("width", "55");
	    contentImg.setAttribute("height", "55");
	    contentImg.setAttribute("style", "margin-left : 5px; margin-top : 7px;");
		info.appendChild(contentImg);
		
	    var contentRoad = document.createElement("div");
	    contentRoad.className = "addr1";
	    contentRoad.appendChild(document.createTextNode(pos.road));
	    info.appendChild(contentRoad);
	    
	    var contentAddr = document.createElement("div");
	    contentAddr.className = "addr2";
	    contentAddr.appendChild(document.createTextNode("(지번) " + pos.h_address));
	    info.appendChild(contentAddr);
	    
	    var contentPhone = document.createElement("div");
	    contentPhone.className = "phone";
	    var contentPhoneImg = document.createElement('img');
	    contentPhoneImg.className = "phoneImg";
	    contentPhoneImg.src = "${pageContext.request.contextPath}/image_bundle/defaltHospitalImg.png";
	    contentPhoneImg.setAttribute("width", "13");
	    contentPhoneImg.setAttribute("height", "13");
	    contentPhoneImg.setAttribute("style", "position : relative; top : 2px;");
	    contentPhone.appendChild(contentPhoneImg)
	    contentPhone.appendChild(document.createTextNode(" " + pos.h_phone));
	    info.appendChild(contentPhone);
	    var contentAddr = document.createElement("div");
	    contentAddr.className = "h_address";
	    //contentAddr.appendChild(document.createTextNode("화면크기: " + window.innerWidth));
	    info.appendChild(contentAddr);
	    // customoverlay 생성, 이때 map을 선언하지 않으면 지도위에 올라가지 않습니다.
	    var overlay = new daum.maps.CustomOverlay({
	        position: pos.latlng,
	        content: content
	    });
	    kakao.maps.event.addListener(marker, 'click', function() {
	        if (clickedOverlay) {
	        	clickedOverlay.setMap(null);
	        }
	        overlay.setMap(map);
	        clickedOverlay = overlay;
	      });
	});
	

</script>
