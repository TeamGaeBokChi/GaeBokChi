<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
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

<title>Insert title here</title>
</head>
<body>
	<head>
			<c:set var="pageTitle" value="새글 작성하기" />
		<%@ include file="../fragments/header.jspf"%>
	</head>
	<main>
		<!-- 인기 게시물 리스트업부 -->
		<div class="card">
			<div class="card-header">
			</div>
			<div class="card-body">
				<!-- 메인 게시판 목록 영역 -->
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>클럽종류</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>좋아요</th>
							<th>작성시간</th>
							<th>채택</th>
						</tr>
						<!-- 메인 게시판 목록 생성 영역 -->
						<tbody>
							<c:forEach var="p" items="${post}">
							<tr>
							<td>${p.id}</td>
							<td>${p.clubType}</td>
							<td>
								<c:url var="mainPostDetailsPage" value="/mainPost/details">
									<c:param name="id" value="${p.id}"></c:param>
								</c:url>	
									<a href="${mainPostDetailsPage}">${p.title}</a>
							</td>
							<td>${p.author}</td>
							<td>${p.views}</td>
							<td>${p.likes}</td>
							<td>${p.createdTime}</td>
							<td>${p.selection}</td>
							</tr>
							</c:forEach>
							
						</tbody>
					</thead>
				</table>
			</div>
		</div>
	</main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>