/**
 *  mainPost/details 부여
 */

document.addEventListener('DOMContentLoaded', () => {
	getAllMainComments(); // 댓글 리스트업
	getAllLikes(); // 좋아요 수



	// 댓글 작성 스크립트
	const btnRegisterComment = document.querySelector('#btnRegisterComment');
	if (btnRegisterComment) {
		console.log('btnRegisterComment found:', btnRegisterComment); // 요소가 선택되었는지 확인
		btnRegisterComment.addEventListener('click', registerComment);
	} else {
		console.error('btnRegisterComment not found');
	}








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
	};


	function getAllMainComments() {
		const postId = document.querySelector('input#postId').value;
		const uri = `../api/mainComment/all/${postId}`;

		axios
			.get(uri)
			.then((response) => {
				// selection === 1인 요소들을 최상단으로 정렬하고, 나머지는 modifiedTime을 기준으로 정렬
				const sortedData = response.data.sort((a, b) => {
					if (a.selection === 1 && b.selection !== 1) {
						return -1; // a를 더 위로 올림
					} else if (a.selection !== 1 && b.selection === 1) {
						return 1; // b를 더 위로 올림
					} else {
						return b.modifiedTime - a.modifiedTime; // modifiedTime을 기준으로 내림차순 정렬
					}
				});

				console.log(sortedData);
				makeCommentElements(sortedData);

				if (response.data.some(comment => comment.selection === 1)) {
					hideAllSelectButtons();
				}

				const focusCommentId = document.querySelector('input#commentId').value;

				if (focusCommentId != null) { // null 및 undefined 모두 체크
					let commentElement = document.getElementById(`comment-${focusCommentId}`);
					console.log(commentElement);
					if (commentElement) { // 요소가 실제로 존재하는지 확인
						commentElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
					} else {
						return;
					}
				} else {
					console.error('focusCommentId is null or undefined.');
				}
			})
			.catch((error) => {
				console.log(error);
			});

	};


	// 댓글 목을 전달 받아 html 작성
	function makeCommentElements(data) {
		const divComments = document.querySelector('div.comments-section');
		let htmlString = '';

		if (data === '' || data.length === 0) {
			htmlString = `<p id="nullComment">아직 피드백이 작성되지 않은 게시물입니다.</p>`;
		} else {
			for (let mainComment of data) {
				let highlightClass = mainComment.selection === 1 ? 'highlight' : '';

				htmlString += `
	                <div class="comment ${highlightClass}" id="comment-${mainComment.id}">
	                    <div class="comment-thumb">
	                        <img id="image-${mainComment.id}" class="pofile-image" src="../user/file/image?file=${encodeURIComponent(mainComment.image)}" alt="Uploaded Image">
	                    </div>
						<div class="comment-content">
						    <strong>${mainComment.nickname}</strong>
						    <div class="comment-text" id="comment-text-${mainComment.id}">
						        <p class="commentId d-none"></p>
						        <p><span>${mainComment.content}</span></p>
						    </div>
						    <div class="edit-area" id="edit-area-${mainComment.id}" style="display: none;">
						        <textarea class="form-control" id="edit-textarea-${mainComment.id}">${mainComment.content}</textarea>
						        <button class="btn btn-primary mt-2 save-edit" data-id="${mainComment.id}">저장</button>
						        <button class="btn btn-secondary mt-2 cancel-edit" data-id="${mainComment.id}">취소</button>
						    </div>
						    
						    <!-- 채택 및 댓글 수정,삭제 스크립트 -->
						    <div class="button-container">
						        ${signedInUser === postAuthor ?
						`<button class="btn btn-outline-success selectComment" data-id="${mainComment.id}">채택</button>` :
						''}
						        ${signedInUser === mainComment.author ?
						`<button class="btn btn-outline-primary modifyComment" data-id="${mainComment.id}">수정</button>` :
						''}
						        ${signedInUser === mainComment.author ?
						`<button class="btn btn-outline-danger deleteComment" data-id="${mainComment.id}">삭제</button>` :
						''}
					
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

		const modifyButtons = document.querySelectorAll('.modifyComment');
		for (let btn of modifyButtons) {
			btn.addEventListener('click', modifyMainComment);
		}

	}



	function modifyMainComment(event) {
		const commentId = event.target.getAttribute('data-id');
		// 변경: 올바른 id 사용
		const commentTextElement = document.getElementById(`comment-text-${commentId}`);
		const editAreaElement = document.getElementById(`edit-area-${commentId}`);

		alert('댓글을 수정합니다.');

		// 원래의 댓글 텍스트를 숨기고 수정 영역을 보여줍니다.
		commentTextElement.style.display = 'none';
		editAreaElement.style.display = 'block';
	}

	// 저장 버튼 이벤트 리스너
	document.addEventListener('click', function(event) {
		if (event.target.classList.contains('.save-edit')) {
			const commentId = event.target.getAttribute('data-id');
			const editedContent = document.getElementById(`edit-textarea-${commentId}`).value;

			const uri = `../api/mainComment/edit/${commentId}`;
			// 여기에 서버로 수정된 내용을 보내는 AJAX 요청을 구현합니다.
			axios.put(uri, { content: editedContent })
				.then((response) => {
					console.log(response);
					document.querySelector(`#comment-text-${commentId} span`).textContent = editedContent;
					document.getElementById(`comment-text-${commentId}`).style.display = 'block';
					document.getElementById(`edit-area-${commentId}`).style.display = 'none';

					getAllMainComments();
				})
				.catch((error) => console.log(error));
		}

		/*
		// 수정된 내용을 화면에 반영합니다.
		document.querySelector(`#comment-text-${commentId} span`).textContent = editedContent;
		*/

	});



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
		const foot = document.querySelector('#foot');
		const modifyButton = document.querySelectorAll('.modifyComment');
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
		modifyButton.forEach(button => {
			button.style.display = 'none';
		});


		content.style.backgroundColor = '#e9e9e9';
		content.value = '채택이 완료 된 레슨입니다.';
		content.style.fontSize = '18px';
		content.readOnly = true;
		btnRegisterComment.style.display = 'none';
		content.style.textAlign = 'center';
		content.style.paddingTop = '51px';
		foot.style.display = 'none';

	}
















});