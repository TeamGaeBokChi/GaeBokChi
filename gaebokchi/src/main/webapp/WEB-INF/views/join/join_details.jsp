<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>조인 예약</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
body {
	background-color: #ffffff;
	font-family: 'Noto Sans KR', sans-serif;
}

.container {
	max-width: 700px;
	margin: 0 auto;
	margin-top: 120px;
}

.details-header {
	background-color: #2A7E50;
	padding: 10px;
	border-bottom: 1px solid #dee2e6;
	border-top-left-radius: 12px;
	border-top-right-radius: 12px;
	color: white; /* 글씨 색깔을 흰색으로 변경 */
}

.details-header .btn-link {
	color: white; /* 버튼의 글씨 색깔을 흰색으로 변경 */
}

.details-content {
	background-color: #ffffff;
	padding: 20px;
	border-bottom: 1px solid #dee2e6;
	border-bottom-left-radius: 12px;
	border-bottom-right-radius: 12px;
}

.details-footer {
	padding: 10px;
	border-top: 1px solid #dee2e6;
}

.icon {
	font-size: 1.2rem;
	color: #888;
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

.details-item {
	margin-bottom: 0.5rem; /* 줄 간격을 좁히기 위해 조정 */
	padding-bottom: 0.5rem; /* 줄 간격을 좁히기 위해 조정 */
	border-bottom: 1px solid #dee2e6;
}
</style>
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container">
		<div
			class="details-header d-flex justify-content-between align-items-center">
			<h2>조인</h2>
			<div>
				<c:url var="previousPostUrl" value="/join/join_details">
					<c:param name="id"
						value="${previousPost != null ? previousPost.id : ''}" />
				</c:url>
				<a href="${previousPostUrl}"
					class="btn btn-link ${previousPost == null ? 'disabled' : ''}">
					<i class="bi bi-chevron-left"></i> 이전 글
				</a>
				<c:url var="nextPostUrl" value="/join/join_details">
					<c:param name="id" value="${nextPost != null ? nextPost.id : ''}" />
				</c:url>
				<a href="${nextPostUrl}"
					class="btn btn-link ${nextPost == null ? 'disabled' : ''}"> 다음
					글 <i class="bi bi-chevron-right"></i>
				</a>
			</div>
		</div>
		<div class="details-content">
			<input type="hidden" id="postId" value="${post.id}" />
			<div class="details-item">
				<h5>골프장</h5>
				<p>${post.title}</p>
			</div>
			<div class="details-item">
				<h5>주소</h5>
				<p>${post.gcadress}</p>
			</div>
			<div class="details-item">
				<h5>티오프</h5>
				<p>${post.teeoff}</p>
			</div>
			<div class="details-item">
				<h5>그린피</h5>
				<p>${post.greenfee}원</p>
			</div>
			<div class="details-item">
				<h5>등록자</h5>
				<p>${userNicknames[post.author]}</p>
			</div>
			<div class="details-item">
				<h5>내용 및 연락처</h5>
				<p>${post.content}</p>
			</div>
		</div>
		<c:if test="${loggedInUser.userid eq post.author}">
			<div class="d-flex justify-content-end mt-2">
				<c:url var="joinModifyPage" value="/join/join_modify">
					<c:param name="id" value="${post.id}" />
				</c:url>
				<button class="btn btn-outline-primary"
					onclick="location.href='${joinModifyPage}'">✏️수정</button>
				<button id="btnDelete"
					class="btn btn-outline-secondary btn-custom ms-2">🗑️삭제</button>
			</div>
		</c:if>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<c:url var="join_details_js" value="/js/join_details.js" />
	<script src="${join_details_js}"></script>
</body>
</html>
