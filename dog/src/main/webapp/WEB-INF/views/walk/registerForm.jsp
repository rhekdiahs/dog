<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/walk_register.css">
<div id="main_body">
	<div id="form_wrap">
		<form:form action="register.do" method="post" 
				   modelAttribute="walkVO" enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
			<ul  id = "cont_ul">
				<li style="display:none;">
					<form:input path="walk_position" type="hidden" value="${walk.walk_position}"/>
					<form:input path="mem_name" type="hidden" value="${walk.mem_name}"/>
					<form:input path="walk_distance" type="hidden" value="${walk.walk_distance}"/>
					<form:input path="walk_region" type="hidden" value="${walk.walk_region}"/>		
				</li>				
				<li style = "margin-top : 50px; display : block;">
					<div class="rg_title">
					<p>🐶 <strong>${walk.mem_id}</strong> 님의 산책로 🐶</p>
					</div>
				</li>
				<c:if test="${walk.walk_road != ''}">
				<li <c:if test="${walk.walk_road != ''}">style="margin-top:20px;"</c:if>>
					<label>도로명</label>			
					<input disabled type="text" value="${walk.walk_road}">		
					<form:input path="walk_road" type="hidden" value="${walk.walk_road}"/>
				</li>
				</c:if>
				<li <c:if test="${walk.walk_road != ''}">style="margin-top:20px;"</c:if>>
					<p><label>지번</label></p>
					<input disabled type="text" value="${walk.walk_address}">
					<form:input path="walk_address" type="hidden" value="${walk.walk_address}"/>		
				</li>
				<li>
					<p><label>내용</label></p>
					<form:textarea rows="8" cols="35" placeholder="산책로에 대해 간단히 적어주세요" path="walk_info"/>
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing,services"></script>