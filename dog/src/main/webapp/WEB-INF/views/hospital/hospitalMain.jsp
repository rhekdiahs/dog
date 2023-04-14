<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab928e5929563772b2932e6182f6b7d9&libraries=services"></script>
<div id = "map"style="width:980px; height:400px;"></div>
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
	 <table >
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
	<div>
		${page }
		<br>
		${ip}
	</div>
<script>
	const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	
	var link = document.location.href.split('keyfield=')[1];
	var curCity = sessionStorage.getItem('curCity');

	console.log(decodeURI(link))
	console.log(curCity);
	/* 시도별 중심좌표 시작 */
	var coordX = 128;
	var coordY = 36.6;
	var zoomLevel = 13;
	if(decodeURI(link) == '서울특별시'){
		coordX = 126.9783882;
		coordY = 37.5666103;
		zoomLevel = 10;
	}
	if(decodeURI(link) == '부산광역시'){
		coordX = 129.0750223;
		coordY = 35.179816;
		zoomLevel = 8;
	}
	if(decodeURI(link) == '대구광역시'){
		coordX = 128.601763;
		coordY = 35.87139;
		zoomLevel = 8;
	}
	if(decodeURI(link) == '인천광역시'){
		coordX = 126.7051505;
		coordY = 37.4559418;
		zoomLevel = 9;
	}
	if(decodeURI(link) == '광주광역시'){
		coordX = 126.851338;
		coordY = 35.160032;
		zoomLevel = 8;
	}
	if(decodeURI(link) == '대전광역시'){
		coordX = 127.3849508;
		coordY = 36.3504396;
		zoomLevel = 8;
	}
	if(decodeURI(link) == '울산광역시'){
		coordX = 129.3112994;
		coordY = 35.5394773;
		zoomLevel = 8;
	}
	if(decodeURI(link) == '세종특별자치시'){
		coordX = 127.2894325;
		coordY = 36.4803512;
		zoomLevel = 8;
	}
	if(decodeURI(link) == '경기도'){
		coordX = 127.550802;
		coordY = 37.4363177;
		zoomLevel = 11;
	}
	if(decodeURI(link) == '강원도'){
		coordX = 128.3115261;
		coordY = 37.8603672;
		zoomLevel = 12;
	}
	if(decodeURI(link) == '충청북도'){
		coordX = 127.6551404;
		coordY = 36.7853718;
		zoomLevel = 10;
	}
	if(decodeURI(link) == '충청남도'){
		coordX = 126.8453965;
		coordY = 36.6173379;
		zoomLevel = 11;
	}
	if(decodeURI(link) == '전라북도'){
		coordX = 127.2368291;
		coordY = 35.6910153;
		zoomLevel = 11;
	}
	if(decodeURI(link) == '전라남도'){
		coordX = 126.9571667;
		coordY = 34.9007274;
		zoomLevel = 11;
	}
	if(decodeURI(link) == '경상북도'){
		coordX = 128.962578;
		coordY = 36.6308397;
		zoomLevel = 12;
	}
	if(decodeURI(link) == '경상남도'){
		coordX = 128.2417453;
		coordY = 35.4414209;
		zoomLevel = 11;
	}
	if(decodeURI(link) == '제주특별자치도'){
		coordX = 126.5758344;
		coordY = 33.4273366;
		zoomLevel = 10;
	}
	if(decodeURI(link) == '--선택' || curCity == ''){
		coordX = 128;
		coordY = 36.6;
		zoomLevel = 13;
	}
	
	/* 시도별 중심좌표 끝 */
	
	let options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(coordY, coordX), //지도의 중심좌표.
		level: zoomLevel //지도의 레벨(확대, 축소 정도)
	};
	
	let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var geocoder = new kakao.maps.services.Geocoder();
	
    var test_dicts = {};

    var test_arrays = [];
	
    <c:forEach var="list" items="${list}">
    	/* db에서 주소 불러와서 geocoder로 검색, 나온 좌표 ajax로 hospital_num이랑 컨트롤러에 넘겨줌, 해당 num 좌표 업데이트
    	
    	var geocoder = new kakao.maps.services.Geocoder();
    	
    	geocoder.addressSearch('${list.road}', function(result, status){
    		if(status === kakao.maps.services.Status.OK){
    			result_x = result[0].x;
    			result_y = result[0].y;
    			h_num = '${list.hospital_num}';
    			console.log('${list.hospital_num}');
    			$.ajax({
    				url : 'insertCoords.do',
    				data : {coord_x : result_x,
    					    coord_y : result_y,
    					    h_num : h_num
    					    },
    				type : 'post',
    				dataType : 'json',
    				success : function(result){
    					if(result.result == 'success'){
    					}
    				},
    				error : function(){
    					alert('에러');
    				}
    			});
    		}
    	});
    	*/
    
    	test_dicts['title'] = '${list.road}';

    	test_dicts['latlng'] = new kakao.maps.LatLng("${list.coord_y}", "${list.coord_x}");

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
