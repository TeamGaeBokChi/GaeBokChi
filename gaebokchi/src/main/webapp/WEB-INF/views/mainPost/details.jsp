<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<style type="text/css">
.container {
	width: 1080px;
	margin: 0 auto;
	margin-top: 30px;
}
</style>
<title>Golfro</title>
<c:url var="details" value="../css/details.css" />
<link rel="stylesheet" type="text/css" href="${details}">
</head>
<body>
	<%
	Object signedInUser = session.getAttribute("signedInUser");
	System.out.println("SignedInUser: " + signedInUser);
	%>
	<header>
		<c:set var="pageTitle" value="새글 작성하기" />
		<%@ include file="../fragments/header.jspf"%>
	</header>
	<main>
		<div class="container">
			<div>

				<!-- 상단 제목 부분 -->
				<div>
					<div>
						<span class="club"> 클럽종류 : ${post.clubType}</span>
					</div>
					<div>
						<span id="detailsTitle">${post.title}</span>
					</div>
					<div class="sub">
						<span> ${post.nickname}</span> <span>   ${post.createdTime}</span>

						<div class="views-likes-container">
							<p id="views" class="views">조회수: ${post.views}</p>
							<button id="likes" class="likes bi bi-heart-fill"></button>
							<p id="likesCounts">: ${post.likes}</p>
						</div>
					</div>
				</div>


				<div class="mainTextArea">
					<div class="left">
						<video class="video-container" autoplay controls>
							<c:url var="videoUrl" value="/mainPost/video">
								<c:param name="file" value="${post.media}" />
							</c:url>
							<source src="${videoUrl}" type="video/mp4">
							<source src="${videoUrl}" type="video/mov">
							<source src="${videoUrl}" type="video/wmv">
							<source src="${videoUrl}" type="video/avi">
							<source src="${videoUrl}" type="video/mkv">
						</video>
					</div>
					<div class="right card form-control card">
						<div class="post-content">
							<p>${post.content}</p>
							<div>
								<c:choose>
									<c:when test="${empty post.height}">
										<span>키: 데이터 없음 /</span>
									</c:when>
									<c:otherwise>
										<span>키: ${post.height}cm /</span>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${empty post.career}">
										<span>구력: 데이터 없음 /</span>
									</c:when>
									<c:otherwise>
										<span>구력: ${post.career}년 /</span>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${empty post.handy}">
										<span>헨디: 데이터 없음 /</span>
									</c:when>
									<c:otherwise>
										<span>헨디: ${post.handy} /</span>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${empty post.ironDistance}">
										<span>아이언 평균 거리: 데이터 없음 /</span>
									</c:when>
									<c:otherwise>
										<span>아이언 평균 거리: ${post.ironDistance}m /</span>
									</c:otherwise>
								</c:choose>

								<c:choose>
									<c:when test="${empty post.driverDistance}">
										<span>드라이버 평균 거리: 데이터 없음</span>
									</c:when>
									<c:otherwise>
										<span>드라이버 평균 거리: ${post.driverDistance}m</span>
									</c:otherwise>
								</c:choose>

							</div>
						</div>

						<!-- 포커싱할 댓글 id -->
						<input type="hidden" id="commentId" value="${commentId}" />
						<!-- 댓글 리스트 영역 -->
						<div class="comments-section form-control"></div>
						<!-- 댓글작성 영역 -->
						<div class="commen-form card-footer form-control mt-">
							<!-- <form action="submit_comment_url" method="post"> -->
							<div class="form-group">
								<input class="d-none" id="postId" value="${post.id}" />
								<textarea class="form-control" id="content" name="ctext"
									rows="3" required placeholder="피드백을 작성해주세요."></textarea>
								<input class="form-control mt-2" type="text" id="author"
									placeholder="댓글 작성자" required />
								<button id="btnRegisterComment"
									class="btn btn-primary mt-3 form-control">피드백 작성하기</button>
							</div>

						</div>
						<!-- 하단 수정하기, 삭제 버튼 영역 -->

						<c:if test="${signedInUser eq post.author}">
						<div class="mt-2 d-flex justify-content-end" id="sunman">
							<!-- 수정 -->
							<div>
								<c:url var="mainPostModifyPage" value="/mainPost/modify">
									<c:param name="id" value="${post.id}" />
								</c:url>
								<a id="btnModifyid" class="btn btn-outline-primary"
									href="${mainPostModifyPage}">수정하기</a>
							</div>
							<!-- 삭제 -->
							<button id="btnDeleteMainPost" class="btn btn-outline-danger">삭제</button>
						</div>
						</c:if>

					</div>
				</div>
			</div>
		</div>
	</main>




	<!-- 부트스트랩 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>


	<c:url var="commentsJS" value="/js/comments.js" />
	<script src="${ commentsJS }"></script>


</body>
</html>