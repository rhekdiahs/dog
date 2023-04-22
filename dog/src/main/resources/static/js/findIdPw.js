$(function(){
	
	//=================이메일 합치기==================
	$("#email_direct").hide();
	
	//이메일 앞부분
	$("#user_email").change(function(){
		email();
	});

	$("#email_address").change(function() {
	if($("#email_address").val() == "direct"){
		$("#email_direct").show();
		$(document).on('keyup','#email_direct',function(){
			email();
		});
	}else{
		$("#email_direct").hide();
		email();
	}
	});
	
	
	//합치기
	function email(){
		let email = $("#user_email").val();
		let middle = $("#middle").text();
		var address;
		if($("#email_address").val()=="direct"){
			address = $("#email_direct").val();
		}else{
			address = $("#email_address").val();
		}
		
		if(email!='' && address!=''){
			$("#mem_email").val(email+middle+address);
		}
	};
	
	
	//============이메일 인증코드==============
	$('#mail-Check-Btn').click(function() {
		if($('#user_email').val()==''){
			$('#user_email').val('').focus();
			$('#mail-check-warn').html('이메일을 입력해주세요');
			$('#mail-check-warn').css('color','#E65962');
			return;
		}else{
			$('#mail-check-warn').html('');
			
		if($("#email_address").val()=="direct"){
			if($('#email_direct').val()==''){
				$("#email_direct").show();
				$('#email_direct').val('').focus();
				$('#mail-check-warn').html('이메일을 입력해주세요');
				$('#mail-check-warn').css('color','#E65962');
				return;
			}
		}
			
			const email = $('#mem_email').val();
			console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
			const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
			
			$.ajax({
				type : 'get',
				url : '../mailCheck?email='+email, // GET방식이라 Url 뒤에 email 붙임
				success : function (data) {
					checkInput.attr('disabled',false);
					code =data;
					alert('인증번호가 전송되었습니다.')
				}			
			});
		}
				
	}); // end send eamil

	// 인증번호 비교 
	$('.mail-check-input').keyup(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#mail-check-warn');
		
		if(inputCode === code){
			$resultMsg.html('인증번호가 일치합니다');
			$resultMsg.css('color','#000');
		}else{
			$resultMsg.html('인증번호가 불일치 합니다');
			$resultMsg.css('color','#E65962');
			
		}
	});


	//유효성 체크
	$('.find_form').submit(function(){
		
		if($('#mem_name').val()==''){
			$('#mem_name').val('').focus();
			$("#message_name").text("이름을 입력해주세요").css('color','#E65962');
			return false;
		}
		
		if($('#mem_id').val()==''){
			$('#mem_id').val('').focus();
			$("#message_name").text("아이디를 입력해주세요").css('color','#E65962');
			return false;
		}
		
		if($("#email_address").val()=="direct"){
			if($('#email_direct').val()==''){
				$("#email_direct").show();
				$('#email_direct').val('').focus();
				return false;
			}
		}
		
		if($('.mail-check-input').val()==''){
			$('.mail-check-input').val('');
			$('#mail-check-warn').html('인증번호를 입력해주세요');
			$('#mail-check-warn').css('color','#E65962');
			return false;
		}
		
		const inputCode = $('.mail-check-input').val();
		const $resultMsg = $('#mail-check-warn');
			
		if(inputCode !== code){
			$resultMsg.html('인증번호가 불일치 합니다');
			$resultMsg.css('color','#E65962');
			return false;	
		}
		
	});
	
	
});

	

