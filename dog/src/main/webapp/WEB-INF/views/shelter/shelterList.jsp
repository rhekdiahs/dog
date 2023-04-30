<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=970af4bda553ab08ae535abf4de88a1f&libraries=services"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/shelter.css">
<c:if test="${empty shelterVO}">
	<script type="text/javascript">
		location.reload();
	</script>
</c:if>
<div class="location_con01">
	<div class="inner">
		<div class="sub_tit">
			<h3>임시보호소</h3>
		</div><br>
		
		<div class="loading"></div>
		
		<div class="footer-map" id="map"></div>
		<br><br>
		<div>
			<div class="ex"></div>
			<br><br>
			
			<div>
			<ul id = "place-list" class = "place-list" >
				<c:forEach var="alist" items="${shelterVO}" varStatus="status">
					<li class = "shel" data-id="${alist.url}">
						<div class = "list-title">
							<strong><span class="index">${status.count}</span> ${alist.subject}</strong>
						</div>
						<div class = "list-content">
							<p>${alist.address}</p>
							<p><small>${alist.location}</small></p>
						</div>
					</li>
				</c:forEach>
			</ul>
		   </div>
		</div>
	</div>
</div>

<script type="text/javascript">
 $(window).on('load', function(){
	// 3초 후에 로딩 화면 숨김
    setTimeout(function() {
        $(".loading").fadeOut();
    }, 4300);
});   
</script>

<script type="text/javascript">
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
		      //var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		      var imageSrc = "${pageContext.request.contextPath}/image_bundle/shelter_marker.png";
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
			    						output += '<ul id="place-list" class="place-list2">';
			    						output += '<li><p><strong>';
			    						output += item.subject + '</strong></p><br>';
			    						output += '<p>' + "주소 : ";
			    						output += item.address + '</p><br>';
			    						output += '<p>' + "전화번호 : ";
			    						output += item.phone + '</p><br>';
			    						output += '<p>' + "영업시간 : ";
			    						output += item.time + '</p><br>';
			    						output += '<p>' + "설명 : ";
			    						output += item.explanation + '</p><br>';
			    						output += '<p>' + "홈페이지 : ";
			    						if(item.blog == "홈페이지가 없습니다."){
			    						output += item.blog + '</p><br>';
			    						}else{
			    							output += '<a href="'+item.blog+'">' + item.blog +'</a></p>';
			    						}
			    						output += '</li></ul>';
			    						
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
	      }, 500);
		}, 4600);	
</script>

<script type="text/javascript">
//상세페이지 보여지기 부분
$(document).on('click','.shel',function(event){
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
					output += '<ul id="place-list" class="place-list2">';
					output += '<li><p><strong>';
					output += item.subject + '</strong></p><br>';
					output += '<p>' + "주소 : ";
					output += item.address + '</p><br>';
					output += '<p>' + "전화번호 : ";
					output += item.phone + '</p><br>';
					output += '<p>' + "영업시간 : ";
					output += item.time + '</p><br>';
					output += '<p>' + "설명 : ";
					output += item.explanation + '</p><br>';
					output += '<p>' + "홈페이지 : ";
					if(item.blog == "홈페이지가 없습니다."){
					output += item.blog + '</p><br>';
					}else{
						output += '<a href="'+item.blog+'">' + item.blog +'</a></p>';
					}
					output += '</li></ul>';
				
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