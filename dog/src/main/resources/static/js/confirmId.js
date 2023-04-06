$(function(){
	let checkId = 0;
	
	//=============아이디 중복 체크=============
	$('#confirmId').click(function(){
		if($('#mem_id').val().trim()==''){
			$('#message_id').css('color','#E65962').text('아이디를 입력하세요');
			$('#mem_id').val('').focus();
			return;
		}
	
		//서버와 통신
		$.ajax({
			url:'confirmId.do',
			type:'post',
			data:{mem_id:$('#mem_id').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'idNotFound'){
					$('#message_id').css('color','#000').text('사용가능합니다.');
					checkId = 1;	
				}else if(param.result == 'idDuplicated'){
					$('#message_id').css('color','#E65962').text('존재하는 아이디입니다.');
					checkId = 0;
				}else if(param.result == 'notMatchPattern'){
					$('#message_id').css('color','#E65962').text('4~12자의 영문 소문자, 숫자만 사용 가능합니다.');
					checkId = 0;
				}else{
					checkId = 0;
					alert('아이디 중복체크 오류');
				}
			},
			error:function(){
				checkId = 0;
				alert('네트워크 오류 발생');
			}
		});	
		
	}); //end of click
	
	//=========아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화=========
	$('#register_form #mem_id').keydown(function(){
		checkId = 0;
		$('#message_id').text('');
	}); //end of keydown
	
	//submit 이벤트 발생시 아이디 중복 체크 여부 확인
	$('#register_form').submit(function(){
		if(checkId==0){
			$('#message_id').css('color','#E65962').text('중복체크 필수');
			if($('#mem_id').val().trim()==''){
				$('#mem_id').val('').focus();
			}
			return false;
		}
	}); //end of submit
	
	
	//=============비밀번호 확인===============
	$("#mem_pw,#pw_confirm").keyup(function(){
		let mem_pw = $("#mem_pw").val();
		let pw_confirm = $("#pw_confirm").val();
		
		if(mem_pw=='' && pw_confirm==''){
			$("#confirmMsg").text("");
			return;
		}
		
		if(mem_pw!='' && pw_confirm!=''){
			if(mem_pw == pw_confirm){
				$("#confirmMsg").text("비밀번호 일치").css('color','#000');
				return;
			}
			if(mem_pw != pw_confirm){
				$("#confirmMsg").text("비밀번호 불일치").css('color','#E65962');
				return;
			}
		}
	});
	
	
	
	$('#register_form').submit(function(){
		//공백입력시
		if($('#mem_id').val().trim()==''){
			$("#login_Id").text("아이디를 입력하세요");
			$('#mem_id').val('').focus();
			return false;
		}
		if($('#mem_pw').val().trim()==''){
			$("#login_Pw").text("비밀번호를 입력하세요");
			$('#mem_pw').val('').focus();
			return false;
		}
		//유효성
		let right_id = /^[a-z0-9]{4,12}$/;
		let right_pw = /^[A-Za-z0-9]{8,16}$/;

    	if(!right_id.test(mem_id.value)){
      		$('#login_Id').text("4~12자의 영문 소문자, 숫자로 입력하세요.");
			$('#mem_id').val('').focus();
			return false;
		}
		
		if(!right_pw.test(mem_pw.value)){
      		$('#login_Pw').text("8~16자의 영문 대소문자, 숫자로 입력하세요.");
			$('#mem_pw').val('').focus();
			return false;
		}
    	
	});
	
	

});


