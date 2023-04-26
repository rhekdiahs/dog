function bookmark(e){
	

	var pk_num = e.getAttribute('data-num');
	var e_child = $(e).find('img');
	
	console.log(e_child);
	
	$.ajax({
		url : '/bookmark/insertBookmark.do',
		data : {pk_num : pk_num},
		type : 'post',
		dataType : 'json',
		success : function(result){
			if(result.status == 'insertOK'){
				e_child.attr('src','../image_bundle/bookmark1.png');
			}else if(result.status == 'null'){
				alert('로그인 후 이용하세요');
			}else if(result.status == 'deleteOK'){
				e_child.attr('src','../image_bundle/bookmark0.png');
			}else{
				alert('NETWORK ERROR');
			}
		},
		error : function(){
			alert('에러');
		}
	});
}
function getBookmark(pk_num){
	$.ajax({
		url : '/bookmark/getBookmark.do',
		data : {pk_num : pk_num},
		type : 'post',
		dataType : 'json',
		success : function(result){
			if(result.status == 'full'){
				setBookmarkImg(result.pk_num);
			}else{

			}
		},
		error : function(){
			alert('에러');
		}
	});
}

function setBookmarkImg(pk_num){
	var bookmarkImg = $('#'+pk_num).find('img');
	bookmarkImg.attr('src','/image_bundle/bookmark1.png');
}