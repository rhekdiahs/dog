
	
	var link = document.location.href.split('keyfield=')[1];
	if(link.length > 7) {
		link = link.split('&')[0];
	}
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
	
