<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>수정하기｜GOLFRO</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />

<link rel="stylesheet" href="../css/join_modify.css" />

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>



<body>

	<header>
		<%@ include file="../fragments/header.jspf"%>
	</header>
	
	<main class="container">

		<div class="card border-0">
			<div class="card-header border-0 form-control">
				<h2>모임 글 수정</h2>
			</div>
			
			
			<div class="card-body form-control border-0">
				<form id="modifyForm">
					<!-- action과 method 추가 -->
					<input type="hidden" name="id" value="${post.id}" />
					
					
					<div class="mt-2">
					<span>골프장</span>
						<input class="form-control" type="text" name="title"
							placeholder="골프장 입력" value="${post.title}" required autofocus />
					</div>
					<div class="mt-2">
					 <span>주소</span>
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
					<span>날짜</span>
						<input class="form-control" type="datetime-local" name="teeoff"
							placeholder="티오프" value="${post.teeoff}" required />
					</div>
					<div class="mt-2">
					<span>그린 피</span>
						<input class="form-control" type="number" name="greenfee"
							placeholder="그린 피 입력" value="${post.greenfee}" required />
					</div>
					<div class="mt-2">
					<span>홀수</span>
						<input class="form-control" type="number" name="hole"
							placeholder="홀수 입력" value="${post.hole}" required />
					</div>
					<div class="mt-2">
					<span>작성자 아이디</span>
						<input class="form-control" type="text" name="author"
							placeholder="작성자" value="${post.author}" readonly />
					</div>
					<div class="mt-2">
					 <span>상세 설명</span>
						<textarea class="form-control" rows="5" name="content"
							placeholder="내용 및 연락처 , 인원수 등 입력" required>${post.content}</textarea>
					</div>
					
					
					<!-- 하단 버튼 영 -->
					<div class="d-grid gap-2">
						<button id="btnUpdate" class="btn btn-outline-success"
							type="button">수정완료</button>
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
