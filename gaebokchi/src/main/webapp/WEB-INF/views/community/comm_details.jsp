<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>게시물 상세보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
body {
	background-color: #ffffff;
	font-family: 'Noto Sans KR', sans-serif;
	min-height: 1200px;
}

.card {
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #ffffff;
}

.card-header {
	background-color: #2A7E50;
	color: white;
	border-top-left-radius: 15px;
	border-top-right-radius: 15px;
}

.card-title {
	margin-bottom: 0;
}

.post-info {
	font-size: 0.9rem;
	color: #6c757d;
}

.post-content {
	background-color: #f8f9fa;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 20px;
}

.btn-like {
	background-color: #ff6b6b;
	border: none;
	color: white;
	transition: transform 0.3s ease, background-color 0.3s ease;
}

.btn-like:hover {
	background-color: #ff6b6b;
	color: white;
}

.comment-form {
	margin-bottom: 20px;
}

.comment-list {
	min-height: 600px;
	overflow-y: auto;
	max-height: 1000px;
}

.comment {
	border-bottom: 1px solid #dee2e6;
	padding: 10px 0;
}

.comment:last-child {
	border-bottom: none;
}

.btn-custom {
	height: 50px;
	padding: 10px 20px;
}

.position-relative {
	position: relative;
}

.center-btn {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}

/* 추가된 스타일 */
.comment-form .input-group {
	align-items: center;
}

.comment-form textarea {
	margin-bottom: 0; /* 기본 마진 제거 */
}

.comment-form .btn-register-comment {
	height: 50px; /* 버튼 높이 조정 */
	padding: 10px 20px; /* 버튼 안쪽 여백 조정 */
	margin-left: 10px; /* 좌측 여백 설정 */
}

.image-container {
	max-width: 100%; /* 최대 너비 설정 */
	max-height: 100%; /* 최대 높이 설정 */
	overflow: hidden; /* 넘치는 부분 숨기기 */
	margin-bottom: 20px; /* 하단 여백 설정 */
}

.container-fluid {
	border-radius: 10px;
	padding: 20px;
	max-width: 1200px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: 0 auto;
	margin-top: 85px;
}

.img-fluid {
	max-width: 100%; /* 이미지 너비 최대 100%로 설정 */
	height: auto; /* 높이 자동으로 조정 */
	display: block; /* 인라인 요소를 블록 요소로 변환 */
}
</style>
</head>
<body>
	<div class="container-fluid">
		<header>
			<%@ include file="../fragments/header.jspf"%>
		</header>
		<div class="card">
			<div class="card-header">
				<input type="hidden" id="postId" value="${post.id}" />
				<h2 class="card-title">${post.title}</h2>
				<small class="text-black">${categoryMap[post.category]} -
					${post.createdTime}</small>
			</div>
			<div class="card-body">
				<div class="post-info d-flex justify-content-between mb-3">
					<span><i class="bi bi-person"></i>${userNicknames[post.author]}</span> <span><i
						class="bi bi-eye"></i> ${post.views}</span> <span><i
						class="bi bi-hand-thumbs-up"></i> <span id="likesCount">${post.likes}</span></span>
					<span><i class="bi bi-chat-dots"></i> ${commentcount}</span>
				</div>
				<div class="post-content">
					<c:if test="${not empty post.media}">
						<div class="image-container">
							<c:url var="mediaUrl" value="/community/media/${post.media}" />
							<img alt="" src="${mediaUrl}" class="img-fluid max-size">
						</div>
					</c:if>
					<div>${post.content}</div>
				</div>
				<c:if test="${post.author ne loggedInUser.userid}">
					<div class="position-relative mb-4 text-center">
						<c:choose>
							<c:when test="${not empty loggedInUser}">
								<!-- 로그인한 사용자가 있을 때의 버튼 -->
								<button id="btnLikes" class="btn btn-like btn-lg btn-custom">
									<i class="bi bi-heart-fill"></i>
								</button>
							</c:when>
							<c:otherwise>
								<!-- 로그인한 사용자가 없을 때의 처리 -->
								<button id="btnLikes-notloggedIn" class="btn btn-like btn-lg btn-custom">
									<i class="bi bi-heart-fill"></i>
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</c:if>
				<div class="d-flex justify-content-end mt-2">
					<c:url var="postModifyPage" value="/community/comm_modify">
						<c:param name="id" value="${post.id}" />
					</c:url>
					<c:if test="${post.author eq loggedInUser.userid}">
						<form action="${postModifyPage}" method="get"
							style="display: inline;">
							<input type="hidden" name="id" value="${post.id}" />
							<button type="submit"
								class="btn btn-outline-primary btn-custom ms-2">✏️수정</button>
						</form>
						<input type="hidden" name="postId" value="${post.id}" />
						<button id="btnDelete"
							class="btn btn-outline-danger btn-custom ms-2">🗑️삭제</button>
					</c:if>
				</div>
				<div class="d-flex justify-content-between mb-4">
					<c:url var="previousPostUrl" value="/community/comm_details">
						<c:param name="id"
							value="${previousPost != null ? previousPost.id : ''}" />
					</c:url>
					<a href="${previousPostUrl}"
						class="btn btn-outline-secondary ${previousPost == null ? 'disabled' : ''}">
						<i class="bi bi-chevron-left"></i> 이전 글
					</a>
					<c:url var="listUrl" value="comm_main" />
					<a href="${listUrl}" class="btn btn-outline-secondary"><i
						class="bi bi-list"></i> 목록으로</a>
					<c:url var="nextPostUrl" value="/community/comm_details">
						<c:param name="id" value="${nextPost != null ? nextPost.id : ''}" />
					</c:url>
					<a href="${nextPostUrl}"
						class="btn btn-outline-secondary ${nextPost == null ? 'disabled' : ''}">
						다음 글 <i class="bi bi-chevron-right"></i>
					</a>
				</div>
				<c:if test="${not empty loggedInUser}">
					<form class="comment-form">
						<div class="input-group mb-3">
							<div class="col-2">
								<input name="author" type="hidden" class="form-control"
									value="${loggedInUser.userid}">
							</div>
							<div class="col-8">
								<textarea name="content" id="content" class="form-control"
									rows="2" placeholder="댓글을 입력하세요"></textarea>
							</div>
							<div class="col-2">
								<input type="hidden" name="postId" value="${post.id}">
								<button id="btnRegisterComment"
									class="btn btn-success btn-register-comment" type="submit">등록</button>
							</div>
						</div>
					</form>
				</c:if>
				<div class="comment-list">
					<c:forEach var="comment" items="${commentlist}">
						<div class="comment">
							<b>${userNicknames[comment.author]}</b>
							<p>${comment.content}</p>
							<div>
								<small class="text-muted">${comment.modifiedTime}</small> <input
									type="hidden" name="commentId" value="${comment.id}">
								<c:if test="${comment.author eq loggedInUser.userid}">
									<button id="btnUpdateComment"
										class="btn btn-success btn-register-comment" type="submit">수정</button>
									<input type="hidden" name="commentId" value="${comment.id}">
									<button id="btnDeleteComment"
										class="btn btn-success btn-register-comment" type="submit">삭제</button>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<c:url var="comm_details_js" value="/js/comm_details.js" />
	<script src="${comm_details_js}"></script>
</body>
</html>
