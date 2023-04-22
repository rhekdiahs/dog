var container = document.getElementById('map'), // 지도를 표시할 div 
    option = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    }; 
    
container.style.width = visualViewport.width + 'px';
container.style.height = visualViewport.width + 'px';

// 지도를 생성합니다    
var map = new kakao.maps.Map(container, option); 

/****** 클릭 시 마커 찍는 코드 *******/
//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//지도를 클릭한 위치에 표출할 마커입니다
var mPick = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
});

var content = null;

//마커 위에 커스텀오버레이를 표시합니다
//마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
var mOverlay = new kakao.maps.CustomOverlay({
 content: content,
 map: map,
 position: mPick.getPosition({zindex:1})       
});

//var isSelfCheck = false;
function check(){
   // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
   kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var detailAddr1 = !!result[0].road_address ?  result[0].road_address.address_name : '';
            var detailAddr2 = '(지번) ' + result[0].address.address_name ;
           
            var mContent = document.createElement('div');
            mContent.className = 'over-wrap';
            
            var over_info = document.createElement('div');
            over_info.className = 'over-info';
            mContent.appendChild(over_info);
            
            var over_title = document.createElement('div');
            over_title.className = 'over-title';
            over_title.innerHTML = '선택한 곳의 주소';
            over_info.appendChild(over_title);
            
            var over_close = document.createElement('div');
            over_close.className = 'over-close';
            over_close.onclick = function(){
               mOverlay.setMap(null);
            }
            over_title.appendChild(over_close);
            
            var over_addr1 = document.createElement('div');
            over_addr1.className = 'over-addr1';
            over_addr1.appendChild(document.createTextNode(detailAddr1));
            over_info.appendChild(over_addr1);
            
            var over_addr2 = document.createElement('div');
            over_addr2.className = 'over-addr2';
            over_addr2.appendChild(document.createTextNode(detailAddr2));
            over_info.appendChild(over_addr2);
            
            // 마커를 클릭한 위치에 표시합니다 
            mPick.setPosition(mouseEvent.latLng);
            mPick.setMap(map);
            mOverlay.setContent(mContent);
              mOverlay.setMap(map);
              mOverlay.setPosition(mPick.getPosition());
            
            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            //infowindow.setContent(content);
            //infowindow.open(map, mPick);
        }   
    }); 
});

   function searchDetailAddrFromCoords(coords, callback) {
       // 좌표로 법정동 상세 주소 정보를 요청합니다
       geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
   }

}
//검색해서 찾기
   
function active(){
   document.getElementById("searchBox").style.display="block";
}

//마커를 담을 배열입니다
var markers = [];

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
//var infowindow = new kakao.maps.InfoWindow({zindex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '') && submit.click()) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);
        //console.log(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}


// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    var newLength = 0;
    
    if(places.length < 5){
       newLength = places.length;
    }else{
       newLength = 5;
    }
    for ( var i=0; i<newLength; i++ ) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
      var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(24, 35),  // 마커 이미지의 크기
           markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
            marker = new kakao.maps.Marker({
               position: new kakao.maps.LatLng(places[i].y, places[i].x), // 마커의 위치
               image: markerImage 
           });
      
          marker.setMap(map); // 지도 위에 마커를 표출합니다
          markers.push(marker);  // 배열에 생성된 마커를 추가합니다
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
        
      var oContent = document.createElement('div');
            oContent.className = 'o-wrap';
            
            var o_info = document.createElement('div');
            o_info.className = 'o-info';
            oContent.appendChild(o_info);

            var o_title = document.createElement('div');
            o_title.className = 'o-title';
            o_title.appendChild(document.createTextNode(places[i].place_name));
            o_info.appendChild(o_title);
            
            var o_close = document.createElement('div');
            o_close.className = 'o-close';
         
            /*over_close.mouseover = function(){
               oOverlay.setMap(map);
            }
         over_close.mouseout = function(){
               oOverlay.setMap(null);
            }*/
            o_title.appendChild(o_close);
            
            var o_addr1 = document.createElement('div');
            o_addr1.className = 'o-addr1';
            o_addr1.appendChild(document.createTextNode(places[i].road_address_name));
            o_info.appendChild(o_addr1);
      
	        var oOverlay = new daum.maps.CustomOverlay({
	            content: oContent,
	            //map: map,
	            position: markers[i].getPosition()
          	}); 
         console.log('for문돌때' + marker.getPosition());
         
      /*kakao.maps.event.addListener(marker, 'click', function() {
         oOverlay.setMap(map);
       }(oOverlay));*/   
      fragment.appendChild(itemEl);
            
      
        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        /*(function(marker) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                 oOverlay.setMap(map);
            });

          kakao.maps.event.addListener(marker, 'mouseout', function() {
                oOverlay.setMap(null);
            });

            itemEl.onmouseover =  function () {
               oOverlay.setMap(map);
            };

            itemEl.onmouseout =  function () {
               oOverlay.setMap(null);
            };
        })(marker, places[i].place_name);*/
        kakao.maps.event.addListener(marker, 'mouseover', function() {
         console.log(marker.getPosition());
         console.log("over" + marker.getPosition());
             oOverlay.setMap(map);
            });
      kakao.maps.event.addListener(marker, 'mouseout', function() {
         console.log(marker.getPosition());
         console.log("out"+marker.getPosition());
             oOverlay.setMap(null);
        });
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);

}




// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.id = 'addr';
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
/*function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
        spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}*/

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

/*// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title, places) {
    var content = '<div style="padding:5px;z-index:1;">' + title +
                '<Button>' + '버튼' + '</Button>' + 
               '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}*/

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
