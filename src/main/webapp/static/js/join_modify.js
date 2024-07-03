document.addEventListener('DOMContentLoaded', function() {
	    const modifyForm = document.querySelector('form#modifyForm');
	    const btnUpdate = document.querySelector('button#btnUpdate');

	document.getElementById('btnUpdate').addEventListener('click', function() {
		const result = confirm('변경 내용을 저장할까요?');
		if (result) {
			const modifyForm = document.getElementById('modifyForm'); // 폼 ID 수정된 부분
			modifyForm.action = 'update'; // 요청 주소
			modifyForm.method = 'POST'; // 요청 방식
			modifyForm.submit(); // 폼 양식 데이터 제출(서버로 요청 보냄).
		}
	});

	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
				var addr = data.address;
				document.getElementById('address').value = addr;
			}
		}).open();
	}

});

