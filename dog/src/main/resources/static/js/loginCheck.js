$(function(){

let mem_id = document.getElementById('mem_id');
let mem_pw = document.getElementById('mem_pw');
	
//===============로그인 유효성 체크================
	
	$('#login_form').submit(function(){
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