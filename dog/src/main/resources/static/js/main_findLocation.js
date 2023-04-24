$(function(){
	if(sessionStorage.getItem('curCity') == '' || sessionStorage.getItem('curCity') == null){
		$.ajax({
			url: "https://geolocation-db.com/jsonp/",
			jsonpCallback: "callback",
			dataType: "jsonp",
			success: function( location ) {
				sessionStorage.setItem('curCity', location.state);
			}
		});
	}
});
console.log(sessionStorage.getItem('curCity'));

function withCurCity(){
	$.ajax({
		url : "/hospital/curCityAjax.do",
		data : {curCity : sessionStorage.getItem('curCity')},
		type : 'post',
		dataType : 'json',
		success : function(param){
			location.href = '/hospital/main.do?keyfield=' + param.result;
		},
		error : function(){
			
		}
	});
}

function withCafeCity(){
	$.ajax({
		url : "/hospital/curCityAjax.do",
		data : {curCity : sessionStorage.getItem('curCity')},
		type : 'post',
		dataType : 'json',
		success : function(param){
			location.href = '/cafe/cafeList.do?keyfield=' + param.result;
		},
		error : function(){
			
		}
	});
	
}
function withWalkCityList(){
	$.ajax({
		url : "/walk/curCityAjax.do",
		data : {curCity : sessionStorage.getItem('curCity')},
		type : 'post',
		dataType : 'json',
		success : function(param){
			location.href = '/walk/list.do?keyfield=' + param.result;
		},
		error : function(){
			alert('ERROR');
		}
	});
}

function withWalkCityRegister(){
	$.ajax({
		url : "/walk/curCityAjax.do",
		data : {curCity : sessionStorage.getItem('curCity')},
		type : 'post',
		dataType : 'json',
		success : function(param){
			location.href = '/walk/register.do?keyfield=' + param.result;
		},
		error : function(){
			alert('ERROR');
		}
	});
}