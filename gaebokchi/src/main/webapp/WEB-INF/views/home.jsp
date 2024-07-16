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
	<div class="container-fluid">
		<c:set var="pageTitle" value="Home" scope="page" />
		<%@ include file="./fragments/header.jspf"%>
	</div>

	<section class="header container-fluid">
		<div class="title">
			<c:url var="mainTitle" value="images/main.png" />
			<img src="${mainTitle}" alt="main picture"
				style="object-fit: cover; width: 100%; height: 100%;">
		</div>
	</section>

	<main>
		<!--------------- 글럽별 레슨받기 ------------------>
		<section class="image-category container">
			<h2>클럽별 레슨받기</h2>
			<ul class="row list-unstyled" id="clubCategory">

				<!--------------- 글럽별 레슨받기 ------------------>
				<section class="image-category container">
					<h2>클럽별 레슨받기</h2>
					<ul class="row list-unstyled" id="clubCategory">
						<li class="col-md-2 col-6">
							<div class="card text-center">
								<a
									href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=WG&textSearchSelect=&selectSelection=selectFalse">
									<img src="images/웨지.png" class="card-img-top" alt="Category 2">
									<div class="card-body">
										<h5 class="card-title">웨지</h5>
									</div>
								</a>
							</div>
						</li>
						<li class="col-md-2 col-6">
							<div class="card text-center">
								<a
									href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=UT&textSearchSelect=&selectSelection=selectFalse">
									<img src="images/유틸.png" class="card-img-top" alt="Category 3">
									<div class="card-body">
										<h5 class="card-title">유틸</h5>
									</div>
								</a>
							</div>
						</li>
						<li class="col-md-2 col-6">
							<div class="card text-center">
								<a
									href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=WD&textSearchSelect=&selectSelection=selectFalse">
									<img src="images/우드.png" class="card-img-top" alt="Category 4">
									<div class="card-body">
										<h5 class="card-title">우드</h5>
									</div>
								</a>
							</div>
						</li>
						<li class="col-md-2 col-6">
							<div class="card text-center">
								<a
									href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=IR&textSearchSelect=&selectSelection=selectFalse">
									<img src="images/아이언.png" class="card-img-top" alt="Category 5">
									<div class="card-body">
										<h5 class="card-title">아이언</h5>
									</div>
								</a>
							</div>
						</li>
						<li class="col-md-2 col-6">
							<div class="card text-center">
								<a
									href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=DR&textSearchSelect=&selectSelection=selectFalse">
									<img src="images/드라이버.png" class="card-img-top"
									alt="Category 6">
									<div class="card-body">
										<h5 class="card-title">드라이버</h5>
									</div>
								</a>
							</div>
						</li>
						<li class="col-md-2 col-6">
							<div class="card text-center">
								<a
									href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=PT&textSearchSelect=&selectSelection=selectFalse">
									<img src="images/퍼터.png" class="card-img-top" alt="Category 6">
									<div class="card-body">
										<h5 class="card-title">퍼터</h5>
									</div>
								</a>
							</div>
						</li>
					</ul>
				</section>

				<!--------------- HOT 게시글 ------------------>

				<section class="hot-posts container">
					<h2>HOT 게시글</h2>

					<div class="btn-group" role="group">
						<button id="mainBtn" onclick="showTable('mainTable')" class="btn">메인게시판</button>
						<button id="cmBtn" onclick="showTable('cmTable')" class="btn">커뮤니티</button>
					</div>
					<div class="bn">
						<div class="bn1" id="bnv">
							<Strong>조회수 높은</Strong> 
							<table>
								<thead>
									<th>클럽</th>
									<th>제목</th>
									<th>조회</th>
								</thead>
								<tbody>
									<c:forEach items="${viewsRank}" var="v">
										<tr>
											<td>${v.clubType}</td>
											<c:url var="postViewsRank" value="/mainPost/details">
												<c:param name="id" value="${v.id}" />
											</c:url>
											<td><a href="${postViewsRank}">${v.title} </a></td>
											<td>${v.views}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="bn1" id="bnr">
							<strong>추천수 높은</strong>
						</div>
					</div>
					</div>
					<div class="bn1" id="bnr">
						<strong>추천수 높은</strong>
						<table>
							<thead>
								<th>클럽</th>
								<th>제목</th>
								<th>추천</th>
							</thead>
							<tbody>
								<c:forEach items="${likesRank}" var="l">
									<tr>
										<td>${l.clubType}</td>
										<c:url var="postLikesRank" value="/mainPost/details">
											<c:param name="id" value="${l.id}" />
										</c:url>
										<td><a href="${postLikesRank}">${l.title} </a></td>
										<td>${l.likes}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<table id="mainTableView" class="table">
								<thead>
									<tr>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<div class="row">
											<div class="col-md-6">
												<table id="mainTableView" class="table">
													<thead>
														<tr>
															<th>제목</th>
															<th>작성자</th>
															<th>조회수</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="p" items="${top5ByF001}">
															<tr class="table">
																<td><c:url var="commPostDetailsPage"
																		value="/community/comm_details">
																		<c:param name="id" value="${p.id}"></c:param>
																	</c:url> <a href="${commPostDetailsPage}" class="custom-link">${p.title}</a></td>
																<td>${p.views}👓</td>
																<td>${p.likes}❤️</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div class="col-md-6">
												<table id="mainTableRecc" class="table">
													<thead>
														<tr>
															<th>제목</th>
															<th>작성자</th>
															<th>추천수</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="p" items="${top5ByF002}">
															<tr class="table">
																<td><c:url var="commPostDetailsPage"
																		value="/community/comm_details">
																		<c:param name="id" value="${p.id}"></c:param>
																	</c:url> <a href="${commPostDetailsPage}" class="custom-link">${p.title}</a></td>
																<td>${p.views}👓</td>
																<td>${p.likes}❤️</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div class="col-md-6">
												<table id="cmTableView" class="table" style="display: none;">
													<thead>
														<tr>
															<th>제목</th>
															<th>작성자</th>
															<th>조회수</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 1</td>
															<td>작성자 1</td>
															<td>123</td>
														</tr>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 2</td>
															<td>작성자 2</td>
															<td>123</td>
														</tr>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 1</td>
															<td>작성자 3</td>
															<td>123</td>
														</tr>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 2</td>
															<td>작성자 4</td>
															<td>123</td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="col-md-6">
												<table id="cmTableRecc" class="table" style="display: none;">
													<thead>
														<tr>
															<th>제목</th>
															<th>작성자</th>
															<th>추천수</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 1</td>
															<td>작성자 1</td>
															<td>123</td>
														</tr>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 2</td>
															<td>작성자 2</td>
															<td>123</td>
														</tr>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 1</td>
															<td>작성자 3</td>
															<td>123</td>
														</tr>
														<tr>
															<td>커뮤니티 게시판 게시글 제목 2</td>
															<td>작성자 4</td>
															<td>123</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										</section>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="p" items="${top5ByF001}">
										<tr class="table">
											<td><c:url var="commPostDetailsPage"
													value="/community/comm_details">
													<c:param name="id" value="${p.id}"></c:param>
												</c:url> <a href="${commPostDetailsPage}" class="custom-link">${p.title}</a></td>
											<td>${p.views}👓</td>
											<td>${p.likes}❤️</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="col-md-6">
							<table id="mainTableRecc" class="table">
								<thead>
									<tr>
										<th>제목</th>
										<th>작성자</th>
										<th>추천수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="p" items="${top5ByF002}">
										<tr class="table">
											<td><c:url var="commPostDetailsPage"
													value="/community/comm_details">
													<c:param name="id" value="${p.id}"></c:param>
												</c:url> <a href="${commPostDetailsPage}" class="custom-link">${p.title}</a></td>
											<td>${p.views}👓</td>
											<td>${p.likes}❤️</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="col-md-6">
							<table id="cmTableView" class="table" style="display: none;">
								<thead>
									<tr>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 1</td>
										<td>작성자 1</td>
										<td>123</td>
									</tr>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 2</td>
										<td>작성자 2</td>
										<td>123</td>
									</tr>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 1</td>
										<td>작성자 3</td>
										<td>123</td>
									</tr>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 2</td>
										<td>작성자 4</td>
										<td>123</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-md-6">
							<table id="cmTableRecc" class="table" style="display: none;">
								<thead>
									<tr>
										<th>제목</th>
										<th>작성자</th>
										<th>추천수</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 1</td>
										<td>작성자 1</td>
										<td>123</td>
									</tr>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 2</td>
										<td>작성자 2</td>
										<td>123</td>
									</tr>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 1</td>
										<td>작성자 3</td>
										<td>123</td>
									</tr>
									<tr>
										<td>커뮤니티 게시판 게시글 제목 2</td>
										<td>작성자 4</td>
										<td>123</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</section>


				<!--------------- 프로 랭킹 및 광고 ------------------>
				<section class="meet-pro container">
					<h2>실시간 포인트 랭킹</h2>
					<div class="meet-pro-box">
						<div class="pro-rank">
							<h4>실시간 랭킹</h4>
							<div class="rank">
								<ul>
									<c:forEach items="${rank}" var="r">
										<li>
											<div class="rank-thum">
												<img id="image-${r.id}" class="profile-image"
													data-file="${r.image}" alt="Uploaded Image">
											</div> <strong>이름: ${r.name}</strong> <span>보유 포인트:
												${r.point}</span>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</section>


				<!--------------- 리뷰 게시판 ------------------>
				<section class="review container">
					<h2>GOLFRO INSTAGRAM</h2>
					<div class="row d-flex">
						<blockquote class="col-2 instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/Cip3Dhpviwm/?img_index=1"
							data-instgrm-version="14"></blockquote>
						<blockquote class="col-2 instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/Cls5BewPSeh/"
							data-instgrm-version="14"></blockquote>
						<blockquote class="col-2 instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/B6vYBIOBJS6/?img_index=1"
							data-instgrm-version="14"></blockquote>
						<blockquote class="col-2 instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/B6vYBIOBJS6/?img_index=1"
							data-instgrm-version="14"></blockquote>
						<blockquote class="col-2 instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/B6vYBIOBJS6/?img_index=1"
							data-instgrm-version="14"></blockquote>
						<blockquote class="col-2 instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/B6vYBIOBJS6/?img_index=1"
							data-instgrm-version="14"></blockquote>
				</section>
				<section class="instagram container">
					<div class="instagram-header">
						<h2>GOLFRO INSTAGRAM</h2>
						<h5>@GOLFRO_KR</h5>
					</div>
					<div class="instagram-slider">
						<blockquote class="instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/C9cQp2_ycqd/"
							data-instgrm-version="14"></blockquote>
						<blockquote class="instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/C9cRuiUSWK4/"
							data-instgrm-version="14"></blockquote>
						<blockquote class="instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/C9cRw_jyR4o/"
							data-instgrm-version="14"></blockquote>
						<blockquote class="instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/C9cR-K5Sz9Z/"
							data-instgrm-version="14"></blockquote>
						<blockquote class="instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/C9cSA_wSocX/"
							data-instgrm-version="14"></blockquote>
						<blockquote class="instagram-media"
							data-instgrm-permalink="https://www.instagram.com/p/C9cSnOKypk7/"
							data-instgrm-version="14"></blockquote>
					</div>
				</section>
	</main>
	<footer>
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
						<p>> 평일: 전체 문의 상담 토요일, 공휴일: ~ 오후 2시 문의 상담 일요일: 휴무</p>
						<p>
							평일: 전체 문의 상담<br>토요일, 공휴일: ~ 오후 2시 문의 상담<br>일요일: 휴무
						</p>
					</ul>
				</div>
			</div>
		</div>


		<div class="text-center">
			<span>Copyright ⓒ - 2024 GOLFRO. All rights reserved.</span>
		</div>
        
     
	</footer>



	<c:url var="main_header" value="js/main_header.js" />
	<script src="${main_header}"></script>
	<script async src="https://www.instagram.com/embed.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<script>
		function showTable(tableId) {
			// 모든 테이블을 숨김
			document.getElementById('mainTableView').style.display = 'none';
			document.getElementById('mainTableRecc').style.display = 'none';
			document.getElementById('cmTableView').style.display = 'none';
			document.getElementById('cmTableRecc').style.display = 'none';

			// 클릭한 버튼에 맞는 테이블을 보이게 함
			if (tableId === 'mainTable') {
				document.getElementById('mainTableView').style.display = 'table';
				document.getElementById('mainTableRecc').style.display = 'table';
			} else if (tableId === 'cmTable') {
				document.getElementById('cmTableView').style.display = 'table';
				document.getElementById('cmTableRecc').style.display = 'table';
			}
		}

		// 초기에 설정할 색상 클래스
		var mainBtnClass = 'btn-success';
		var cmBtnClass = 'btn-secondary';

		// 버튼 클릭 시 호출되는 함수
		function switchButtonColor(clickedBtn) {
			var mainBtn = document.getElementById('mainBtn');
			var cmBtn = document.getElementById('cmBtn');

			// 버튼 색상을 변경
			if (clickedBtn === 'mainBtn') {
				mainBtn.classList.remove(mainBtnClass);
				cmBtn.classList.remove(cmBtnClass);
				mainBtnClass = 'btn-success';
				cmBtnClass = 'btn-secondary';
			} else if (clickedBtn === 'cmBtn') {
				mainBtn.classList.remove(mainBtnClass);
				cmBtn.classList.remove(cmBtnClass);
				mainBtnClass = 'btn-secondary';
				cmBtnClass = 'btn-success';
			}

			// 변경된 클래스 적용
			mainBtn.classList.add(mainBtnClass);
			cmBtn.classList.add(cmBtnClass);
		}

		document.addEventListener("DOMContentLoaded", function() {
			document.querySelectorAll('.profile-image').forEach(
					function(img) {
						const file = img.getAttribute('data-file');
						img.src = '../user/file/image?file='
								+ encodeURIComponent(file);
					});
		});
	</script>
	<script>
    document.addEventListener('DOMContentLoaded', function () {
        const slider = document.querySelector('.instagram-slider');
        let isDown = false;
        let startX;
        let scrollLeft;

        slider.addEventListener('mousedown', (e) => {
            isDown = true;
            slider.classList.add('active');
            startX = e.pageX - slider.offsetLeft;
            scrollLeft = slider.scrollLeft;
        });

        slider.addEventListener('mouseleave', () => {
            isDown = false;
            slider.classList.remove('active');
        });

        slider.addEventListener('mouseup', () => {
            isDown = false;
            slider.classList.remove('active');
        });

        slider.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - slider.offsetLeft;
            const walk = (x - startX) * 3; // 스크롤 속도 조정
            slider.scrollLeft = scrollLeft - walk;
        });
    });
</script>



</body>
</html>