<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab928e5929563772b2932e6182f6b7d9"></script>
<div id = "map"style="width:980px; height:400px;"></div>
<script>
	const container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	let options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		level: 10 //지도의 레벨(확대, 축소 정도)
	};
	let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	var positions = [
	    {
	        title: '카카오', 
	        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
	    },
	    {
	        title: '생태연못', 
	        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
	    },
	    {
	        title: '텃밭', 
	        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
	    },
	    {
	        title: '근린공원',
	        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
	    }
	];
	
	var positions = [
	    {
	        title: '카카오', 
	        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
	    },
	    {
	        title: '생태연못', 
	        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
	    },
	    {
	        title: '텃밭', 
	        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
	    },
	    {
	        title: '근린공원',
	        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
	    }
	];

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

	var positions = [
	    {
	        title: '카카오', 
	        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
	    },
	    {
	        title: '생태연못', 
	        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
	    },
	    {
	        title: '텃밭', 
	        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
	    },
	    {
	        title: '근린공원',
	        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
	    }
	];
    var test_dicts = {};

    var test_arrays = [];
	
    <c:forEach var="list" items="${list}">
   		test_dicts['title'] = '테스트';

    	test_dicts['latlng'] = new kakao.maps.LatLng("${list.coord_y}", "${list.coord_x}");

    	test_arrays.push(test_dicts);

    	var test_dicts = {};   
    </c:forEach>
/*      for (let index = 0; index < ${list.size()}; index++) {

       //var one_key = list[index];

       //var one_value = list[index];
       
       var coord_y = ${list[index].coord_y};
       var coord_x = ${list[index].coord_x};



     }
	 */
	

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
	console.log(${list[0].coord_y})
</script>
	 <table >
	     <tr>
	         <th>지역</th>
	         <th>x좌표</th>
	         <th>y좌표</th>
	         <th>24시</th>
	     </tr>
	     <c:forEach var="list" items="${list}">
	     <tr>
	         <td>${list.hospital_region}</td>
	         <td>${list.coord_x}</td>
	         <td>${list.coord_y}</td>
	         <td>
	         	<c:if test = "${list.hospital_type == 0}">일반</c:if>
	         	<c:if test = "${list.hospital_type == 1}">24시</c:if>
	         </td>
	     </tr>
	     </c:forEach>
	</table>
