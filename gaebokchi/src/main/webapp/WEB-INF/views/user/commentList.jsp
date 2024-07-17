<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8" />

<meta name="viewport" content="width=device-width, initial-scale=1" />

<title>댓글목록｜GOLFRO</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">



<style type="text/css">
.container {
	font-family: 'Pretendard-Regular';
	width: 1080px;
	margin: 0 auto;
	margin-top: 100px;
}

#mypage {
	margin-top: 150px;
	max-width: 1280px;
	padding: 40px 40px 160px;
}

#login-info {
	background-color: white;
	padding: 0;
	border: none;
}

.card-header {
	background: white;
}

.card-header h3 {
	font-family: 'Pretendard-Regular', Pretendard-Regular;
	font-weight: bold;
	padding-bottom: 15px;
	border-bottom: 3px solid #000000;
}

tbody a {
	text-decoration: none;
	color: black;
}

tbody a:hover {
	font-weight: bold;
}
</style>

</head>





<body>

	<header>

		<%@ include file="../fragments/header.jspf"%>

	</header>



	<div class="container" id="mypage">

		<div class="row">

			<%@ include file="../fragments/menu.jspf"%>



			<div class="col-8">

				<div class="card-header border-0" id="login-info">

					<h3>내가 쓴 댓글 목록</h3>

				</div>

				<table class="table table-striped table-hover">

					<thead>

						<tr>

							<th class="text-center col-1">포스트 번호</th>

							<th class="text-center col-4">내용</th>

							<th class="text-center col-1">채택</th>

							<th class="text-center col-2">작성시간</th>

						</tr>

					</thead>

					<tbody>

						<c:forEach var="c" items="${comments}">

							<tr>

								<td class="text-center">${c.postId}</td>

								<td><c:choose>

										<c:when test="${c.category eq 'P001'}">

											<c:url var="mainPostDetailsPage" value="/mainPost/details">

												<c:param name="id" value="${c.postId}"></c:param>

												<c:param name="commentId" value="${c.id}"></c:param>

											</c:url>

											<a href="${mainPostDetailsPage}">${c.content}</a>

										</c:when>

										<c:when test="${c.category eq 'P003'}">

											<c:url var="joinPostDetailsPage" value="/join/join_details">

												<c:param name="id" value="${c.postId}"></c:param>

											</c:url>

											<a href="${joinPostDetailsPage}">${c.content}</a>

										</c:when>

										<c:when test="${c.category eq 'P004'}">

											<c:url var="reviewPostDetailsPage"
												value="/review/review_details">

												<c:param name="id" value="${c.postId}"></c:param>

												<c:param name="commentId" value="${c.id}"></c:param>

											</c:url>

											<a href="${reviewPostDetailsPage}">${c.content}</a>

										</c:when>

										<c:otherwise>

											<c:url var="commPostDetailsPage"
												value="/community/comm_details">

												<c:param name="id" value="${c.postId}"></c:param>

												<c:param name="commentId" value="${c.id}"></c:param>

											</c:url>

											<a href="${commPostDetailsPage}">${c.content}</a>

										</c:otherwise>

									</c:choose></td>

								<c:choose>

									<c:when test="${c.selection eq 0}">

										<td class="text-center">미채택</td>

									</c:when>

									<c:otherwise>

										<td class="text-center">채택됨</td>

									</c:otherwise>

								</c:choose>

								<td>${c.modifiedTime}</td>
							</tr>

						</c:forEach>

					</tbody>

				</table>

			</div>

		</div>

	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

</body>

</html>