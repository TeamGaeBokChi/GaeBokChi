<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>자유게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />
<style>
body {
	background-color: #ffffff;
	display: flex;
	justify-content: center;
	padding: 20px;
}

.container-fluid {
	background-color: white;
	border-radius: 10px;
	padding: 20px;
	max-width: 1000px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: 0 auto;
	margin-top: 30px;
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
	<div class="container-fluid">
		<header>
			<h4>리뷰 게시판</h4>
			<%@ include file="../fragments/header.jspf"%>
		</header>

		<main>
			<div class="mt-2 card">
				<div class="card-header">
					<!-- 카테고리 선택 폼 추가 -->
					<c:url var="catesearchPage" value="/review/review_main" />
					<form method="get" action="${catesearchPage}">
						<div class="row">
							<div class="col-2">
								<select class="form-control" name="search-category">
									<option value="t"
										${selectedSearchCategory == 't' ? 'selected' : ''}>제목</option>
									<option value="c"
										${selectedSearchCategory == 'c' ? 'selected' : ''}>내용</option>
									<option value="tc"
										${selectedSearchCategory == 'tc' ? 'selected' : ''}>제목+내용</option>
									<option value="n"
										${selectedSearchCategory == 'n' ? 'selected' : ''}>닉네임</option>
								</select>
							</div>
							<div class="col-5">
								<input type="text" class="form-control" name="keyword"
									placeholder="검색어 입력" value="${keyword}" />
							</div>
							<div class="col-1">
								<input type="submit"
									class="form-control btn btn-outline-secondary" value="🔍" />
							</div>
							<div class="col-2">
								<c:url var="createPostUrl" value="/review/review_create" />
								<c:url var="signinUrl" value="/user/signin" />
								<c:choose>
									<c:when test="${not empty signedInUser}">
										<!-- signedInUser가 있는 경우: 글쓰기 링크 -->
										<a href="${createPostUrl}"
											class="form-control btn btn-outline-secondary">글쓰기</a>
									</c:when>
									<c:otherwise>
										<!-- signedInUser가 없는 경우: 로그인 링크 -->
										<a href="${signinUrl}"
											class="form-control btn btn-outline-secondary">글쓰기</a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</form>
				</div>

				<div class="card-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
								<th>추천</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="p" items="${pinnedPosts}">
								<tr class="table table-secondary">
									<td><c:url var="reviewPostDetailsPage"
											value="/review/review_details">
											<c:param name="id" value="${p.id}"></c:param>
										</c:url> <a href="${reviewPostDetailsPage}" class="custom-link">${p.title}</a>
									</td>
									<td>${p.author}</td>
									<td>${p.modifiedTime}</td>
									<td>${p.views}</td>
									<td>${p.likes}</td>
								</tr>
							</c:forEach>
							<c:forEach var="p" items="${posts}">
								<tr class="table">
									<td>${categoryMap[p.category]}</td>
									<td><c:url var="reviewPostDetailsPage"
											value="/review/review_details">
											<c:param name="id" value="${p.id}"></c:param>
										</c:url> <a href="${reviewPostDetailsPage}" class="custom-link">${p.title}</a>
									</td>
									<td>${p.author}</td>
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
							<li class="page-item disabled"><a class="page-link" href="#"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
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
							<li class="page-item disabled"><a class="page-link" href="#"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</footer>
	</div>

	<c:url var="comm_main_js" value="/js/comm_main.js" />
	<script src="${comm_main_js}"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
