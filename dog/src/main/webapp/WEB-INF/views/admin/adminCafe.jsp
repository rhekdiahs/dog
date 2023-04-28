<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<div>
		<c:if test="${count > 0}">
			<table>

				<tr>
					<th>번호</th>
					<th>카페명</th>
					<th>도로명</th>
					<th>지번</th>
				</tr>
				<c:forEach var="cafe" items="${cafe}">
					<tr>
						<td>${cafe.cafe_num}</td>
						<td>${cafe.cafe_name}</td>
						<td>${cafe.cafe_addr1}</td>
						<td>${cafe.cafe_addr2}</td>
					</tr>
				</c:forEach>
			</table>
			<div>${page}</div>

			<div>
				<table>
					<c:if test="${cafe_detail.cafe_status == 0}">
						<tr>
							<th>번호</th>
							<th>카페명</th>
							<th>도로명</th>
							<th>지번</th>
						</tr>
						<c:forEach var="cafe" items="${cafe}">
							<tr>
								<td>${cafe.cafe_num}</td>
								<td>${cafe.cafe_name}</td>
								<td>${cafe.cafe_addr1}</td>
								<td>${cafe.cafe_addr2}</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				<div>${page}</div>
			</div>
		</c:if>
	</div>
</div>