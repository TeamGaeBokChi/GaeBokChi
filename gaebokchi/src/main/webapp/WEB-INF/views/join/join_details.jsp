<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약｜GOLFRO</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<link rel="stylesheet" href="../css/join_details.css" />

</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container">
		<div class="row justify-content-center mb-2">
			<div class="col-md-8">
				<div class="card border-0">

					<h2>
						<a href="/gaebokchi/join/join_main">JOIN</a>
					</h2>
					<h7>마음 맞는 사람과 함께 골프를 쳐보세요.</h7>

					<div
						class="card-header d-flex justify-content-between align-items-center mb-1"
						id="card-header">
						<h3>조인 모집 정보</h3>
						<div class="tag">
							<c:url var="previousPostUrl" value="/join/join_details">
								<c:param name="id"
									value="${previousPost != null ? previousPost.id : ''}" />
							</c:url>
							<a href="${previousPostUrl}"
								class="btn btn-link ${previousPost == null ? 'disabled' : ''}">
								<i class="bi bi-chevron-left"></i> 이전 글
							</a> |
							<c:url var="nextPostUrl" value="/join/join_details">
								<c:param name="id"
									value="${nextPost != null ? nextPost.id : ''}" />
							</c:url>
							<a href="${nextPostUrl}"
								class="btn btn-link ${nextPost == null ? 'disabled' : ''}">
								다음 글 <i class="bi bi-chevron-right"></i>
							</a>
						</div>
					</div>
					<div id="author">
						<h7>등록자</h7>
						<p>${userNicknames[post.author]}</p>
					</div>

					<div class="card-body">
						<div class="details">
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
								<p>${post.formattedTeeoff}</p>
							</div>
							<div class="details-item">
								<h5>그린피</h5>
								<p>${post.greenfee}원</p>
							</div>

							<div class="details-item">
								<h5>내용 및 연락처</h5>
								<p>${post.content}</p>
							</div>
						</div>
					</div>
					<c:if
						test="${post.author eq loggedInUser.userid or loggedInUser.userid eq 'admin'}">
						<div class="lastbtn d-flex justify-content-end mt-2 mb-3">
							<c:url var="joinModifyPage" value="/join/join_modify">
								<c:param name="id" value="${post.id}" />
							</c:url>
							<button class="m-2 btn"
								onclick="location.href='${joinModifyPage}'">수정하기</button>
							<button id="btnDelete"
								class="m-2 btn">삭제하기</button>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<c:url var="join_details_js" value="/js/join_details.js" />
	<script src="${join_details_js}"></script>
</body>
</html>
