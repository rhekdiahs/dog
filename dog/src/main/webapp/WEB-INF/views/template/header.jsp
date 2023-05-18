<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script src="${pageContext.request.contextPath}/js/setMenuBtn.js"></script>
<script src="${pageContext.request.contextPath}/js/alarm.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
if(${user!=null}){
	alarm_connect();
	alarm_connect2();
}

</script>
<ul style = "display : flex; justify-content: space-between;">
	<li>
		<c:if test="${empty user}">
			<a class = "menu-icon" href = "${pageContext.request.contextPath}/main/main.do">
			<img id = "menu_homeBtn" src = "https://raw.githubusercontent.com/eirikmadland/notion-icons/master/v5/icon4/mt-home.svg">
			</a>
		</c:if>
		<c:if test="${!empty user && auth != 9}">
			<a class = "menu-icon" href = "${pageContext.request.contextPath}/main/main.do">
			<img id = "menu_homeBtn" src = "https://raw.githubusercontent.com/eirikmadland/notion-icons/master/v5/icon4/mt-home.svg">
			</a>
		</c:if>
		<c:if test="${!empty user && auth == 9}">
			<a class = "menu-icon" href = "${pageContext.request.contextPath}/main/admin.do">
			<img id = "menu_homeBtn" src = "https://raw.githubusercontent.com/eirikmadland/notion-icons/master/v5/icon4/mt-home.svg">
			</a>
		</c:if>
	</li>
	<c:if test="${!empty user}">
	<li>
		<a id = "menu-iconA" href = "${pageContext.request.contextPath}/community/alarmlist.do?mem_num=${user.mem_num}">
			<img id="menu_notiBtn" src="../image_bundle/noti_btn.png">
			<!-- 알림 갯수 -->
			<span class="count" style="position: fixed; right: 15px; top: 10px; z-index:999;"></span>
    		
		</a>
	</li>
	</c:if>
</ul>
