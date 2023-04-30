<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminList.css">
<div class="main-body">
	<div>
		<c:if test="${count > 0}">
				<div class="list-item">	
				<h3 class="list-id">승인 요청 리스트</h3>
				<ul id="place-list" class="place-list">
					<c:forEach var="cafe" items="${cafe}" varStatus="status">
						<li id="${cafe.cafe_num}">
							<div class="list-title">
								<a href="${pageContext.request.contextPath}/cafe/cafeDetail.do?cafe_num=${cafe.cafe_num}" class="title-index"><strong class = "index-bound">${status.count}</strong></a>
								<a href="${pageContext.request.contextPath}/cafe/cafeDetail.do?cafe_num=${cafe.cafe_num}" class="title-index"><strong style="color:#494949;">${cafe.cafe_name}</strong></a>
								<span class="cafe-cate"> 
									<c:if test="${cafe.cafe_cate == 0}"><small>애견 카페</small></c:if> 
									<c:if test="${cafe.cafe_cate == 1}"><small>애견 동반 카페</small></c:if>
								</span>
							</div>
					<div class="list-content">
						<p class="cafe-addr1">${cafe.cafe_addr1}</p>
						<p class="cafe-addr2">
							<small>(지번)${cafe.cafe_addr2}</small>
						</p>
						<c:if test="${!empty cafe.cafe_phone}">
							<p class="cafe-phone">${cafe.cafe_phone}</p>
						</c:if>
					</div>
				</li>
			</c:forEach>
		</ul>
	<div id = "pageDiv" class="align-center">${page}</div>
	</div>
	</c:if>
	</div>
</div>