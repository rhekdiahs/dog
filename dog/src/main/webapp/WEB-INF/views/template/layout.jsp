<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'"/>
<title><tiles:getAsString name="title"/></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- <script>
	$(function(){
		//$("body").css("display", "none");
		//$("body").fadeIn();		
	});
	//출처: https://sweet-myo.tistory.com/168

	/* $("a.transition").click(function(event){
	event.preventDefault();
	linkLocation = this.href;
	$("body").fadeOut(0, redirectPage);
	}); */
	/* function redirectPage() {
	window.location = linkLocation;
	} */
</script> -->

</head>
<body>
<div id="main">
	<div id="main_header">
		<tiles:insertAttribute name="header"/>
	</div>
	<div id="main_body">
		<tiles:insertAttribute name="body"/>
	</div>
<%-- 	<div id="main_footer">
		<tiles:insertAttribute name="footer"/>
	</div> --%>
</div>	
</body>
</html>




