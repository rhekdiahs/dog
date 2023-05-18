<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<!-- 중앙 컨텐츠 시작 -->
<script type="text/javascript">
	/*
	RedirectAttributes 객체를 이용해서 리다이렉트한 후 데이터를 표시하기
	위해 자바스크립트로 View에서 메시지 처리를 함.
	이럴 때 다른 페이지로 이동한 후 브라우저 back button를 누르고 다시 돌아오면
	메시지가 사라지지 않고 그대로 다시 노출됨.
	이런 현상을 방지하기 위해 값이 남아 있어도 hash 값이 달라지게 함으로서 메시지가 다시
	호출되지 않도록 처리
	*/
	let result = '${result}';
	if(!location.hash && result == 'success'){//hash값이 없으면
		alert('글쓰기 완료!!');
		history.replaceState('','','#rs');//hash값 변경
	}
	
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
	
</script>
<div class="page-main">
	<h2>게시판 목록</h2>
	<form action="list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>ID</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</li>
		</ul>
	</form>
	<c:if test="${!empty user}">
	
		<form action="list.do" id="search_form2" class="align-right" method="get">
		<ul class="search2">
			<li>
				<select name="keyfield2" id="keyfield2">
					<option value="1" <c:if test="${param.keyfield2 == 1}">selected</c:if>>죄회수순</option>
					<option value="2" <c:if test="${param.keyfield2 == 2}">selected</c:if>>가나다순</option>
				</select>
			</li>
			<li>
				<c:if test="${!empty keyfield}">			
				<input type="hidden" name="keyfield" value="${keyfield}">
				<input type="hidden" name = "keyword" value="${keyword}">
				</c:if>
				<input type="submit" value="찾기">
				<input type="button" value="글쓰기" onclick="location.href='write.do'">
			</li>
		</ul>
		</form>
	</c:if>
	<c:if test="${count == 0 }">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="community" items="${list}">
		<tr>
			<td>${community.lf_num}</td>
			<td>
				<a href="detail.do?lf_num=${community.lf_num}">${community.lf_title}</a>
			</td>
			<td>
				${community.mem_id}
			</td>
			<td>${community.lf_date}</td>
			<td>${community.lf_hit}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->