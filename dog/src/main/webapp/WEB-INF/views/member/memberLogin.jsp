<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/logincheck.js"></script>
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
displayToken();
function displayToken() {
  var token = getCookie('authorize-access-token');

  if(token) {
    Kakao.Auth.setAccessToken(token);
    Kakao.Auth.getStatusInfo()
      .then(function(res) {
        if (res.status === 'connected') {
          document.getElementById('token-result').innerText
            = 'login success, token: ' + Kakao.Auth.getAccessToken();
        }
      })
      .catch(function(err) {
        Kakao.Auth.setAccessToken(null);
      });
  }
}

function getCookie(name) {
  var parts = document.cookie.split(name + '=');
  if (parts.length === 2) { return parts[1].split(';')[0]; }
}

//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  

</script>   
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
			<a id="kakao-login-btn" href="javascript:loginWithKakao()">
  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
    alt="카카오 로그인 버튼" />
</a>
<input type="button" value="카카오로그인" onclick="javascript:kakaoLogin()">
<input type="button" value="카카오로그아웃" onclick="location.href='/main/main.do'">
		</div>                                        
	</form:form>
</div>