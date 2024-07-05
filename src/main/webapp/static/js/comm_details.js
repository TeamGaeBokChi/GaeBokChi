document.addEventListener('DOMContentLoaded', () => {
	const postIdElement = document.querySelector('input#postId');
	const btnDelete = document.querySelector('button#btnDelete');
	const btnLikes = document.querySelector('button#btnLikes');
	const likesCountElement = document.querySelector('#likesCount');
	const btnRegisterComment = document.querySelector('button#btnRegisterComment');
	const commentList = document.querySelector('.comment-list');

	btnDelete.addEventListener('click', () => {
		const postId = postIdElement.value;
		const result = confirm('게시물을 삭제하시겠습니까?');
		if (result) {
			fetch(`/gaebokchi/community/delete?id=${postId}`, {
				method: 'GET'
			})
				.then(response => {
					if (response.ok) {
						alert('게시물이 삭제되었습니다.');
						window.location.href = '/gaebokchi/community/comm_main';
					} else {
						throw new Error('게시물 삭제에 실패했습니다.');
					}
				})
				.catch(error => {
					console.error('Error:', error);
				});
		}
	});

	commentList.addEventListener('click', event => {
		if (event.target.id === 'btnDeleteComment') {
			const commentId = event.target.previousElementSibling.value;
			const result = confirm('댓글을 삭제하시겠습니까?');
			if (result) {
				fetch(`/gaebokchi/community/comments/${commentId}`, {
					method: 'DELETE'
				})
					.then(response => {
						if (response.ok) {
							alert('댓글이 삭제되었습니다.');
							event.target.closest('.comment').remove();
						} else {
							throw new Error('댓글 삭제에 실패했습니다.');
						}
					})
					.catch(error => {
						console.error('Error:', error);
					});
			}
		} else if (event.target.id === 'btnUpdateComment') {
			const commentDiv = event.target.closest('.comment');
			const commentId = commentDiv.querySelector('input[name="commentId"]').value;
			const commentContent = commentDiv.querySelector('p').textContent;

			event.target.disabled = true;

			const updateForm = document.createElement('form');
			updateForm.classList.add('update-form');
			updateForm.innerHTML = `
                <div class="input-group mb-3">
                    <textarea id="updatedContent" class="form-control" rows="2">${commentContent}</textarea>
                    <div class="input-group-append">
                        <button id="btnSubmitUpdate" class="btn btn-outline-secondary" type="button">수정 완료</button>
                        <button id="btnCancelUpdate" class="btn btn-outline-secondary ml-2" type="button">취소</button>
                    </div>
                </div>
            `;
			commentDiv.appendChild(updateForm);

			const btnCancelUpdate = updateForm.querySelector('#btnCancelUpdate');
			btnCancelUpdate.addEventListener('click', () => {
				updateForm.remove();
				event.target.disabled = false;
			});

			updateForm.querySelector('#btnSubmitUpdate').addEventListener('click', () => {
				const updatedContent = updateForm.querySelector('#updatedContent').value;
				const data = {
					id: commentId,
					content: updatedContent
				};

				fetch('/gaebokchi/community/comments', {
					method: 'PUT',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify(data)
				})
					.then(response => {
						if (response.ok) {
							alert('댓글이 수정되었습니다.');
							commentDiv.querySelector('p').textContent = updatedContent;
							updateForm.remove();
							event.target.disabled = false;
						} else {
							throw new Error('댓글 수정에 실패했습니다.');
						}
					})
					.catch(error => {
						console.error('Error:', error);
					});
			});
		}
	});

	btnLikes.addEventListener('click', () => {
		const postId = postIdElement.value;
		fetch('/gaebokchi/community/increaseLikes', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			},
			body: new URLSearchParams({ 'id': postId })
		})
			.then(response => {
				if (response.ok) {
					return response.json();
				} else {
					throw new Error('Failed to increase likes');
				}
			})
			.then(data => {
				likesCountElement.textContent = data.likes;
			})
			.catch(error => {
				console.error('Error:', error);
			});
	});

	btnRegisterComment.addEventListener('click', event => {
		event.preventDefault();

		const postId = postIdElement.value;
		const author = document.querySelector('input[name="author"]').value;
		const content = document.querySelector('textarea[name="content"]').value;

		if (author.trim() === '' || content.trim() === '') {
			alert('댓글 내용과 작성자를 모두 입력하세요.');
			return;
		}

		const data = {
			postId: postId,
			author: author,
			content: content
		};

		fetch('/gaebokchi/community/comments', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(data)
		})
			.then(response => {
				if (response.ok) {
					return response.json();
				} else {
					throw new Error('댓글 등록에 실패했습니다.');
				}
			})
			.then(newComment => {
				console.log('New Comment:', newComment); // 서버 응답 데이터 확인
				displayComment(newComment); // 댓글 표시
				alert('댓글이 등록되었습니다.');
				document.querySelector('input[name="author"]').value = '';
				document.querySelector('textarea[name="content"]').value = '';
				location.reload(); // 페이지 새로고침
			})
			.catch(error => {
				console.error('Error:', error);
			});
	});


	function displayComment(comment) {
		const commentDiv = document.createElement('div');
		commentDiv.classList.add('comment');
		commentDiv.innerHTML = `
        <b>${comment.author}</b>
        <p>${comment.content}</p>
        <small>${comment.modifiedTime ? new Date(comment.modifiedTime).toLocaleString() : '시간 없음'}</small>
        <input type="hidden" name="commentId" value="${comment.id}">
        <button class="btn btn-success btn-register-comment" id="btnUpdateComment">수정</button>
        <button class="btn btn-danger btn-register-comment" id="btnDeleteComment">삭제</button>
    `;
		commentList.appendChild(commentDiv);
	}
});
