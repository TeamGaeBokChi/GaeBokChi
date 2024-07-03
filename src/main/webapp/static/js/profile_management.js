/**
 * /user/profile.jsp에 포함.
 */

document.addEventListener('DOMContentLoaded', () => {
	const userid = document.querySelector('input#userid');
	
	const btnEditNickname = document.querySelector('button#btnNicknameUpdate');
	btnEditNickname.addEventListener('click', viewEditNickname);
	
	const editNickname = document.querySelector('div#btnNicknameGroup');
	
	const btnCancelNickname = document.querySelector('button#btnCancelNickname');
	btnCancelNickname.addEventListener('click', cancelNicknameEvent);
	
	const btnEditIntroduce = document.querySelector('button#btnIntroduceMyself');
	btnEditIntroduce.addEventListener('click', viewEditIntroduce);
	
	const editIntroduce = document.querySelector('div#btnIntroduceGroup');
	
	const btnCancelIntroduce = document.querySelector('button#btnCancelIntroduce');
	btnCancelIntroduce.addEventListener('click', cancelIntroduceEvent);
	
	const userNickname = document.querySelector('input#nickname').value;
	const nickname = document.querySelector('input#nickname');
	
	const introduce = document.querySelector('input#introduce');
	
	const btnSaveNickname = document.querySelector('button#btnSaveNickname');
	btnSaveNickname.addEventListener('click', updateNickname);
	
	const btnSaveIntroduce = document.querySelector('button#btnSaveIntroduce');
	btnSaveIntroduce.addEventListener('click', updateIntroduce);
	
	function viewEditNickname() {
		editNickname.classList.remove('d-none');
		nickname.readOnly = false;
	}
	
	function viewEditIntroduce() {
		editIntroduce.classList.remove('d-none');
		introduce.readOnly = false;
	}
	
	function cancelNicknameEvent() {
		editNickname.classList.add('d-none');
		nickname.value = userNickname;
		nickname.readOnly = true;
	}
	
	function cancelIntroduceEvent() {
		editIntroduce.classList.add('d-none');
		introduce.value = ``;
		introduce.readOnly = true;
	}
	
	function updateNickname() {
		const uri = `./checkname?nickname=${nickname.value}`;

		axios.get(uri)
			.then((response) => {
				if (response.data === 'Y') {
					let result = confirm('사용할 수 있는 닉네임입니다.\n저장하시겠습니까?');
					if (result) {
						saveNickname();
					}
				} else {
					alert('사용할 수 없는 닉네임입니다.');
				}
			})
			.catch((error) => {
				console.log(error);
			});
	}
	
	function updateIntroduce() {
		
	}
	
	function saveNickname() {
		const uri = `./${userid}`;

		axios.put(uri, { nickname: nickname.value })
			.then(() => {
				resetInfo();
				alert(`good!`);
			})
			.catch((error) => {
				console.log(error);
			});
	}
	
	function resetInfo() {
		const uri = `./${userid}`;
		axios.get(uri)
			.then((response) => {
				console.log(response.data);
				nickname.value = response.data.userid;
				introduce.value = response.data.career;

				cancelNicknameEvent();
				cancelIntroduceEvent();
			})
			.catch((error) => {
				console.log(error);
			});
	}
});