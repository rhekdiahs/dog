<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminList.css">
<div>
	<div>
		<c:if test="${count > 0}">
			<h3>등록된 리스트</h3>
			<hr>
			<div>
			<ul id="place-list" class="place-list">
				<c:forEach var="cafe" items="${cafe}" varStatus="status">
					<li id="${cafe.cafe_num}">
						<div class="list-title">
							<a href="${pageContext.request.contextPath}/cafe/cafeDetail.do?cafe_num=${cafe.cafe_num}" class="title-index"><strong>${status.count}</strong></a>
							<a href="${pageContext.request.contextPath}/cafe/cafeDetail.do?cafe_num=${cafe.cafe_num}" class="title-index"><strong>${cafe.cafe_name}</strong></a>
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
					<hr>
				</c:forEach>
			</ul>
		</div>
		<div class="align-center">${page}</div>
		
		
			<table class="table-list">
				<tr>
					<th>번호</th>
					<th>카페명</th>
					<th>지번</th>
				</tr>
				<c:forEach var="cafe" items="${cafe}">
					<tr>
						<td>${cafe.cafe_num}</td>
						<td><a href="${pageContext.request.contextPath}/cafe/cafeDetail.do?cafe_num=${cafe.cafe_num}">${cafe.cafe_name}</a></td>
						<td>${cafe.cafe_addr2}</td>
					</tr>
				</c:forEach>
			</table>
			<div class="align-center">${page}</div>

			<div>
			<h3>승인 요청 리스트</h3>
				<c:if test="${cafe_detail.cafe_status == 0}">
				<hr>
					<div>
					<ul id="place-list" class="place-list">
						<c:forEach var="cafe" items="${cafe}" varStatus="status">
							<li id="${cafe.cafe_num}">
								<div class="list-title">
									<a href="${pageContext.request.contextPath}/cafe/cafeDetail.do?cafe_num=${cafe.cafe_num}" class="title-index"><strong>${status.count}</strong></a>
									<a href="${pageContext.request.contextPath}/cafe/cafeDetail.do?cafe_num=${cafe.cafe_num}" class="title-index"><strong>${cafe.cafe_name}</strong></a>
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
					<hr>
				</c:forEach>
			</ul>
		</div>
					</c:if>
				<%-- <div>${page}</div> --%>
			</div>
		</c:if>
	</div>
</div>