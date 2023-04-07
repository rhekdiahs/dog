<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=970af4bda553ab08ae535abf4de88a1f"></script>
<div class="footer-map" id="map" style="width:600px;height:300px;"></div>
<script>
      var container = document.getElementById('map');
      var options = {
         center: new kakao.maps.LatLng(37.499340971211275 , 127.03327632815363 ),
         level: 13
      };

      var map = new kakao.maps.Map(container, options);
      // 마커가 표시될 위치입니다 
      var markerPosition  = new kakao.maps.LatLng(37.499340971211275 , 127.03327632815363 ); 

      // 마커를 생성합니다
      var marker = new kakao.maps.Marker({
          position: markerPosition
      });

      // 마커가 지도 위에 표시되도록 설정합니다
   marker.setMap(map);
</script>
<div>
    <table class= "table">
        <tr>
            <th>이미지</th>
            <th>제목</th>
        </tr>
        <c:forEach var="alist" items="${shelterVO}">
         <tr>
             <td><a href="${alist.url}"><span>"${alist.subject}" </span></a></td>
             <td><span>"${alist.location}" </span></td>
             <td><span>"${alist.address}"</span></td>
         </tr>
        </c:forEach>
    </table>
</div>