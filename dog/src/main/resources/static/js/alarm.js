
let message_socket;//웹소켓 식별자
let message_socket2;//웹소켓 식별자

function alarm_connect(){
	
	message_socket = new WebSocket("ws://localhost:8080/message-ws.do");
	message_socket.onopen = function(evt){//연결
		
		message_socket.send("msg:");
		console.log("채팅페이지 접속");
	};
	//서버로부터 메시지를 받으면 호출되는 함수 지정 
	message_socket.onmessage=function(evt){
		let data = evt.data;
		if(data.substring(0,4) == 'msg:'){
			selectalarm();
		}
	};
	message_socket.onclose=function(evt){
		//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
		console.log('채팅 종료');
	}
};

function alarm_connect2(){
	
	message_socket2 = new WebSocket("ws://localhost:8080/message-ws.do");
	message_socket2.onopen = function(evt){//연결
		if($('#alarmlist').length == 1){
				message_socket.send("qwe:");
			}
		console.log("채팅페이지2 접속");
	};
	//서버로부터 메시지를 받으면 호출되는 함수 지정 
	message_socket2.onmessage=function(evt){
		let data = evt.data;
		
		if(data.substring(0,4) == 'qwe:' && $('#alarmlist').length == 1){
			console.log('alarm_connect2 접속');
			selectalarmList();
		}
	};
	message_socket2.onclose=function(evt){
		//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
		console.log('채팅 종료');
	}
};

function selectalarm(){
	
	$.ajax({
		url:'../community/alarmCountAjax.do',
		type:'post',
		dataType:'json',
		success:function(param){
			if(param.result == 'success'){
				if(param.acount > 0){
					$('.count').text(param.acount);
					$('.count').css({"height":"20px", "width":"20px", "color":"white", 
					"text-align":"center", "background-color":"red", 
					"border-radius":"15px", "display":"inline-block" });
				}
				
			}else{
				alert('알림 카운트 오류');
				message_socket.close();
			}
		},
		error:function(){
			alert('알림 카운트 네트워크 오류');
			message_socket.close();
		}
	});
}

function selectalarmList(){//알림 리스트 불러오기
		
		$.ajax({
			url:'../community/alarmListAjax.do',
			type:'post',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){	
					alert('로그인 후 사용하세요!');
					message_socket2.close();
				}else if(param.result == 'success'){
					$('.striped-table2').empty();
					let chat_date = '';
					$(param.list).each(function(index,item){
						console.log(index);
						var size = $(param.list).length;
						size -= index;
						let output = '';
						if(chat_date != item.al_date.split(' ')[0]){//저장된 날짜가 없으면
							chat_date = item.al_date.split(' ')[0];//날짜 저장
							output += '<tr><td>'+chat_date+'</td></tr>';
						}
						output += '<tr>'
						output += '<td>' + size +"&nbsp&nbsp&nbsp";
						output += '<a href="detail.do?lf_num=' + item.lf_num+'">';
						output += item.mem_id + '님이 ';
						if(item.al_type==0){
							output += '좋아요를 눌렀습니다.';
						}
						if(item.al_type==1){
							output += '태그를 했습니다.';
						}
						if(item.al_type==2){
							output += '댓글을 달았습니다.';
						}
						//output += item.al_date.split(' ')[1];
						output += '</a><button class="alarm_del" style="float:right" data-id="'+item.al_num+'">삭제</button>'
						output += '</td></tr>'
						//문서 객체에 추가
						$('.striped-table2').append(output);
					});				
				}else{
					alert('알림 목록 읽기 오류 발생');
					message_socket2.close();
				}
			},
			error:function(){
				alert('알림 목록 읽기 네트워크 오류 발생');
				message_socket2.close();
			}
		});
	}
	//알림 삭제
$(document).on('click','.alarm_del',function(){
	
		var al_num = $(this).data('id');
		//alert(al_num);
		let choice = confirm('삭제하시겠습니까?');
		if(choice){
			$.ajax({
				url:'deleteAlarm.do',
				data:{al_num:al_num},
				type:'post',
				dataType:'json',
				success:function(param){
					if(param.result == "logout"){
						alert('로그인 후 사용하세요!');
					}else if(param.result == "success"){
						message_socket.send("msg:");
						alert('알림 삭제 성공');
						message_socket2.send("qwe:");
					}else{
						alert('회원번호 불일치');
					}
				},
				error:function(){
					alert('알림 삭제 네트워크 오류 발생');
				}
			});
		}
	});



