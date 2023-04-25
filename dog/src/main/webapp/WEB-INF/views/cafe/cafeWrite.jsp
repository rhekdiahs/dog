<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div>
	<div  style="text-align:center;">
	<form:form action="cafeWrite.do" method="post" 
			   modelAttribute="cafeVO" enctype="multipart/form-data">
		<ul>
			<li>
				<label>카페 종류</label>
				<form:radiobutton path="cafe_cate"
						value="0" id="cafe_cate0"/>애견카페
				<form:radiobutton path="cafe_cate"
					value="1" id="cafe_cate1" checked="checked"/>애견 동반 카페
			</li>
			<li>
				<label>카페명</label>
				<input type="text" id="cafe_name" name="cafe_name" value="${cafe_name}">
			</li>
			<li>
				<label>주소</label>
				<c:if test="${!empty cafe_addr1}">
				<input type="text" id="cafe_addr1" name="cafe_addr1" value="${cafe_addr1}">
				<input type="hidden" id="cafe_addr2" name="cafe_addr2" value ="${cafe_addr2}">
				</c:if>
				<c:if test="${empty cafe_addr1}">
				<input type="hidden" id="cafe_addr1" name="cafe_addr1" value="">
				<input type="text" id="cafe_addr2" name="cafe_addr2" value="${cafe_addr2}">
				</c:if>
			</li>
			<li>
				<input type="hidden" id="cafe_y" name="cafe_y" value="${cafe_y}">
				<input type="hidden" id="cafe_x" name="cafe_x" value="${cafe_x}">
			</li>
			<li>
				<input type="hidden" id="cafe_region" name="cafe_region" value="${cafe_region}">
			</li>
			<li>
				<label>전화번호</label>
				<input type="text" id="cafe_phone" name="cafe_phone">
			</li>
			<li>
				<label>홈페이지</label>
				<input type="text" id="cafe_site" name="cafe_site">
			</li>
			<li>
				<label>내용</label>
				<textarea rows="5" cols="20" id="cafe_content" name="cafe_content"></textarea>
			</li>
			<li>
				<label>사진 업로드</label>
				<input type="file" name="upload" id="upload">
			</li>
			<li>
				<input type="submit" value="신청">
				<input type="button" value="뒤로가기" onclick="location.href='cafe/cafeSelect.do'">
			</li>
		</ul>
	</form:form>
    </div>
</div>