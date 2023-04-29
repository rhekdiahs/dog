$(function(){

});
	function createPdel(reqType){

		const parentElem = document.querySelector('#'+reqType+'Li');

		const divReqContWrap = document.createElement('div');
		divReqContWrap.classList.add('reqContWrap');

		const h4 = document.createElement('h4');
		h4.textContent = '해당 위치의 사진을 올려주세요.';

		const small = document.createElement('small');
		small.textContent = '(주변 사진도 함께 촬영해주세요.)';

		const divFormWrap = document.createElement('div');
		divFormWrap.classList.add('formWrap');

		const form = document.createElement('form');
		form.action = 'reqUpdateContent.do';
		form.method = 'post';
		form.id = 'reqForm';

		const label = document.createElement('label');
		label.htmlFor = 'upload';
		label.textContent = '사진 올리기';

		const input = document.createElement('input');
		input.type = 'file';
		input.name = 'upload';
		input.id = 'upload';
		input.style.display = 'none';

		parentElem.appendChild(divReqContWrap);
		divReqContWrap.appendChild(h4);
		divReqContWrap.appendChild(small);
		divReqContWrap.appendChild(divFormWrap);
		divFormWrap.appendChild(form);
		form.appendChild(label);
		form.appendChild(input);
	}
	
	function createPname(reqType){
		
		const parentElem = document.querySelector('#'+reqType+'Li');
		
		const divReqContWrap = document.createElement('div');
		divReqContWrap.classList.add('reqContWrap');
		
		const h4 = document.createElement('h4');
		h4.textContent = '해당 장소의 사진을 올려주세요.';
		
		const small = document.createElement('small');
		small.textContent = '(주변 사진도 함께 촬영해주세요.)';
		
		const divFormWrap = document.createElement('div');
		divFormWrap.classList.add('formWrap');
		
		const form = document.createElement('form');
		form.action = 'reqUpdateContent.do';
		form.method = 'post';
		form.id = 'reqForm';
		
		const inputText = document.createElement('input');
		inputText.type = 'text';
		inputText.classList.add('input-textbox');
		inputText.placeholder = '장소명을 입력해주세요.';
		
		const label = document.createElement('label');
		label.htmlFor = 'upload';
		label.textContent = '사진 올리기';
		
		const input = document.createElement('input');
		input.type = 'file';
		input.name = 'upload';
		input.id = 'upload';
		input.style.display = 'none';
		
		parentElem.appendChild(divReqContWrap);
		divReqContWrap.appendChild(h4);
		divReqContWrap.appendChild(small);
		divReqContWrap.appendChild(divFormWrap);
		divFormWrap.appendChild(form);
		form.appendChild(inputText);
		form.appendChild(label);
		form.appendChild(input);
	}
	
	function createPdetail(reqType){

		const parentElem = document.querySelector('#'+reqType+'Li');
		
		const divReqContWrap = document.createElement('div');
		divReqContWrap.classList.add('reqContWrap');
		
		const h4 = document.createElement('h4');
		h4.textContent = '상세 내용을 입력해주세요.';
		
		const small = document.createElement('small');
		small.textContent = '(최대한 자세하게 적어주세요.)';
		
		const divFormWrap = document.createElement('div');
		divFormWrap.classList.add('formWrap');
		
		const form = document.createElement('form');
		form.action = 'reqUpdateContent.do';
		form.method = 'post';
		form.id = 'reqForm';
		
		const inputText = document.createElement('input');
		inputText.type = 'text';
		inputText.classList.add('input-textbox');
		inputText.placeholder = '내용을 입력해주세요.';
		
		parentElem.appendChild(divReqContWrap);
		divReqContWrap.appendChild(h4);
		divReqContWrap.appendChild(small);
		divReqContWrap.appendChild(divFormWrap);
		divFormWrap.appendChild(form);
		form.appendChild(inputText);
	}
	
	function createPphoto(reqType){

		const parentElem = document.querySelector('#'+reqType+'Li');
		
		const divReqContWrap = document.createElement('div');
		divReqContWrap.classList.add('reqContWrap');
		
		const h4 = document.createElement('h4');
		h4.textContent = '변경하고자 하는 사진을 올려주세요.';
		
		const small = document.createElement('small');
		small.textContent = '(장소의 특징이 잘 보이게 촬영해주세요.)';
		
		const divFormWrap = document.createElement('div');
		divFormWrap.classList.add('formWrap');
		
		const form = document.createElement('form');
		form.action = 'reqUpdateContent.do';
		form.method = 'post';
		form.id = 'reqForm';
		
		const label = document.createElement('label');
		label.htmlFor = 'upload';
		label.textContent = '사진 올리기';
		
		const input = document.createElement('input');
		input.type = 'file';
		input.name = 'upload';
		input.id = 'upload';
		input.style.display = 'none';
		
		parentElem.appendChild(divReqContWrap);
		divReqContWrap.appendChild(h4);
		divReqContWrap.appendChild(small);
		divReqContWrap.appendChild(divFormWrap);
		divFormWrap.appendChild(form);
		form.appendChild(label);
		form.appendChild(input);
	}
	
	function createPloc(reqType){

		const parentElem = document.querySelector('#'+reqType+'Li');
		
		const divReqContWrap = document.createElement('div');
		divReqContWrap.classList.add('reqContWrap');
		
		const h4 = document.createElement('h4');
		h4.textContent = '지도를 움직여 정확한 위치를 알려주세요.';
		
		const divFormWrap = document.createElement('div');
		divFormWrap.classList.add('formWrap');
		
		const divMap = document.createElement('div');
		divMap.id = 'map';
		
		const form = document.createElement('form');
		form.action = 'reqUpdateContent.do';
		form.method = 'post';
		form.id = 'reqForm';
		
		const inputRoad = document.createElement('input');
		inputRoad.type = 'text';
		inputRoad.classList.add('input-textbox');
		inputRoad.id = 'road';
		
		const inputAddress = document.createElement('input');
		inputAddress.type = 'text';
		inputAddress.classList.add('input-textbox');
		inputAddress.placeholder = '상세주소를 입력해주세요.';
		
		parentElem.appendChild(divReqContWrap);
		divReqContWrap.appendChild(h4);
		divReqContWrap.appendChild(divFormWrap);
		divFormWrap.appendChild(divMap);
		divFormWrap.appendChild(form);
		form.appendChild(inputRoad);
		form.appendChild(inputAddress);
		
	}