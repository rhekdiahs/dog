$(function(){

	let viewportHeight = window.innerHeight;
	let viewportWidth = window.innerWidth;
	
	var contentHeight = $("#main").css("height");
	var margin = parseInt(viewportHeight)-parseInt(contentHeight);
	$('#main_div').css('margin-top', margin/2);
	$('#main_div').css('margin-bottom', margin/2);
	console.log('viewportheight = ' + viewportHeight)
	console.log('contentheight = ' + contentHeight);
	console.log('margin = ' + margin);
});