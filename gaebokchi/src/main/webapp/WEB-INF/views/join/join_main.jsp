<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>조인 페이지 메인</title>
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

.container-fluid {
	background-color: white;
	border-radius: 10px;
	padding: 20px;
	max-width: 1000px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: 0 auto;
	margin-top: 85px;
}

.card {
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #ffffff;
}

.card-header {
	background-color: #C3E6C4;
	color: white;
	padding: 10px;
}

.tab-header {
	background-color: #ffffff;
	padding: 10px;
}

.tab-header div {
	text-align: center;
	width: 14%;
	color: #000000;
}

.table {
	background-color: #ffffff;
	border-bottom-left-radius: 12px;
	border-bottom-right-radius: 12px;
	margin-bottom: 0;
}

.table thead th {
	text-align: center;
}

.header-main {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.header-main h1 {
	margin: 0;
}

.header-main .search-container {
	display: flex;
	align-items: center;
	gap: 10px;
}

.header-main .search-container input {
	width: 200px;
}

.header-main .search-container button, .btn-link.text-white {
	height: 38px;
	color: #C3E6C4;
	background-color: white;
	border: 1px solid #C3E6C4;
}

.header-main .search-container button:hover, .btn-link.text-white:hover
	{
	background-color: #C3E6C4;
	color: white;
}

.header-main .btn-custom {
	height: 38px;
	color: #2A7E50;
	background-color: white;
	border: 1px solid #2A7E50;
}

.header-main .btn-custom:hover {
	background-color: #2A7E50;
	color: white;
}

/* 테이블 행 전체에 대한 스타일 */
.table tr.gray-td {
	background-color: #d3d3d3 !important;
	color: #a0a0a0 !important;
	pointer-events: none;
}

.table tr.white-td {
	background-color: #ffffff !important;
	color: #000000 !important;
}

/* 테이블 셀 각각에 대한 스타일 */
.table tr.gray-td td {
	background-color: #d3d3d3 !important;
	color: #000000 !important;
	pointer-events: none;
}

.table tr.white-td td {
	background-color: #ffffff !important;
	color: #000000 !important;
}

.custom-link {
	color: inherit;
	text-decoration: none;
}

.custom-link:hover {
	text-decoration: underline;
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
			<%@ include file="../fragments/header.jspf"%>
		</header>
		<div class="card">
			<div class="card-header">
				<!-- 카테고리 선택 폼 추가 -->
				<c:url var="catesearchPage" value="/join/join_main" />
				<form method="get" action="${catesearchPage}">
					<div class="row justify-content-center">
						<div class="col-2">
							<select class="form-control" name="category">
								<option value="t" ${selectedCategory == 't' ? 'selected' : ''}>골프장명</option>
								<option value="g" ${selectedCategory == 'g' ? 'selected' : ''}>주소</option>
								<option value="h" ${selectedCategory == 'h' ? 'selected' : ''}>홀수</option>
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
							<c:url var="createPostUrl" value="/join/join_create" />
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
		</div>

		<div class="tab-header d-flex justify-content-between">
			<div>
				<button class="btn btn-link text-black" id="prevBtn">◀</button>
			</div>
			<div>
				<a href="#" id="date1" class="date-header"></a>
			</div>
			<div>
				<a href="#" id="date2" class="date-header"></a>
			</div>
			<div>
				<a href="#" id="date3" class="date-header"></a>
			</div>
			<div>
				<a href="#" id="date4" class="date-header"></a>
			</div>
			<div>
				<a href="#" id="date5" class="date-header"></a>
			</div>
			<div>
				<button class="btn btn-link text-black" id="nextBtn">▶</button>
			</div>
		</div>

		<table class="table">
			<thead>
				<tr>
					<th>티오프</th>
					<th>골프장</th>
					<th>주소</th>
					<th>홀수</th>
					<th>그린피</th>
					<th>등록자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="p" items="${posts}">
					<tr class="${p.teeoff lt today ? 'gray-td' : 'white-td'}">
						<td>${p.teeoff}</td>
						<td><c:url var="joinPostDetailsPage"
								value="/join/join_details">
								<c:param name="id" value="${p.id}" />
							</c:url> <a href="${joinPostDetailsPage}" class="custom-link">${p.title}</a>
						</td>
						<td>${p.gcadress}</td>
						<td>${p.hole}홀</td>
						<td>${p.greenfee}원</td>
						<td>${p.author}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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


	<script>
		let currentOffset = 0;

		// 날짜 목록을 업데이트하는 함수
		function getDates(currentOffset) {
			const today = new Date();
			const dates = [];

			for (let i = 0; i < 5; i++) {
				const date = new Date(today);
				date.setDate(today.getDate() + i + currentOffset);
				dates.push(date.toISOString().split('T')[0]); // YYYY-MM-DD 형식으로 변환
			}

			// 날짜 링크와 텍스트 설정
			const basePath = "/gaebokchi/join/";
			document.getElementById('date1').textContent = dates[0] || '';
			document.getElementById('date2').textContent = dates[1] || '';
			document.getElementById('date3').textContent = dates[2] || '';
			document.getElementById('date4').textContent = dates[3] || '';
			document.getElementById('date5').textContent = dates[4] || '';

			document.getElementById('date1').href = dates[0] ? `${basePath}join_main?teeoffDate=${dates[0]}`
					: '#';
			document.getElementById('date2').href = dates[1] ? `${basePath}join_main?teeoffDate=${dates[1]}`
					: '#';
			document.getElementById('date3').href = dates[2] ? `${basePath}join_main?teeoffDate=${dates[2]}`
					: '#';
			document.getElementById('date4').href = dates[3] ? `${basePath}join_main?teeoffDate=${dates[3]}`
					: '#';
			document.getElementById('date5').href = dates[4] ? `${basePath}join_main?teeoffDate=${dates[4]}`
					: '#';
		}
		// 다음 버튼 클릭 이벤트 리스너
		document.getElementById('nextBtn').addEventListener('click',
				function() {
					currentOffset += 1;
					getDates(currentOffset);
				});

		// 이전 버튼 클릭 이벤트 리스너
		document.getElementById('prevBtn').addEventListener('click',
				function() {
					currentOffset -= 1;
					getDates(currentOffset);
				});

		// 페이지가 로드되면 날짜 목록을 업데이트
		document.addEventListener('DOMContentLoaded', function() {
			getDates(currentOffset);
		});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>
