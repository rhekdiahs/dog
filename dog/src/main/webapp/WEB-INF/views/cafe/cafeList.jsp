<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f51f9d8c2a383e5820415bbc36c1551a&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<!-- 중앙컨텐츠 시작 -->
<div id="main_body">
	<div id="map" style="width:500px;height:400px;"></div>
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
	       <td>${cafe.cafe_addr}</td>
	     </tr>
	     </c:forEach>
	</table>
	</div>
	<div class="align-center">${page}</div>
	</c:if>
	<script>
	var test_dicts = {};

    var test_arrays = [];
	
    <c:forEach var="cafe" items="${cafe}">
    
    	test_dicts['title'] = '${cafe.cafe_addr}';

    	test_dicts['latlng'] = new kakao.maps.LatLng("${cafe.cafe_y}", "${cafe.cafe_x}");

    	test_arrays.push(test_dicts);

    	var test_dicts = {};    
    </c:forEach>

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < test_arrays.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: test_arrays[i].latlng, // 마커를 표시할 위치
	        title : test_arrays[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	    
	}
	</script>
</div>
<!-- 중앙컨텐츠 끝 -->