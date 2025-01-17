/**
 * /user/main.jsp에 포함.
 */

document.addEventListener('DOMContentLoaded', () => {
	const modal = document.querySelector('.modal');
	
	const modalOpen = document.querySelector("button#viewGainPoints");
	modalOpen.addEventListener('click', function() {
		//'on' class 추가
		modal.classList.add('on');
	});

	const modalClose = document.querySelector(".close_btn");
	//닫기 버튼을 눌렀을 때 모달팝업이 닫힘
	modalClose.addEventListener('click', function() {
		//'on' class 제거
		modal.classList.remove('on');
	});
});