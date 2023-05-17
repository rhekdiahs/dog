$(function(){
	//좋아요 읽기
	//좋아요 선택 여부와 선택한 총개수 표시
	function selectFav(lf_num){
		$.ajax({
			url:'getFav.do',
			type:'post',
			data:{lf_num:lf_num},//:board_num은 위에 board_num을 의미
			dataType:'json',
			success:function(param){
				displayFav(param);
			},
			error:function(){
				alert('네트워크 오류1');
			}
		});
	}
	//좋아요 등록
	$('#output_fav').click(function(){
		
		$.ajax({
			url:'writeFav.do',
			type:'post',
			data:{lf_num:$('#output_fav').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌러주세요!');
				}else if(param.result == 'success'){
					message_socket2.send("qwe:");
					syncDelay(1000);
					displayFav(param);
					message_socket.send("msg:");
					
				}else{
					alert('등록시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생2');
			}
		});
	});
	
	//소켓 충돌을 막기 의해 사용
	function syncDelay(milliseconds){
		var start = new Date().getTime();
		var end=0;
		while( (end-start) < milliseconds){
	       end = new Date().getTime();
		 }
	}
	
	//좋아요 표시, 좋아요 개수 표시 공통 함수
	function displayFav(param){
		let output;
		if(param.status == 'yesFav'){
			output = '../images/fav02.gif';
		}else{
			output = '../images/fav01.gif';
		}
		
		//문서 객체에 추가
		$('#output_fav').attr('src',output);
		$('#output_fcount').text(param.count);
	}
	
	//초기 데이터 표시
	selectFav($('#output_fav').attr('data-num'));
});