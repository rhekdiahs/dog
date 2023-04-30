<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="main_body">
	<div id="form_wrap">
		<form:form action="modifyProfile.do'" method="post" 
				   modelAttribute="memberVO" enctype="multipart/form-data">
			<ul  id = "cont_ul">
				<li style = "margin-top : 50px;">
					<div class="rg_title">
					<input disabled type="text" value="${member.mem_name}">
					</div>
				</li>
				
				<li>
					<label>도로명</label>			
					<input disabled type="text" value="">		
					<form:input path="" type="hidden" value=""/>
				</li>
				<li>>
					<p><label>지번</label></p>
					<input disabled type="text" value="">
					<form:input path="" type="hidden" value=""/>		
				</li>
				<li>
					<p><label>내용</label></p>
					<form:textarea rows="8" cols="35" placeholder="산책로에 대해 간단히 적어주세요" path=""/>
				</li>
				<li>
					<p><label>파일</label></p>
					<input type="file" name="upload" id="upload">
				</li>
				<li style="margin-top: 35px;">
					<input type="submit" id="regi_btn" value="등록">
					<input type="button" id="back_btn" value="이전" onclick="location.href='history.go(-1)'">
				</li>
			</ul>
		</form:form>
	</div>
</div>