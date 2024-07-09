<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    import="java.sql.*"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%-- JSTL 이용하겠다. --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Middle Category</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">


    
<c:url var="mainCss" value="css/main.css" />
<link rel="stylesheet" type="text/css" href="${mainCss}">
</head>
<body>
    <section class="header container-fluid"> 
        <div class="title">
            <c:url var="mainTitle" value="images/main.png" />
            <img src="${mainTitle}" alt="main picture">
        </div>
    </section>

    <!--------------- 글럽별 레슨받기 ------------------>

    <section class="image-category container">
        <h2>클럽별 레슨받기</h2>
        <div class="row" id="clubCategory">
            <div class="col-md-2 col-6">
                <div class="card">
                    <a href=""><img src="images/전체클럽.png"
                        class="card-img-top" alt="Category 1">
                        <div class="card-body">
                            <h5 class="card-title">전체 클럽</h5>
                        </div></a>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card">
                    <img src="images/웨지.png" class="card-img-top"
                        alt="Category 2">
                    <div class="card-body">
                        <h5 class="card-title">웨지</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card">
                    <img src="images/유틸.png" class="card-img-top"
                        alt="Category 3">
                    <div class="card-body">
                        <h5 class="card-title">유틸</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card">
                    <img src="images/우드.png" class="card-img-top"
                        alt="Category 4">
                    <div class="card-body">
                        <h5 class="card-title">우드</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card">
                    <img src="images/아이언.png" class="card-img-top"
                        alt="Category 5">
                    <div class="card-body">
                        <h5 class="card-title">아이언</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="card">
                    <img src="images/드라이버.png" class="card-img-top"
                        alt="Category 6">
                    <div class="card-body">
                        <h5 class="card-title">드라이버</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!--------------- HOT 게시글 ------------------>

    <section class="hot-posts container">
        <h2>HOT 게시글</h2>

        <div class="btn-group" role="group">
            <button onclick="showTable('mainTable')"
                class="btn btn-primary">메인게시판</button>
            <button onclick="showTable('cmTable')"
                class="btn btn-secondary">커뮤니티</button>
        </div>
        

        <div class="row">
            <div class="col-md-6">
                <table id="mainTableView" class="table">
                    <thead>
								<tr>
									<th class="text-center" colspan="3">조회수 높은 글</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="p" items="${top5ByF001}">
									<tr class="table">
										<td><c:url var="commPostDetailsPage"
												value="/community/comm_details">
												<c:param name="id" value="${p.id}"></c:param>
											</c:url> <a href="${commPostDetailsPage}" class="custom-link">${p.title}</a>
										</td>
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
                        <tr>
                            <td>메인게시판 게시글 제목 1</td>
                            <td>작성자 1</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>메인게시판 게시글 제목 2</td>
                            <td>작성자 2</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>메인게시판 게시글 제목 2</td>
                            <td>작성자 3</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>메인게시판 게시글 제목 2</td>
                            <td>작성자 4</td>
                            <td>123</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-md-6">
                <table id="cmTableView" class="table"
                    style="display: none;">
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>조회수
                            <th>
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
                <table id="cmTableRecc" class="table"
                    style="display: none;">
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

        <h2>프로를 만나자</h2>
        <div class="meet-pro-box">
            <div class="pro-rank">

                <h4>실시간 랭킹</h4>
                <div class="rank">
                    <ul>
                        <li>1등</li>
                        <li>2등</li>
                        <li>3등</li>
                        <li>4등</li>
                        <li>5등</li>
                    </ul>

                </div>
            </div>

            <div class="recommend-pro">
                <h5>이분은 어때요?</h5>
                <div class="scrollbox">
                    <div class="scroll-item">
                        <img src="images/우드.png" class="card-img-top">
                    </div>
                    <div class="scroll-item">
                        <img src="images/우드.png" class="card-img-top">
                    </div>
                    <div class="scroll-item">
                        <img src="images/우드.png" class="card-img-top">
                    </div>
                    <div class="scroll-item">
                        <img src="images/우드.png" class="card-img-top">
                    </div>
                    <div class="scroll-item">
                        <img src="images/우드.png" class="card-img-top">
                    </div>
                    <div class="scroll-item">
                        <img src="images/우드.png" class="card-img-top">
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!--------------- 리뷰 게시판 ------------------>

    <section class="review container">
        <h2>이용자 후기</h2>


    </section>

   <c:url var="main_header" value="js/main_header.js" />
    <script src="${main_header}"></script>
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
				</script>
</body> 
</html>