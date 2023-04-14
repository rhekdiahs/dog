<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
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
<div>
	<c:if test="${!empty user}">
	<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
	</c:if>
	<c:if test="${empty user}">
	<a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a>
	<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
	</c:if>
	<a href="${pageContext.request.contextPath}/walk/list.do">산책경로</a>
	<a href="${pageContext.request.contextPath}/cafe/cafeList.do">카페 목록</a>
	<a href="${pageContext.request.contextPath}/shelter/shelterList.do">임시보호소</a>
	<%-- <a href="${pageContext.request.contextPath}/hospital/main.do">병원</a> --%>
	<a href = "javascript:void(0);" onclick="withCurCity()">병원</a>
</div>
