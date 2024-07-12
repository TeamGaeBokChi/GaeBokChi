/**
 * /user/profile.jsp에 포함
 */

document.addEventListener('DOMContentLoaded', () => {
	const grade = document.querySelector('input#grade').value;

	const btnEditIntroduce = document.querySelector('button#btnIntroduceMyself');
	btnEditIntroduce.addEventListener('click', viewEditIntroduce);

	const editIntroduce = document.querySelector('div#btnIntroduceGroup');

	const btnCancelIntroduce = document.querySelector('button#btnCancelIntroduce');
	btnCancelIntroduce.addEventListener('click', cancelIntroduceEvent);

	let userIntroduce = document.querySelector('input#introduce').value;
	const introduce = document.querySelector('input#introduce');

	const btnSaveIntroduce = document.querySelector('button#btnSaveIntroduce');
	btnSaveIntroduce.addEventListener('click', updateIntroduce);

	function viewEditIntroduce() {
		editIntroduce.classList.remove('d-none');
		introduce.readOnly = false;
	}

	function cancelIntroduceEvent() {
		editIntroduce.classList.add('d-none');
		introduce.value = userIntroduce;
		introduce.readOnly = true;
	}

	function updateIntroduce() {
		const uri = `./professional`;
		axios.put(uri, {
			career: introduce.value,
			grade: grade
		})
			.then((response) => {
				console.log(response.data);
				introduce.value = response.data.career;
				userIntroduce = response.data.career;

				editIntroduce.classList.add('d-none');
				introduce.readOnly = true;
			})
			.catch((error) => {
				console.log(error);
			});
	}
});