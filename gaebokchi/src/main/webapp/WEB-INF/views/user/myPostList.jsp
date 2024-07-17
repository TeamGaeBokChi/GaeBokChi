<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Golfro</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<style>
body {
	background-color: #ffffff;
	display: flex;
	justify-content: center;
}

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

.container {
	width: 1080px;
	margin: 0 auto;
	margin-top: 100px;
}

.container-fluid {
	background-color: white;
	border-radius: 10px;
	padding: 20px;
	max-width: 1000px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: 0 auto;
}

table {
	background-color: white; /* 테이블 전체 배경색 흰색 */
}

table thead {
	background-color: #e9f5e9;
}

table tbody tr {
	background-color: white; /* 테이블 행 배경색 흰색 */
}

table tbody tr:hover {
	background-color: #f1f1f1;
}

th, td {
	text-align: center;
	background-color: white; /* 테이블 헤더 및 데이터 셀 배경색 흰색 */
}

.card-header {
	background-color: #d4edda;
}

.btn-outline-secondary {
	color: #28a745;
	border-color: #28a745;
}

.btn-outline-secondary:hover {
	background-color: #28a745;
	color: white;
}

.custom-link {
	color: black;
	text-decoration: none;
}

.custom-link:hover {
	text-decoration: underline; /* 원하는 경우 호버 시 밑줄 추가 */
}

footer.text-center {
	display: flex;
	justify-content: center;
	margin-top: 20px; /* 필요에 따라 상단 마진을 조정할 수 있습니다. */
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

					<h3>내 글 목록</h3>

				</div>


				<main>
					<div class="card border-0">
						<div class="card-body">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>제목</th>
										<th>작성일</th>
										<th>조회</th>
										<th>추천</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="p" items="${posts}">
										<tr class="table">
											<td><c:choose>
													<c:when test="${p.category eq 'P003'}">
														<c:url var="joinPostDetailsPage"
															value="/join/join_details">
															<c:param name="id" value="${p.id}" />
														</c:url>
														<a href="${joinPostDetailsPage}" class="custom-link">${p.title}</a>
													</c:when>
													<c:when test="${p.category eq 'P004'}">
														<c:url var="reviewPostDetailsPage"
															value="/review/review_details">
															<c:param name="id" value="${p.id}"></c:param>
														</c:url>
														<a href="${reviewPostDetailsPage}" class="custom-link">${p.title}</a>
													</c:when>
													<c:otherwise>
														<c:url var="commPostDetailsPage"
															value="/community/comm_details">
															<c:param name="id" value="${p.id}"></c:param>
														</c:url>
														<a href="${commPostDetailsPage}" class="custom-link">${p.title}</a>
													</c:otherwise>
												</c:choose></td>
											<td>${p.modifiedTime}</td>
											<td>${p.views}</td>
											<td>${p.likes}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</main>
				<footer class="text-center">
					<nav aria-label="Page navigation">
						<ul class="pagination justify-content-center">
							<c:choose>
								<c:when test="${currentPage > 1}">
									<li class="page-item"><a class="page-link"
										href="?page=${currentPage - 1}&size=${pageSize}"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled"><a class="page-link"
										href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
								</c:otherwise>
							</c:choose>
							<c:forEach begin="${startPage}" end="${endPage}" var="i">
								<li class="page-item ${i == currentPage ? 'active' : ''}"><a
									class="page-link" href="?page=${i}&size=${pageSize}">${i}</a></li>
							</c:forEach>
							<c:choose>
								<c:when test="${currentPage < totalPages}">
									<li class="page-item"><a class="page-link"
										href="?page=${currentPage + 1}&size=${pageSize}"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled"><a class="page-link"
										href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</nav>
				</footer>
			</div>
		</div>
	</div>
	</div>

	<c:url var="my_posts_js" value="/js/my_posts.js" />
	<script src="${my_posts_js}"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>