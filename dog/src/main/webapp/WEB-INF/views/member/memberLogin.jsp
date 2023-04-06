<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/logincheck.js"></script>
    
<!-- 중앙 컨텐츠 시작 -->
<div>
	<h2>로그인</h2>
	<form:form action="login.do" id="login_form" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/> 
		<ul>
			<li>
				<label for="mem_id">아이디</label>
				<form:input path="mem_id"/>
			</li>
			<li><span id="login_Id"></span></li>
			<li>
				<label for="mem_pw">비밀번호</label>
				<form:password path="mem_pw"/>
			</li>
			<li><span id="login_Pw"></span></li>
		</ul>  
		<div class="align-center">
			<form:button>로그인</form:button>
			<input type="button" value="홈으로" onclick="location.href='/main/main.do'">
		</div>                                        
	</form:form>
</div>