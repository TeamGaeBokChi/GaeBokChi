<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
.post-container {
	display: flex;
	flex-wrap: wrap;
	margin-top: 20px;
}

.post-media {
	flex: 1;
	max-width: 50%;
}

.post-details {
	flex: 1;
	max-width: 50%;
	padding-left: 20px;
}

.comments-section {
	max-height: 400px;
	overflow-y: scroll;
	margin-bottom: 20px;
}

.comment-form {
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="post-container">
			<div class="post-media">
				<video controls width="100%">
					<source src="path/to/video.mp4" type="video/mp4">
					Your browser does not support the video tag.
				</video>
			</div>
			<div class="post-details">
				<div class="post-content">
					<p>여기에 게시글 본문이 들어갑니다.</p>
				</div>
				<div class="comments-section">
					<h4>댓글</h4>
					<div class="comment">
						<p>
							<strong>작성자:</strong> 댓글 내용
						</p>
					</div>
					<!-- 여기에 더 많은 댓글을 추가할 수 있습니다. -->
				</div>
				<div class="comment-form">
					<form action="submit_comment_url" method="post">
						<div class="form-group">
							<label for="comment">댓글 작성:</label>
							<textarea class="form-control" id="comment" name="comment"
								rows="3"></textarea>
						</div>
						<button type="submit" class="btn btn-primary">댓글 등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="comment ${highlightClass}" id="comment-${mainComment.id}">
		<div class="comment-thumb">
			<img id="image-${mainComment.id}" class="pofile-image"
				src="../user/file/image?file=${encodeURIComponent(mainComment.image)}"
				alt="Uploaded Image">
		</div>


		<div class="comment-content">
			<strong>${mainComment.nickname}</strong>
			<div class="comment-text">
				<p class="commentId d-none"></p>
				<p>
					<span>${mainComment.content}</span>
				</p>
			</div>
			
			<div class="button-container">${signedInUser === postAuthor ?
						`<button class="btn btn-outline-success selectComment" data-id="${mainComment.id}">채택</button>` : ''}
				${signedInUser === mainComment.author ?
						`<button class="btn btn-outline-primary modifyComment" data-id="${mainComment.id}">수정</button>` : ''}
				${signedInUser === mainComment.author ?
						`<button class="btn btn-outline-danger deleteComment" data-id="${mainComment.id}">삭제</button>` : ''}
			</div>
			
			<div class="edit-area" id="editMainConmment${mainComment.id}"
				style="display: none;">
				<textarea class="form-control" id="edit-textarea-${mainComment.id}">${mainComment.content}</textarea>
				<button class="btn btn-primary mt-2 save-edit"
					data-id="${mainComment.id}">저장</button>
				<button class="btn btn-secondary mt-2 cancel-edit"
					data-id="${mainComment.id}">취소</button>
			</div>
		</div>
	</div>










	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
