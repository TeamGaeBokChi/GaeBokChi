<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>조인 변경</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />
<style>
body {
	background-color: #ffffff;
	font-family: 'Noto Sans KR', sans-serif;
}

.container {
	max-width: 1000px;
	margin-top: 30px;
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
	border-radius: 15px;
	padding: 20px;
	margin-bottom: 20px;
}

.btn-like {
	background-color: #ff6b6b;
	border: none;
	transition: all 0.3s ease;
}

.btn-like:hover {
	background-color: #ff4757;
	transform: scale(1.05);
}

.comment-form {
	margin-bottom: 20px;
}

.comment-list {
	max-height: 300px;
	overflow-y: auto;
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
</style>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>
<body>
	<main class="container">
		<div class="mt-2 card">
			<div class="card-header">
				<h2>조인 변경</h2>
			</div>
			<div class="card-body">
				<form id="modifyForm"> <!-- action과 method 추가 -->
					<input type="hidden" name="id" value="${post.id}" />
					<div class="mt-2">
						<input class="form-control" type="text" name="title"
							placeholder="골프장 입력" value="${post.title}" required autofocus />
					</div>
					<div class="mt-2">
						<div class="input-group">
							<input id="address" class="form-control" type="text"
								name="gcadress" placeholder="주소 입력" value="${post.gcadress}"
								required />
							<button type="button" class="btn btn-outline-secondary"
								onclick="execDaumPostcode()">주소 검색</button>
						</div>
						<div>
							<input type="hidden" name="category" value="P003" /> <input
								type="hidden" name="clubtype" value="DR" />
						</div>
					</div>
					<div class="mt-2">
						<input class="form-control" type="datetime-local" name="teeoff"
							placeholder="티오프" value="${post.teeoff}" required />
					</div>
					<div class="mt-2">
						<input class="form-control" type="number" name="greenfee"
							placeholder="그린 피 입력" value="${post.greenfee}" required />
					</div>
					<div class="mt-2">
						<input class="form-control" type="number" name="hole"
							placeholder="홀수 입력" value="${post.hole}" required />
					</div>
					<div class="mt-2">
						<input class="form-control" type="text" name="author"
							placeholder="작성자" value="${post.author}" readonly />
					</div>
					<div class="mt-2">
						<textarea class="form-control" rows="5" name="content"
							placeholder="내용 및 연락처 , 인원수 등 입력" required>${post.content}</textarea>
					</div>
					<div class="d-grid gap-2">
						<button id="btnUpdate" class="btn btn-outline-success"
							type="button">업데이트</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<c:url var="join_modify_js" value="/js/join_modify.js" />
    <script src="${join_modify_js}"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
