document.addEventListener('DOMContentLoaded', () => {
	const postIdElement = document.querySelector('input#postId');
	const btnDelete = document.querySelector('button#btnDelete');
	const btnLikes = document.querySelector('button#btnLikes');
	const likesCountElement = document.querySelector('#likesCount'); // 좋아요 수를 표시하는 엘리먼트
	const btnRegisterComment = document.querySelector('button#btnRegisterComment');
	const commentList = document.querySelector('.comment-list'); // 댓글 목록을 표시하는 엘리먼트

	 btnDelete.addEventListener('click', () => {
        const postId = postIdElement.value;
        const result = confirm('게시물을 삭제하시겠습니까?');
        if (result) {
            fetch(`/gaebokchi/review/delete?id=${postId}`, {
                method: 'GET'
            })
                .then(response => {
                    if (response.ok) {
                        alert('게시물이 삭제되었습니다.');
                        // 삭제 후 리다이렉트 또는 필요한 추가 동작 수행
                        window.location.href = '/gaebokchi/review/review_main'; // 예시: 삭제 후 목록 페이지로 리다이렉트
                    } else {
                        throw new Error('게시물 삭제에 실패했습니다.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    });


	// 확인용 콘솔 로그
	console.log(postIdElement, btnDelete, btnLikes, likesCountElement, btnRegisterComment, commentList);

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
		}
	});

	// 댓글 수정 기능
	commentList.addEventListener('click', event => {
		if (event.target.id === 'btnUpdateComment') {
			const commentDiv = event.target.closest('.comment');
			const commentId = commentDiv.querySelector('input[name="commentId"]').value;
			const commentContent = commentDiv.querySelector('p').textContent;

			const updateForm = document.createElement('form');
			updateForm.innerHTML = `
                <div class="input-group mb-3">
                    <textarea id="updatedContent" class="form-control" rows="2">${commentContent}</textarea>
                    <div class="input-group-append">
                        <button id="btnSubmitUpdate" class="btn btn-outline-secondary" type="button">수정 완료</button>
                    </div>
                </div>
            `;
			commentDiv.appendChild(updateForm);

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

	// 좋아요 버튼 클릭 이벤트 리스너
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
					return response.json(); // 서버에서 JSON 응답을 받도록 처리
				} else {
					throw new Error('Failed to increase likes');
				}
			})
			.then(data => {
				likesCountElement.textContent = data.likes; // 서버에서 받은 새로운 좋아요 수로 업데이트
			})
			.catch(error => {
				console.error('Error:', error);
			});
	});

	// 댓글 등록 버튼 클릭 이벤트 리스너
	btnRegisterComment.addEventListener('click', event => {
		event.preventDefault(); // 기본 동작 방지

		// 댓글이 달릴 포스트 번호를 가져옴
		const postId = postIdElement.value;

		// 댓글 내용과 작성자를 가져옴
		const author = document.querySelector('input[name="author"]').value;
		const content = document.querySelector('textarea[name="content"]').value;

		// 댓글 내용과 작성자가 비어 있는지 확인
		if (author.trim() === '' || content.trim() === '') {
			alert('댓글 내용과 작성자를 모두 입력하세요.');
			return;
		}

		// 서버로 보낼 데이터 객체 생성
		const data = {
			postId: postId,
			author: author,
			content: content
		};

		// 서버에 댓글 등록 요청 보냄
		fetch('/gaebokchi/community/comments', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(data)
		})
			.then(response => {
				if (response.ok) {
					return response.json(); // JSON 형태로 응답 받기
				} else {
					throw new Error('댓글 등록에 실패했습니다.');
				}
			})
			.then(newComment => {
				// 성공적으로 댓글이 등록되면 화면에 추가
				displayComment(newComment);
				alert('댓글이 등록되었습니다.');
				// 입력 필드 초기화
				document.querySelector('input[name="author"]').value = '';
				document.querySelector('textarea[name="content"]').value = '';
			})
			.catch(error => {
				console.error('Error:', error);
			});
	});

	// 새로운 댓글을 화면에 추가하는 함수
	function displayComment(comment) {
		const commentDiv = document.createElement('div');
		commentDiv.classList.add('comment');
		commentDiv.innerHTML = `
            <b>${comment.author}</b>
            <p>${comment.content}</p>
            <small>${comment.modifiedTime}</small>
            <button class="btn-delete-comment" data-comment-id="${comment.id}">삭제</button>
            <button class="btn-update-comment" data-comment-id="${comment.id}">수정</button>
        `;
		commentList.appendChild(commentDiv);
	}
});
