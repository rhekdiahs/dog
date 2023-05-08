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
					<c:forEach var="hos" items="${hospital}" varStatus="status">
						<li id="${hos.hospital_num}">
							<div class="list-title">
								<a href="${pageContext.request.contextPath}/hospital/hospitalDetail.do?hospital_num=${hos.hospital_num}" class="title-index"><strong class = "index-bound">${status.count}</strong></a>
								<a href="${pageContext.request.contextPath}/hospital/hospitalDetail.do?hospital_num=${hos.hospital_num}" class="title-index"><strong style="color:#494949;">${hos.h_name}</strong></a>
								<span class="cafe-cate"> 
									<c:if test="${hos.hospital_type == 0}"><small>동물 병원</small></c:if> 
									<c:if test="${hos.hospital_type == 1}"><small>24시 병원</small></c:if>
								</span>
							</div>
					<div class="list-content">
						<p class="cafe-addr1">${hos.road}</p>
						<p class="cafe-addr2">
							<small>(지번)${hos.h_address}</small>
						</p>
						<c:if test="${!empty hos.h_phone}">
							<p class="cafe-phone">${hos.h_phone}</p>
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