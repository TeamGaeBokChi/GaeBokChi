<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>GOLFRO</title>
<c:url var="footer" value="css/footer.css" />
<link rel="stylesheet" type="text/css" href="${footer}">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />

<c:url var="mainCss" value="css/main.css" />
<link rel="stylesheet" type="text/css" href="${mainCss}">

</head>

<body>
		<div class="container">
			<div class="left">
				<h1>COLFRO</h1>
				<p>골프 레슨은 여기에서! 골프로</p>
			</div>
			<div class="right mt-2">
				<div class="list">
					<h4>CONTENT</h4>
					<ul>
						<li>회사소개</li>
						<li>광고문의</li>
						<li>이용약관</li>
						<li>제휴안내</li>
					</ul>
				</div>
				<div class="list">
					<h4>ABOUT</h4>
					<ul>
						<li>오시는 길</li>
						<li>개인정보 처리방침</li>
						<li>문의하기</li>
						<p>평일: 전체 문의 상담<br>토요일, 공휴일: ~ 오후 2시 문의 상담<br>일요일: 휴무</p>

					</ul>
				</div>
			</div>
		</div>


		<div class="text-center">
			<span>Copyright ⓒ - 2024 GOLFRO. All rights reserved.</span>
		</div>

	
	
	
</body>
</html>