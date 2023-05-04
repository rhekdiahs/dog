<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 아이콘 사용할려면 필수 -->
<script defer src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" integrity="sha384-vuFJ2JiSdUpXLKGK+tDteQZBqNlMwAjhZ3TvPaDfN9QmbPb7Q8qUpbSNapQev3YF" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/weather.css">
	<select name="keyfield" id="keyfield">
		<option selected="selected">--선택</option>
		<option value="seoul" <c:if test="${param.keyfield == 'seoul'}">selected</c:if>>서울</option>
		<option value="Gyeonggi-do" <c:if test="${param.keyfield == 'Gyeonggi-do'}">selected</c:if>>경기</option>
		<option value="Gangwon-do" <c:if test="${param.keyfield == 'Gangwon-do'}">selected</c:if>>강원</option>
		<option value="Chungcheongbuk-do" <c:if test="${param.keyfield == 'Chungcheongbuk-do'}">selected</c:if>>충북</option>
		<option value="Chungcheongnam-do" <c:if test="${param.keyfield == 'Chungcheongnam-do'}">selected</c:if>>충남</option>
		<option value="Jeollabuk-do" <c:if test="${param.keyfield == 'Jeollabuk-do'}">selected</c:if>>전북</option>
		<option value="Jeollanam-do" <c:if test="${param.keyfield == 'Jeollanam-do'}">selected</c:if>>전남</option>
		<option value="Gyeongsangbuk-do" <c:if test="${param.keyfield == 'Gyeongsangbuk-do'}">selected</c:if>>경북</option>
		<option value="Gyeongsangnam-do" <c:if test="${param.keyfield == 'Gyeongsangnam-do'}">selected</c:if>>경남</option>
		<option value="Jeju" <c:if test="${param.keyfield == 'Jeju'}">selected</c:if>>제주</option>
	</select>
					
	<input type="submit" id = "chk" value="선택">
	<div id="aa"></div>
	
	
	
<script type="text/javascript">
const select = document.getElementById('keyfield');
const submit = document.getElementById('chk');
submit.disabled = true; // 초기에 submit 버튼을 비활성화합니다.
select.addEventListener('change', () => {
  submit.disabled = select.value === '--선택'; // 선택 옵션이 아닐 경우 submit 버튼을 활성화합니다.
});

$('#chk').click(function(){
	//날씨 이모티콘
	var weatherIcon = {
		    '01' : 'fas fa-sun',
		    '02' : 'fas fa-cloud-sun',
		    '03' : 'fas fa-cloud',
		    '04' : 'fas fa-cloud-meatball',
		    '09' : 'fas fa-cloud-sun-rain',
		    '10' : 'fas fa-cloud-showers-heavy',
		    '11' : 'fas fa-poo-storm',
		    '13' : 'far fa-snowflake',
		    '50' : 'fas fa-smog'
		};
	
	// select 요소 가져오기
	var selectBox = document.getElementById("keyfield");

	// 선택된 옵션의 인덱스 가져오기
	var selectedOptionIndex = selectBox.selectedIndex;
	// 선택된 옵션의 값(value) 가져오기
	var selectedOptionValue = selectBox.options[selectedOptionIndex].value;
	
	var apikey = "${key}";
	http://openweathermap.org/img/wn/${weatherIcon}@2x.png
	var wurl = "http://api.openweathermap.org/data/2.5/weather?q=" + selectedOptionValue + "&appid=" +apikey;
	
	
	$.ajax({
		url: wurl,
		type:'get',
		dataType:'json',
		success:function(param){
			$('#aa').empty();
			console.log(param);
			var $Icon = (param.weather[0].icon).substr(0,2);
			let output ="";
			output += '<ul class="wea"><li id="info">'
			output += '<i id="icon" class="' + weatherIcon[$Icon] +'"></i>'
			output += '<span class="r">'
			output += '<span class="l">'+ "현재온도 : " + Math.round((param.main.temp- 273.15)) +"℃"+ '</span><br>';
			output += '<span class="l">'+ "최고온도 : " + Math.round((param.main.temp_max- 273.15)) +"℃"+ '</span><br>';
			output += '<span class="l">'+ "최저온도 : " + Math.round((param.main.temp_min- 273.15)) +"℃"+ '</span><br>';
			output += '<span class="l">'+ "현재습도 : " + param.main.humidity + "%" + '</span><br>';
			output += '<span class="l">'+ "날씨 : " + param.weather[0].main + '</span><br>';
			output += '<span class="l">'+ "바람속도 : " + param.wind.speed + '</span><br>';
			output += '<span class="l">'+ "나라 : " + param.sys.country + '</span><br>';
			output += '<span class="l">'+ "도시이름 : " + param.name  + '</span><br>';
			output += '<span class="l">'+ "구름 : " + (param.clouds.all) +"%" + '</span><br>';
			output += '</span>'
			output += '</li></ul>'
			
             $('#aa').append(output);
             
		},
		error:function(){
			alert('네트워크 오류 발생');
		}
	});
	
});
</script>