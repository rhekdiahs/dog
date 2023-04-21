<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=970af4bda553ab08ae535abf4de88a1f&libraries=services"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/shelter.css">
<div class="location_con01">
	<div class="inner">
		<div class="sub_tit">
			<h3>임시보호소</h3>
		</div><br>
		<div class="footer-map" id="map" style="width:70%;height:400px;"></div>
		<div>
			<table class="ex" style="margin-left:auto;margin-right:auto;"></table>
			<br><br>
		    <table class= "table" style="margin-left:auto;margin-right:auto;">
		        <tr>
		            <th>이름</th>
		            <th>위치</th>
		            <th>도로명</th>
		        </tr>
		        <c:forEach var="alist" items="${shelterVO}">
		         <tr>
		             <td class="shelter_url" data-id="${alist.url}"><span>"${alist.subject}" </span></td>
		             <td><span>"${alist.location}" </span></td>
		             <td><span>"${alist.address}"</span></td>
		         </tr>
		        </c:forEach>
		    </table>
		</div>
	</div>
</div>


<script>
	//도로명주소
	var add = [];
	//이름
	var ntitle = [];
	//url
	var surl = [];

	//주소값 가지고 오기
	$.ajax({
		url:'../shelter/shelterAddress.do',
		type:'post',
		dataType:'json',
		success:function(param){
			 if(param.result == 'success'){
				 $(param.list).each(function(index,item){
					 ntitle[index] = item.subject;
					 add[index] = "'"+item.address+"'";
					 surl[index] = item.url;
					//console.log('1' + add[index]);	
					//console.log('2' + ntitle[index]);
				 })
			}else{
				alert('주소 찾기 오류');
			}
		},
		error:function(){
			alert('네트워크 오류');
		}
	});
	//크롤링 시간이 걸려서 시간을 맞추기 위해 사ㅇ용
	setTimeout(function() {
	      var container = document.getElementById('map');
	      var options = {
	         center: new kakao.maps.LatLng(36.6255 , 127.6995 ),
	         level: 14
	      };

	      var map = new kakao.maps.Map(container, options);
	      
	      var positions = [];//좌표 및 이름이 들어가는 배열
	      
	      //주소로 좌표 변환
	      var geocoder = new kakao.maps.services.Geocoder();
	      for(let i=0; i<add.length; i++){
		      geocoder.addressSearch(add[i], function(result, status) {
		    	    // 정상적으로 검색이 완료됐으면	
		    	     if (status === kakao.maps.services.Status.OK) {
		    	    	//좌표 
		    	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		    	    	
		    	        //배열에 객체 넣기
		    	        var position = {};
		    	        position.title = ntitle[i];
		    	        position.latlng = coords;
		    	        
		    	        positions.push(position);		
		    	    }  
	         })
	      }
	      setTimeout(function() {//일정 시간이 지나야 길이가 나온다
		      //console.log(positions);
		      //console.log(positions.length);
		      //마커이미지 주소
		      var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		      for(var j=0; j<positions.length; j++){
		    	  // 마커 이미지의 이미지 크기 입니다
		    	  var imageSize = new kakao.maps.Size(24, 35); 
		    	    
		    	  // 마커 이미지를 생성합니다    
		    	  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		    	  
			      var marker = new kakao.maps.Marker({
			          map: map, // 마커를 표시할 지도
			          position: positions[j].latlng, // 마커를 표시할 위치
			          title : positions[j].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			          image : markerImage // 마커 이미지 
			      });
			      //마커 이벤트 클릭하면 페이지 열기 1. hef 가지고 오기 
			      kakao.maps.event.addListener(marker, 'click', function(){
			    	  
			    	  var markerTitle = this.getTitle();//클릭한 마커에 title을 가지고 온다
			    	  var num = ntitle.indexOf(markerTitle);//title에 몇번 인덱스에 들어가는지 알아낸다
			    	  var url = surl[num];//클릭한 마커의 url 구하기
			    	  
			    	  //클릭한 마커의 주소를 찾기위해 num 사용
			    	  $.ajax({
			    			url:'../shelter/shelterDetail.do',
			    			type:'post',
			    			data:{url:url},
			    			dataType:'json',
			    			success:function(param){
			    				if(param.result == 'success'){
			    					$('.ex').empty();
			    					$(param.list).each(function(index,item){
			    						let output = '';
			    						output += '<tr>';
			    						output += '<td class="extd">' + "이름 " + '</td>';
			    						output += '<td>' + item.subject + '</td>';
			    						output += '</tr>';
			    						output += '<tr>';
			    						output += '<td class="extd">' + "주소 " + '</td>';
			    						output += '<td>' + item.address + '</td>';
			    						output += '</tr>';
			    						output += '<tr>';
			    						output += '<td class="extd">' + "전화번호 " + '</td>';
			    						output += '<td>' + item.phone + '</td>';
			    						output += '</tr>';
			    						output += '<tr>';
			    						output += '<td class="extd">' + "영업시간 " + '</td>';
			    						output += '<td>' + item.time + '</td>';
			    						output += '</tr>';
			    						output += '<tr>';
			    						output += '<td class="extd">' + "설명 " + '</td>';
			    						output += '<td>' + item.explanation + '</td>';
			    						output += '</tr>';
			    						
			    						$('.ex').append(output);
			    					});
			    				}else{
			    					alert('상세 페이지 읽기 오류 발생');
			    				}
			    			},
			    			error:function(){
			    				alert('상세 페이지 네트워크 오류 발생');
			    				
			    			}
			    		});
			      });
			      
		      }
	      }, 2000);
		}, 5000);
</script>

<script>
//상세페이지 보여지기 부분
$(document).on('click','.shelter_url',function(event){
	var url = $(this).data('id');
	//alert(url); // url 값 확인
	
	$.ajax({
		url:'../shelter/shelterDetail.do',
		type:'post',
		data:{url:url},
		dataType:'json',
		success:function(param){
			if(param.result == 'success'){
				$('.ex').empty();
				$(param.list).each(function(index,item){
					let output = '';
					output += '<tr>';
					output += '<td style="width:50px;">' + "이름 :" + '</td>';
					output += '<td>' + item.subject + '</td>';
					output += '</tr>';
					output += '<tr>';
					output += '<td>' + "주소 :" + '</td>';
					output += '<td>' + item.address + '</td>';
					output += '</tr>';
					output += '<tr>';
					output += '<td>' + "전화번호 :" + '</td>';
					output += '<td>' + item.phone + '</td>';
					output += '</tr>';
					output += '<tr>';
					output += '<td>' + "영업시간 :" + '</td>';
					output += '<td>' + item.time + '</td>';
					output += '</tr>';
					output += '<tr>';
					output += '<td>' + "설명 :" + '</td>';
					output += '<td>' + item.explanation + '</td>';
					output += '</tr>';
					
					$('.ex').append(output);
				});
			}else{
				alert('상세 페이지 읽기 오류 발생');
			}
		},
		error:function(){
			alert('상세 페이지 네트워크 오류 발생');
			
		}
	});
	
});
</script>