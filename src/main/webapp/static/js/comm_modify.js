document.addEventListener('DOMContentLoaded', () => {
    const modifyForm = document.querySelector('form#modifyForm');
    const inputId = document.querySelector('input[name=id]');
    const inputTitle = document.querySelector('input[name=title]');
    const inputCategory = document.querySelector('select[name=category]');
    const textContent = document.querySelector('textarea[name=content]');
    const btnUpdate = document.querySelector('button#btnUpdate');
    
    // 업데이트 버튼의 클릭 이벤트 리스너:
    btnUpdate.addEventListener('click', () => {
        // 제목과 내용이 비어있는 지 체크:
        if (inputTitle.value === '') {
            alert('제목을 입력하세요');
            return;
        }
        if (quill.root.innerHTML === '<p><br></p>') {
			alert('내용을 입력하세요');
			return;
		}
		 if (inputCategory.value === '') {
			alert('저장할 탭을 선택하세요');
			return;
		}

        // 업데이트 내용 저장 확인:
        const result = confirm('변경 내용을 저장할까요?');
        if (result) {
            // Quill의 내용이 textarea에 반영되도록 함
            textContent.value = quill.root.innerHTML;
            modifyForm.action = 'update'; // 요청 주소
            modifyForm.method = 'POST'; // 요청 방식
            modifyForm.submit(); // 폼 양식 데이터 제출(서버로 요청 보냄).
        }
    });
});