/**
 * 
 */

 document.addEventListener('DOMContentLoaded', () => {
	
	const modifyForm = document.querySelector('form#modifyForm');
	const inputTitle = document.querySelector('input#title');
	const textContent = document.querySelector('textarea#content');
	const updateMedia = document.querySelector('input#media');
	const btnUpdate = document.querySelector('button#btnUpdate');
	
	
	btnUpdate.addEventListener('click', () => {
		if(inputTitle.value === '' || textContent === '' || updateMedia === ''){
			alert('제목과 내용, 동영상 업데이트는 필수 입니다.');
			return;
		}
		
		const result = confirm('내용을 수정할까요?')
		if (result) {
			modifyForm.action='update';
			modifyForm.method='post';
			modifyForm.submit();
		}
		
	});
	
	
	
	
 });