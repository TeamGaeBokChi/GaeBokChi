/**
 *  mainPost/details 부여
 */

console.log('comments JS 실행중');

document.addEventListener('DOMContentLoaded', () => {
	getAllMainComments(); // 댓글 리스트업
	getAllLikes(); // 좋아요 수









	const btnRegisterComment = document.querySelector('button#btnRegisterComment');
	btnRegisterComment.addEventListener('click', registerComment);


	const btnLikes = document.querySelector('button#likes');
	btnLikes.addEventListener('click', () => {
		const postId = document.querySelector('input#postId').value;
		const uri = `../mainPost/likes/${postId}`;

		axios.put(uri)
			.then((response) => {
				console.log(response);
				alert('해당 게시물 추천을 하였습니다.');
				getAllLikes();
			})
			.catch((error) => console.log(error));
	});


	function getAllLikes() {
		const postId = document.querySelector('input#postId').value;
		const uri = `../mainPost/likes/${postId}`;

		axios.get(uri)
			.then((response) => {
				console.log(response);
				makeLikesElements(response.data);
			})
			.catch((error) => console.log(error))
	}



	function makeLikesElements(data) {
		const likesCounts = document.querySelector('p#likesCounts');
		likesCounts.textContent = `: ${data}`;
	}






	/* 댓글 작성 함수 */
	function registerComment() {
		const postId = document.querySelector('input#postId').value;
		const content = document.querySelector('textarea#content').value;
		const author = document.querySelector('input#author').value;

		if (content === '' || author === '') {
			alert('피드백 내용 및 작성자는 필수 입력값입니다.')
			return;
		}

		// Ajax 요청에서 보낼 데이터 객체 생성
		const data = { postId, content, author };
		console.log(data);

		axios
			.post('../api/mainComment', data)
			.then((response) => {
				console.log(response);
				if (response.data === 1) {
					alert('피드백 작성완료, 채택을 기다려주세요.');
					document.querySelector('textarea#content').value = '';
					document.querySelector('input#author').value = '';
					//전체 댓글 갱신 함수넣기	
					getAllMainComments();
				}
			})
			.catch((error) => {
				console.log(error);
			});
	}

	function getAllMainComments() {
		const postId = document.querySelector('input#postId').value;
		const uri = `../api/mainComment/all/${postId}`;

		axios
			.get(uri)
			.then((response) => {
				console.log(response);
				makeCommentElements(response.data);
				if (response.data.some(comment => comment.selection === 1)) {
					hideAllSelectButtons();
				}
			})
			.catch((error) => {
				console.log(error);
			});

	}


	// 댓글 목을 전달 받아 html 작성
	function makeCommentElements(data) {
	    const divComments = document.querySelector('div.comments-section');
	    let htmlString = '';

	    if (data === '' || data.length === 0) {
	        htmlString = `<p id="nullComment">아직 피드백이 작성되지 않은 게시물입니다.</p>`;
	    } else {
	        for (let mainComment of data) {
	            let highlightClass = mainComment.selection === 1 ? 'highlight' : '';

	            // 이미지 로드 코드를 별도의 함수로 분리
	            let imageLoadingScript = `
	                <script>
	                    var file = '${mainComment.image}';
	                    var imageUrl = './file/image?file=' + encodeURIComponent(file);
	                    fetch(imageUrl)
	                        .then(response => response.blob())
	                        .then(blob => {
	                            var reader = new FileReader();
	                            reader.onload = function() {
	                                document.getElementById('image-${mainComment.id}').src = reader.result;
	                            };
	                            reader.readAsDataURL(blob);
	                        })
	                        .catch(error => {
	                            console.error('Error fetching image:', error);
	                        });
	                </script>
	            `;

	            htmlString += `
	                <div class="comment ${highlightClass}" id="comment-${mainComment.id}">
	                    <div class="comment-thumb">
	                        <img id="image-${mainComment.id}" src="" alt="Uploaded Image">
	                        ${imageLoadingScript} <!-- 이미지 로드 스크립트 추가 -->
	                    </div>
	                    <div class="comment-content">
	                        <strong>${mainComment.nickname}</strong>
	                        <div class="comment-text">
	                            <p class="commentId d-none"></p>
	                            <p><span>${mainComment.content}</span></p>
	                        </div>
	                        <div class="button-container"> 
	                            <button class="btn btn-outline-success selectComment" data-id="${mainComment.id}"> 채택하기 </button>
	                            <button class="btn btn-outline-danger deleteComment" data-id="${mainComment.id}"> 삭제하기 </button>
	                        </div>
	                    </div>
	                </div>
	            `;
	        }
	    }
	    divComments.innerHTML = htmlString;

		const selectComment = document.querySelectorAll('.selectComment');
		for (let selectButton of selectComment) {
			selectButton.addEventListener('click', selectComments);
		}
		const deleteButtons = document.querySelectorAll('.deleteComment');
		for (let btn of deleteButtons) {
			btn.addEventListener('click', deleteComments)
		}

	}


	function deleteComments(event) {
		console.log(event.target);
		const commentsId = event.target.getAttribute('data-id');
		const result = confirm('해당 피드백을 삭제하시겠습니까?');
		if (!result) return;

		const uri = `../api/mainComment/delete/${commentsId}`;
		axios.delete(uri)
			.then((response) => {
				console.log(response.data);
				if (response.data === 1) {
					alert('해당 피드백이 삭제되었습니다.');
					getAllMainComments();
				}
			})
			.catch((error) => console.log(error));
	}


	function selectComments(event) {
		console.log(event.target);
		const commentsId = event.target.getAttribute('data-id');
		const result = confirm('해당 피드백을 체택하시겠습니다? (채택 시 수정이 불가능하며 채택은 번복 할 수 없습니다.)');
		if (!result) {
			return;
		}

		const uri = `../api/mainComment/selectComment/${commentsId}`;

		axios.put(uri)
			.then((response) => {
				console.log(response.data);
				alert('해당 게시물의 채택이 완료되었습니다.');
				getAllMainComments();
				alert('피드백을 작성해준 멘토에게 포인트가 지급되었습니다.');
			})
			.catch((error) => console.log(error));
	}

	function hideAllSelectButtons() {
		const selectButton = document.querySelectorAll('.selectComment');
		const deleteButton = document.querySelectorAll('.deleteComment');
		const content = document.querySelector('#content');
		const btnRegisterComment = document.querySelector('#btnRegisterComment');

		selectButton.forEach(button => {
			button.style.display = 'none';
		});
		deleteButton.forEach(button => {
			button.style.display = 'none';
		});
		content.style.backgroundColor = '#e9e9e9';
		content.value = '채택이 완료 된 레슨입니다.';
		content.style.fontSize = '18px';
		content.readOnly = true;
		btnRegisterComment.style.display = 'none';
		content.style.textAlign = 'center';
		content.style.paddingTop = '51px';
	}









});