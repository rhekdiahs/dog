<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f51f9d8c2a383e5820415bbc36c1551a&libraries=services,clusterer,drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/select.css">
<div class="map_wrap">
    <div id="map" style="position:relative; overflow:hidden;"></div>
    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div id="searchBox">           
                 <button id="toggleBtn">좌표 찍기</button>
                 <form onsubmit="searchPlaces(); return false;">
                    <input type="search" placeholder="내용입력" value="" id="keyword" size="15"> 
                    <button type="submit" id="submit">검색</button> 
                </form>
            </div>
        </div>
        <div id="clickLatlng"></div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
	<form action="cafeWrite.do" method="get" id="cafe_regi">
	    <input type="hidden" id="cafe_name" name="cafe_name">
	    <input type="hidden" id="cafe_addr1" name="cafe_addr1">
	    <input type="hidden" id="cafe_addr2" name="cafe_addr2">
	    <input type="hidden" id="cafe_y" name="cafe_y">
	    <input type="hidden" id="cafe_x" name="cafe_x">
	    <input type="hidden" id="cafe_region" name="cafe_region">
	    <input type="submit" value="카페 등록하기" id="cafe_reg">
    </form>
</div>
<script src="${pageContext.request.contextPath}/js/select.js"></script>

