<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 중앙 컨텐츠 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/community.fav.js"></script>
<script src="${pageContext.request.contextPath}/js/community.reply.js"></script>


<div class="page-main">
	<h2>${community.lf_title}</h2>
	<ul class="detail-info">
		<li>
			<c:if test="${!empty community.photo_name}">
			<img src="imageView.do?lf_num=${community.lf_num}&community_type=1" width="40" height="40" class="my-photo">
			</c:if>
			<c:if test="${empty community.photo_name}">
			<img src="${pageContext.request.contextPath}/images/face.png" width="40" height="40" class="my-photo">
			</c:if>
		</li>
		<li>
			${community.mem_id}
			<br>
			<c:if test="${!empty community.lf_modify_date}">
			최근 수정일 : ${community.lf_modify_date}
			</c:if>
			<c:if test="${empty community.lf_modify_date }">
			작성일 : ${community.lf_date }
			</c:if>
			조회 : ${community.lf_hit}
		</li>
	</ul>
	<c:if test="${!empty community.lf_imgsrc}">
	<ul>
		<li>
			첨부파일 : <a href="file.do?lf_num=${community.lf_num}">${community.lf_imgsrc}</a>
		</li>
	</ul>
	</c:if>
	<hr size="1" width="100%">
	<!-- filename에 끝부분이 jpg이면 true -->
	<c:if test="${fn:endsWith(community.lf_imgsrc, '.jpg') ||
				  fn:endsWith(community.lf_imgsrc, '.JPG') ||
				  fn:endsWith(community.lf_imgsrc, '.jpeg') || 
				  fn:endsWith(community.lf_imgsrc, '.JPEG') ||
				  fn:endsWith(community.lf_imgsrc, '.gif') ||
				  fn:endsWith(community.lf_imgsrc, '.GIF') ||
				  fn:endsWith(community.lf_imgsrc, '.png') ||
				  fn:endsWith(community.lf_imgsrc, '.PNG')}">
	<div class="align-center">
		<img src="imageView.do?lf_num=${community.lf_num}&community_type=2" class="detail-img">
	</div>
	
	</c:if>
	<p>
		${community.lf_content}
	</p>
	<div>
		<!-- 좋아요 부분 -->    <!-- board_num값을 넘겨준다 -->
		<img id="output_fav" data-num="${community.lf_num}" src="${pageContext.request.contextPath}/images/fav01.gif" width="40">
		<span id="output_fcount"></span>
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == community.mem_num}">
		<input type="button" value="수정" onclick="location.href='update.do?lf_num=${community.lf_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete.do?lf_num=${community.lf_num}');
				}
			};
		</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='list.do'">
	</div>
	<!-- 댓글 UI 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글 달기</span>
		<form id="re_form"><!-- 로그인이 안되어 있으면 사용불가 disabled -->
			<input type="hidden" name="lf_num" value="${community.lf_num}" id="lf_num">
			<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content"
			<c:if test="${empty user}">disabled="disabled"</c:if>
			><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>
			
			<c:if test="${!empty user}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>
			<div id="re_second">
				<input type="submit" value="전송">
			</div>
			</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
	</div>
	<!-- 댓글 UI 끝 -->
	
</div>
<!-- 중앙 컨텐츠 끝 -->









