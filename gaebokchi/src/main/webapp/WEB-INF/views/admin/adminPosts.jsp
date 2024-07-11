<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 관리</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

.container {
	width: 80%;
	margin: 0 auto;
	padding: 20px;
}

h1 {
	color: #2c3e50;
	text-align: center;
	margin-bottom: 30px;
}

table {
	width: 100%;
	border-collapse: collapse;
	background-color: #fff;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

th, td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid #e0e0e0;
}

th {
	background-color: #3498db;
	color: #fff;
}

tr:hover {
	background-color: #f5f5f5;
}

.btn {
	padding: 8px 12px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.btn-edit {
	background-color: #f39c12;
	color: #fff;
}

.btn-delete {
	background-color: #e74c3c;
	color: #fff;
}

.btn-blind {
	background-color: #34495e;
	color: #fff;
}

.nav {
	background-color: #2c3e50;
	padding: 10px 0;
}

.nav ul {
	list-style-type: none;
	padding: 0;
	margin: 0;
	display: flex;
	justify-content: center;
}

.nav ul li {
	margin: 0 10px;
}

.nav ul li a {
	color: #ecf0f1;
	text-decoration: none;
	font-weight: bold;
}

.nav ul li a:hover {
	color: #3498db;
}
</style>
</head>
<body>
	<div class="nav">
		<ul>
			<li><a href="adminHome">홈</a></li>
			<li><a href="adminExchange">환전 관리</a></li>
			<li><a href="adminMembers">회원 관리</a></li>
			<li><a href="adminSignup">가입 승인</a></li>
			<li><a href="adminPosts">게시글 관리</a></li>
		</ul>
	</div>
	<div class="container">
		<h1>게시글 관리</h1>
		<table>
			<thead>
				<tr>
					<th>게시글 ID</th>
					<th>제목</th>
					<th>작성자 ID</th>
					<th>작성자 닉네임</th>
					<th>최종 수정 날짜</th>
					<th>저장된 카테고리</th>
					<th>액션</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="p" items="${posts}">
					<tr class="table">
						<td>${p.id}</td>
						<td><c:choose>
								<c:when test="${p.category eq 'P001'}">
									<c:url var="mainPostDetailsPage" value="/mainPost/details">
										<c:param name="id" value="${p.id}" />
									</c:url>
									<a href="${mainPostDetailsPage}" class="custom-link">${p.title}</a>
								</c:when>
									<c:when test="${p.category eq 'P003'}">
										<c:url var="joinPostDetailsPage" value="/join/join_details">
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
						<td>${p.author}</td>
						<td>${userNicknames[p.author]}</td>
						<td>${p.modifiedTime}</td>
						<td>${p.category}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script>
		function editPost(id) {
			alert(id + "번 게시글을 수정합니다.");
			// 여기에 수정 페이지로 이동하는 로직 추가
		}
		function deletePost(id) {
			if (confirm(id + "번 게시글을 정말 삭제하시겠습니까?")) {
				alert(id + "번 게시글이 삭제되었습니다.");
				// 여기에 실제 삭제 처리 로직 추가
			}
		}
	</script>
</body>
</html>
