<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 중앙 컨텐츠 시작 -->

<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirmId.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/setViewHeigh.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/findIdPw.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">

<div id = "main_div">
	<div class = "wrap-cont">
		<img id = "4orDog_title" src = "${pageContext.request.contextPath}/image_bundle/4orDog.png" style = "margin : 10px 0; width : 60vw">
		<br>
		<form:form action="findId.do" id="find_form" modelAttribute="memberVO">
			<div>
			<form:errors element="div" cssClass="error-color"/>
			<ul>
				<li>
					<label for="mem_name"><small>이름</small></label>
					<div class = "inputWrap">
					<form:input path="mem_name" class = "align-left" placeholder = "이름을 입력하세요"/>
					</div>
					<form:errors path="mem_name" cssClass="error-color"/>
				</li>
				<li>
					<label for="user_email"><small>이메일</small></label>
					<div class = "inputWrap">
					<input type="text" id="user_email" class = "align-left" required placeholder = "이메일을 입력하세요">
					<div id = "confrimEmail">
						<span id="middle"><small>@</small></span>
						<select id="email_address" name="email_address" title="이메일 선택" class="email_address">
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="direct">직접입력</option>
						</select>
					</div>
					</div>
					<input type="text" id="email_direct" class = "inputWrap" name="email_direct" placeholder="이메일 입력"/>
					<input type="hidden" id="mem_email" name="mem_email" value="">
				</li>
				<li>
					<div class="mail-check-box">
						<div class = "inputWrap">
						<input class="form-control mail-check-input align-left" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
						
						<button type="button" class="btn btn-primary checkSome" id="mail-Check-Btn">본인인증</button>
						</div>
					</div>
					<div id="mail-check-warn"></div>
				</li>
			</ul>
			</div>
			<div>
				<form:button class = "login-btn">아이디 찾기</form:button>
			</div>
		</form:form>
	</div>
</div>

<!-- 중앙 컨텐츠 끝 -->

