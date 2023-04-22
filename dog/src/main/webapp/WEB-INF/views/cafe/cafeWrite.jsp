<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f51f9d8c2a383e5820415bbc36c1551a&libraries=services,clusterer,drawing"></script>
<script src="${pageContext.request.contextPath}/js/setMapWidth.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/write.css">
<div class="map_wrap">
    <div id="map" style="position:relative; overflow:hidden;"></div>
    <div id="menu_wrap" class="bg_white">
        <div class="option">
		<button id="selfCheck" onclick="check()">버튼1</button>
		<button id="searchCheck" onclick="active()">버튼2</button>
		<button id = "toggleBtn">토글버튼</button>
            <div id="searchBox" style="display: none;">
                 <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="search" placeholder="내용입력" value="" id="keyword" size="15"> 
                    <button type="submit" id="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <div id="clickLatlng"></div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
    <div>
    <Button>위치 등록하기</Button>
	<form>
		<div>
			<input type="radio" id="cafe_cate1" value="0">
			<label for="cafe_cate1">애견카페</label>
			<input type="radio" id="cafe_cate2" value="1">
			<label for="cafe_cate1">애견 동반 카페</label>
		</div>
		<div>
			<span>카페명</span>
			<input type="text" id = "aaa">
		</div>
		<div>
			<span>주소</span>
			<input type="text">
		</div>
		<div>
			<span>설명</span>
			<textarea rows="5" cols="20">내용</textarea>
		</div>
	</form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/write.js"></script>

