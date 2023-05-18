$(function(){
	var link = document.location.href.split('/')[3];
	var link2 = document.location.href.split('/')[4];
	var link3 = link2.split('?')[0];
	var notiBtn = $('#menu_notiBtn');
	var aTag = $('#menu-iconA');
	var acount = $('.count');
	console.log(link);
	console.log(link3);
	
	if(link3 == 'walkList.do' || link3 == 'selectOption.do'){
		notiBtn.attr('src', '../image_bundle/regiBtn.png');
		aTag.attr('href', '/walk/registerMap.do?keyfield=서울특별시');
		acount.text("");
		acount.attr('style', "");
	}else if(link3 == 'hospitalList.do' || link3 =='h_selectOption.do'){
		notiBtn.attr('src', '../image_bundle/regiBtn.png');
		aTag.attr('href', '/hospital/hospitalSelect.do');
		acount.text("");
		acount.attr('style', "");
	}else if(link3 == 'cafeList.do'){
		notiBtn.attr('src', '../image_bundle/regiBtn.png');
		aTag.attr('href', '/cafe/cafeSelect.do');
		acount.text("");
		acount.attr('style', "");
	}else if(link == 'mypage'){
		notiBtn.attr('src', '../image_bundle/noti_btn.png');
	}
});