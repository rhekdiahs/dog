$(function(){
	var link = document.location.href.split('/')[3];
	var link2 = document.location.href.split('/')[4];
	var link3 = link2.split('?')[0];
	var notiBtn = $('#menu_notiBtn');
	var aTag = $('#menu-iconA')
	console.log(link);
	console.log(link3);
	
	if(link3 == 'walkList.do'){
		notiBtn.attr('src', '../image_bundle/regiBtn.png');
		//aTag.attr('href', '/cafe/cafeSelect.do');
	}else if(link3 == 'hospitalList.do'){
		notiBtn.attr('src', '../image_bundle/regiBtn.png');
		aTag.attr('href', '/hospital/hospitalSelect.do');
	}else if(link3 == 'cafeList.do'){
		notiBtn.attr('src', '../image_bundle/regiBtn.png');
		aTag.attr('href', '/cafe/cafeSelect.do');
	}else if(link == 'mypage'){
		notiBtn.attr('src', '../image_bundle/noti_btn.png');
	}
});