<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 중앙 컨텐츠 시작 -->

<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirmId.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/makeEmail.js"></script>
<script>
$(document).on("keyup", ".mem_phone", function() {
	$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3" ).replace("--", "-")); 
});
function numberphone(e){
	if(e.value.length>13){
		e.value=e.value.slice(0,13);
	}
}
</script>

<div>
	<form:form action="registerUser.do" id="register_form" modelAttribute="memberVO">
		<div>
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<label for="mem_id">아이디</label>
				<form:input path="mem_id" autocomplete="off"/>
				<input type="button" id="confirmId" value="아이디 중복체크">
				<div id="message_id"></div> <!-- js를 위한 태그 -->
				<form:errors path="mem_id" cssClass="error-color"/> <!-- 에러문구 -->
			</li>
			<li>
				<label for="mem_pw">비밀번호</label>
				<form:password path="mem_pw"/>
				<div id="login_Pw"></div>
				<form:errors path="mem_pw" cssClass="error-color"/>
			</li>
			<li>
				<label for="pw_confirm">비밀번호 확인</label>
				<form:password path="pw_confirm"/>
				<span id="confirmMsg"></span>
			</li>
			<li>
				<label for="mem_name">이름</label>
				<form:input path="mem_name"/>
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
			<li>
				<label for="user_email">본인확인 이메일</label>
				<input type="text" id="user_email" required>
				<span id="middle">@</span>
				<select id="email_address" name="email_address" title="이메일 선택" class="email_address">
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="daum.net">daum.net</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="nate.com">nate.com</option>
					<option value="direct">직접입력</option>
				</select>
				<input type="text" id="email_direct" name="email_direct" placeholder="이메일 입력"/>
				<input type="hidden" id="mem_email" name="mem_email" value="">
			</li>
			<li>
				<div class="mail-check-box">
					<input class="form-control mail-check-input" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
					<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
				</div>
				<div id="mail-check-warn"></div>
			</li>
			
			<li>
				<label for="phone">전화번호 (선택)</label>
				<form:input path="mem_phone" oninput="numberphone(this)" class="mem_phone" maxlength="13" placeholder="숫자만 입력하세요"/>
				<form:errors path="mem_phone" cssClass="error-color"/>
			</li>

		</ul>
		</div>
		<div>
			<form:button>가입하기</form:button>
		</div>
	</form:form>
</div>

<!-- 중앙 컨텐츠 끝 -->

