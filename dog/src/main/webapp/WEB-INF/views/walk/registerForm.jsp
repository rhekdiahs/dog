<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/walk.css">
<div id="main_body">
	<div id="form_wrap">
		<form:form action="register.do" method="post" 
				   modelAttribute="walkVO" enctype="multipart/form-data">
				<form:input path="walk_position" type="hidden" value="${walk.walk_position}"/>
				<form:input path="mem_id" type="hidden" value="${walk.mem_id}"/>
				<form:input path="walk_distance" type="hidden" value="${walk.walk_distance}"/>
				<form:input path="walk_region" type="hidden" value="${walk.walk_region}"/>		
			<ul>
				<li>
					<div class="rg_title">
					<p>🐶<span>${walk.mem_id}</span> 님의 산책로🐶</p>
					</div>
				</li>
				<li>
				</li>
				<c:if test="${walk.walk_road != null}">
				<li>
					<label>(도로명) ${walk.walk_road}</label>			
					<form:input path="walk_road" type="hidden" value="${walk.walk_road}"/>		
				</li>
				</c:if>
				<li>
					<label>(지번) ${walk.walk_address}</label>		
					<form:input path="walk_address" type="hidden" value="${walk.walk_address}"/>		
				</li>
				<li>
					<p><label>산책로 설명</label></p>
					<form:textarea rows="8" cols="35" path="walk_info"/>
				</li>
				<li>
					<input type="file" name="upload" id="upload">
				</li>
				<li style="margin-top: 10px;">
					<input type="submit" id="regi_btn" value="등록하기">
					<input type="button" id="back_btn" value="뒤로가기" onclick="location.href='history.go(-1)'">
				</li>
			</ul>
		</form:form>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=50bad82a66475d629a06f73901975583&libraries=drawing,services"></script>