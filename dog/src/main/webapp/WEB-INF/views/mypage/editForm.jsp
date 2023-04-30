<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/edit.css">
<div id="main_body">
	<div id="form_wrap">
	<img src = "${pageContext.request.contextPath}/mypage/photoView.do" class = "profile-photo" width = "150" height = "150">
			<br>
			<br>
			<input type = "file" id = "upload" accept = "image/gif, image/png, image/jpeg" style = "margin-left : 57px;">
		<form:form action="modifyProfile.do'" method="post" 
				   modelAttribute="memberVO" enctype="multipart/form-data">
			<ul  id = "cont_ul">
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
<script type="text/javascript"></script>