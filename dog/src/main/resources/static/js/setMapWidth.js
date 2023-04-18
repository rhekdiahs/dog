	/*========================= 
	 지도 화면 크기에 맞춰서 사이즈 설정
	===========================*/
	function resizeMap() {
	    var container = document.getElementById('map');
	    container.style.width = visualViewport.width + 'px';
	    container.style.height = visualViewport.width + 'px';
	}
	function relayout() {
	    map.relayout();
	}
	
	let resizeTimer = null;
	function resizeComplete() {
		var origin = new kakao.maps.LatLng(coordY, coordX)
	  	map.setCenter(origin);
	}
	
	window.addEventListener('resize', function() {
		resizeMap();
	  	clearTimeout(resizeTimer);
	  	resizeTimer = setTimeout(resizeComplete, 400);
	}, false);
