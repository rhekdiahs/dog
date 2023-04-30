<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/edit.css">
<div id="main_body">
	<div id="form_wrap">
		<form:form action="updateProfile.do" method="post" 
				   modelAttribute="memberVO" enctype="multipart/form-data">
			<ul  id = "cont_ul">
			<li>
				<img src = "${pageContext.request.contextPath}/mypage/photoView.do" class = "profile-photo" width = "150" height = "150">
				<input type="file" id="upload" name="upload" accept="image/gif, image/png, image/jpeg" style = "margin-left : 40px;">
			</li>	
				<li style = "margin-top : 50px;">
					<div class="rg_title">
					<form:input type="text" value="${member.mem_name}" path="mem_name"/>
					</div>
				</li>
				
				<li>
					<p><label>이메일</label></p>		
					<input disabled type="text" value="${member.mem_email}">		
				</li>
				<li>
					<p><label>자기소개</label></p>
					<form:textarea rows="8" cols="35" path="mem_intro"/>
				</li>
				<li style="margin-top: 35px;">
					<input type="button" id="cancel_btn" value="취소">
					<input type="submit" id="regi_btn" value="저장">
				</li>
			</ul>
		</form:form>
	</div>
</div>
<script type="text/javascript">
$(function(){
	//첫 이미지 세팅

	let photo_path = $('.profile-photo').attr('src');
	let my_photo; //업로드하고자하는 이미지 저장
	
	console.log(photo_path);
	
	$('#upload').change(function(){
		my_photo = this.files[0];
		if(!my_photo){
			let upload = $('#upload').val();
			console.log(upload);
			$('.profile-photo').attr('src', photo_path);
			return;
		}
		
		if(my_photo.size > 1024*1024*5){
			alert(Math.round(my_photo.size/1024/5) 
			   + 'MB(5MB까지만 업로드 가능)');
			$('.profile-photo').attr('src',photo_path);
			$(this).val('');
			return;			
		}
		
		//이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(my_photo);
		console.log('cancel click - ' + upload);
		console.log('reader - ' + photo_path);
		
		reader.onload = function(){
			$('.profile-photo').attr('src', reader.result);
		};
	});
	
	//서버에 데이터 전송
	$('#regi_btn').click(function(){
		if($('#upload').val() == ''){
			my_photo = photo_path;
			return;
		}
 		//파일 전송
 		
		let form_data = new FormData();
		form_data.append('upload',my_photo);
		form_data.append('mem_name',$('#mem_name').val());
		form_data.append('mem_intro', $('#mem_intro').val());
		
/* 		$.ajax({
			url:'updateProfile.do',
			data:form_data,
			type:'post',
			dataType:'json',
			contentType:false,
			enctype:'multipart/form-data',
			processData:false,
			success:function(param){
				if(param.result == 'success'){
					alert('프로필 사진이 수정되었습니다.');
					//교체된 이미지 저장
					photo_path = $('.profile-photo').attr('src');
					$('#upload').val('');
					location.reload();
				}else{
					alert('파일 전송 중 오류가 발생했습니다.');
				}
			},
			error:function(){
				alert('네트워크 오류가 발생했습니다.');
			}
		});*/
	}); 
	 
	//취소시
	$('#cancel_btn').click(function(){
		$('.profile-photo').attr('src',photo_path);
		$('#upload').val('');
	});
});
</script>