<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script>
	$(function(){
		if(sessionStorage.getItem('curCity') == '' || sessionStorage.getItem('curCity') == null){
			$.ajax({
				url: "https://geolocation-db.com/jsonp/",
				jsonpCallback: "callback",
				dataType: "jsonp",
				success: function( location ) {
					sessionStorage.setItem('curCity', location.state);
				}
			});
		}
		let viewportHeight = window.innerHeight;
		let viewportWidth = window.innerWidth;
		
		var contentHeight = $("#main_div").css("height");
		var margin = parseInt(viewportHeight)-parseInt(contentHeight);
		$('#main_div').css('margin-top', margin/2);
		$('#main_div').css('margin-bottom', margin/2);
		console.log('viewportheight = ' + viewportHeight)
		console.log('contentheight = ' + contentHeight);
		console.log('margin = ' + margin);
	});
	console.log(sessionStorage.getItem('curCity'));
	
	function withCurCity(){
		$.ajax({
			url : "/hospital/curCityAjax.do",
			data : {curCity : sessionStorage.getItem('curCity')},
			type : 'post',
			dataType : 'json',
			success : function(param){
				location.href = '/hospital/main.do?keyfield=' + param.result;
			},
			error : function(){
				
			}
		});
	}

</script>
<div id = "main_div">
	<img id = "main_logo" src = "${pageContext.request.contextPath}/image_bundle/logo1.png">
	<div class = "menu-grid">
<%-- 		<div class = "menu-list">
			<a href="${pageContext.request.contextPath}/walk/list.do">산책경로</a>
		</div>
		<div class = "menu-list">
			<a href="${pageContext.request.contextPath}/cafe/cafeList.do">카페 목록</a>
		</div>
		<div class = "menu-list">
			<a href="${pageContext.request.contextPath}/shelter/shelterList.do">임시보호소</a>
		</div>
		<div class = "menu-list">
			<a href = "javascript:void(0);" onclick="withCurCity()">병원</a>
		</div> --%>

		<a class = "menu-list" href="${pageContext.request.contextPath}/walk/list.do">산책경로</a>

		<a class = "menu-list" href="${pageContext.request.contextPath}/cafe/cafeList.do">카페 목록</a>

		<a class = "menu-list" href="${pageContext.request.contextPath}/shelter/shelterList.do">임시보호소</a>
		<a class = "menu-list" href = "javascript:void(0);" onclick="withCurCity()">병원</a>
	</div>
	<c:if test="${!empty user}">
	<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
	</c:if>
	<c:if test="${empty user}">
	<a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a>
	<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
	</c:if>

</div>
