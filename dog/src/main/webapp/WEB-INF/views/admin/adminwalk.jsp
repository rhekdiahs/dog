<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminList.css">
<div class="main-body">
	<div>
		<c:if test="${count > 0}">
				<div class="list-item">	
				<h3 class="list-id">승인 요청 리스트</h3>
				<ul id="place-list" class="place-list">
					<c:forEach var="walk" items="${walk}" varStatus="status">
						<li id="${walk.walk_num}">
							<div class="list-title">
								<a href="${pageContext.request.contextPath}/walk/viewWalk.do?walk_num=${walk.walk_num}" class="title-index"><strong class = "index-bound">${status.count}</strong></a>
								<a href="${pageContext.request.contextPath}/walk/viewWalk.do?walk_num=${walk.walk_num}" class="title-index"><strong style="color:#494949;">${walk.mem_name}</strong></a>
							</div>
					<div class="list-content">
						<p class="cafe-addr1">${walk.walk_address}</p>
					</div>
				</li>
			</c:forEach>
		</ul>
	<div id = "pageDiv" class="align-center">${page}</div>
	</div>
	</c:if>
	</div>
</div>