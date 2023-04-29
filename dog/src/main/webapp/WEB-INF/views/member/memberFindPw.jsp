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
		<div style = "text-align: center;">
		<img id = "4orDog_title" src = "${pageContext.request.contextPath}/image_bundle/4orDog.png" style = "margin : 10px 0; width : 60vw">
		</div>
		<br>
		<form:form action="findPw.do" id="find_form" modelAttribute="memberVO">
			<div>
			<form:errors element="div" cssClass="error-color"/>
			<ul>
				<li>
					<label for="mem_id"><small>아이디</small></label><br>
					<div class = "inputWrap">
					<form:input path="mem_id" class = "align-left" autocomplete="off" placeholder = "아이디를 입력하세요"/>
					</div>
					<div id="message_id"></div> <!-- js를 위한 태그 -->
					<form:errors path="mem_id" cssClass="error-color"/> <!-- 에러문구 -->
					
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
						<button type="button" class="btn btn-primary checkSome" id="mail-Check-Btn">전송</button>
					</div>
					</div>
					<input type="text" id="email_direct" class = "inputWrap" name="email_direct" placeholder="이메일 입력"/>
					<input type="hidden" id="mem_email" name="mem_email" value="">
				</li>
				<li>
					<div class="mail-check-box">
						<div class = "inputWrap">
						<input class="form-control mail-check-input align-left" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
						
						
						</div>
					</div>
					<div id="mail-check-warn"></div>
				</li>
			</ul>
			</div>
			<div style = "text-align: center;">
				<form:button class = "login-btn">비밀번호 찾기</form:button>
			</div>
		</form:form>
	</div>
</div>

<!-- 중앙 컨텐츠 끝 -->

