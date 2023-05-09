<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 문자열 형태를 json 방식으로 파싱할 때 필요함 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<input type="text" name="query" id="in" placeholder="검색어를 입력하세요" />
<button type="button" id="chk">네이버 블로그 검색</button>

<div id="aa"></div>
<script type="text/javascript">
var button = document.getElementById('chk');
var input = document.getElementById('in');

button.disabled = true; // 초기에 submit 버튼을 비활성화합니다.

input.addEventListener('input', () => {
	button.disabled = input.value === ""; // 선택 옵션이 아닐 경우 submit 버튼을 활성화합니다.
});
var value = input.value;

$('#chk').click(function(){
	var value = input.value;
	$.ajax({
		url: '../naver/search2.do',
		type:'get',
		dataType:'json',
		data:{query:value},
		success:function(param){
			let obj = JSON.parse(param.response);
			console.log(obj.items);
			$('#aa').empty();
			let output ='';
			$(obj.items).each(function(index,item){
				output += '<span>' + item.title+ '</span><br>';
				output += '<a href="'+item.link+'">' + item.link +'</a><br>';
				output += '<p>' + item.description+ '</p><br><br>';
			});
			$('#aa').append(output);
		},
		error:function(){
			alert('네트워크 오류 발생');
		}
	});
	
});
</script>



