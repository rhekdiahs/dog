<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/logincheck.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/setViewHeigh.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js" integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
<script>
// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
Kakao.init('ab928e5929563772b2932e6182f6b7d9');

// SDK 초기화 여부를 판단합니다.
console.log(Kakao.isInitialized());

function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8080/member/kakaoLogin',
    });
  }
</script>   
<!-- 중앙 컨텐츠 시작 -->
<div id = "main_div">
	<div class = "wrap-cont">
		<img id = "4orDog_title" src = "${pageContext.request.contextPath}/image_bundle/4orDog.png" style = "margin : 10px 0; width : 60vw">
		<br>
		<form:form action="login.do" id="login_form" modelAttribute="memberVO">
			<form:errors element="div" cssClass="error-color"/> 
			<ul>
				<li>
					<label for="mem_id"></label>
					<form:input path="mem_id" placeholder = "ID"/>
				</li>
				<li><span id="login_Id"></span></li>
				<li>
					<label for="mem_pw"></label>
					<form:password path="mem_pw" placeholder = "PASSWORD"/>
				</li>
				<li><span id="login_Pw"></span></li>
			</ul>  
			<div class="align-center">
				<form:button class = "login-btn">Login</form:button><br>
				<hr style = "border : 1px solid lightgray; width : 60vw; margin : 10px auto; opacity : 0.3;">
				<!-- <a id="kakao-login-btn" href="javascript:loginWithKakao()">카카오 로그인</a> -->
			</div>
			<p style = "margin-bottom : 10px;">
			<a href = "/member/findId.do" style ="font-size : 11px; color : gray; opacity : 0.7;">아이디 찾기</a>
			<span style ="font-size : 13px; color : gray; opacity : 0.7; margin : 0 4px">|</span>
			<a href = "/member/findPw.do" style ="font-size : 11px; color : gray; opacity : 0.7;">비밀번호 찾기</a>
			<span style ="font-size : 13px; color : gray; opacity : 0.7; margin : 0 4px">|</span>
			<img id = "kakao-login-btn" src = "${pageContext.request.contextPath}/image_bundle/kakaoLogin.png" onclick = "javascript:loginWithKakao()">
			</p>                                        
		</form:form>
	</div>
</div>