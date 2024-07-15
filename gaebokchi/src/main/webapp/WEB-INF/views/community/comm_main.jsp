<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>커뮤니티｜GOLFRO</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous" />
<link rel="stylesheet" href="../css/comm_main.css" />
</head>
<body>

    <%@ include file="../fragments/header.jspf"%>

    <div class="container-fluid">
        <header>
            <div class="title">
                <h2>
                    <a href="/gaebokchi/community/comm_main">COMMUNITY</a>
                </h2>
                <h7>다양한 이야기들을 함께 나눠요.</h7>
            </div> 
            <table class="table">
                <colgroup>
                    <col style="width: 50%;">
                    <col style="width: 50%;">
                </colgroup>
                <tr>
                    <td>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th class="text-center" colspan="3">인기
                                        많은 게시물 - 잡담</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${top5ByF001}">
                                    <tr class="table">
                                        <td><c:url
                                                var="commPostDetailsPage"
                                                value="/community/comm_details">
                                                <c:param name="id"
                                                    value="${p.id}"></c:param>
                                            </c:url> <a
                                            href="${commPostDetailsPage}"
                                            class="custom-link">${p.title}</a>
                                        </td>
                                        <td>${p.views}👓</td>
                                        <td>${p.likes}❤️</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table class="table table.no-boder">
                            <thead>
                                <tr>
                                    <th class="text-center" colspan="3">인기
                                        많은 게시물 - 팁/노하우</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${top5ByF002}">
                                    <tr class="table">
                                        <td><c:url
                                                var="commPostDetailsPage"
                                                value="/community/comm_details">
                                                <c:param name="id"
                                                    value="${p.id}"></c:param>
                                            </c:url> <a
                                            href="${commPostDetailsPage}"
                                            class="custom-link">${p.title}</a>
                                        </td>
                                        <td>${p.views}👓</td>
                                        <td>${p.likes}❤️</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </table>
        </header>

        <main>
            <div class="mt-2 card">
                <div class="card-header">
                    <!-- 카테고리 선택 폼 추가 -->
                    <c:url var="catesearchPage"
                        value="/community/comm_main" />
                    <form method="get" action="${catesearchPage}">
                        <div class="row">
                            <div class="col-2">
                                <select class="form-control"
                                    name="post-cate" id="categorySelect"
                                    onchange="this.form.submit()">
                                    <option value="">카테고리</option>
                                    <option value="F001"
                                        ${selectedCategory == 'F001' ? 'selected' : ''}>잡담</option>
                                    <option value="F002"
                                        ${selectedCategory == 'F002' ? 'selected' : ''}>팁/노하우</option>
                                    <option value="F003"
                                        ${selectedCategory == 'F003' ? 'selected' : ''}>라운드
                                        후기</option>
                                </select>
                            </div>
                            <div class="col-2">
                                <select class="form-control"
                                    name="search-category">
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
                                <input type="text" class="form-control"
                                    name="keyword" placeholder="검색어 입력"
                                    value="${keyword}" />
                            </div>
                            <div class="col-1">
                                <input type="submit"
                                    class="form-control btn btn-outline-secondary"
                                    value="🔍" />
                            </div>
                            <div class="col-2">
                                <c:url var="createPostUrl"
                                    value="/community/comm_create" />
                                <c:url var="signinUrl"
                                    value="/user/signin" />
                                <c:choose>
                                    <c:when
                                        test="${not empty signedInUser}">
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
                                <th class="col-2">카테고리</th>
                                <th class="col-5">제목</th>
                                <th class="col-2">작성자</th>
                                <th class="col-1">작성일</th>
                                <th class="col-1">조회</th>
                                <th class="col-1">추천</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${pinnedPosts}">
                                <tr class="table table-secondary ">
                                    <td>${category_name[p.category]}</td>
                                    <td><c:url
                                            var="commPostDetailsPage"
                                            value="/community/comm_details">
                                            <c:param name="id"
                                                value="${p.id}"></c:param>
                                        </c:url> <a
                                        href="${commPostDetailsPage}"
                                        class="custom-link">${p.title}</a>
                                    </td>
                                    <td>${userNicknames[p.author]}</td>
                                    <td>${p.modifiedTime}</td>
                                    <td>${p.views}</td>
                                    <td>${p.likes}</td>
                                </tr>
                            </c:forEach>
                            <c:forEach var="p" items="${posts}">
                                <tr class="table">
                                    <td>${category_name[p.category]}</td>
                                    <td><c:url
                                            var="commPostDetailsPage"
                                            value="/community/comm_details">
                                            <c:param name="id"
                                                value="${p.id}" />
                                        </c:url> <a
                                        href="${commPostDetailsPage}"
                                        class="custom-link">${p.title}</a>
                                    </td>
                                    <td>${userNicknames[p.author]}</td>
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
                            <li class="page-item"><a
                                class="page-link"
                                href="?page=${currentPage - 1}&size=${pageSize}"
                                aria-label="Previous"> <span
                                    aria-hidden="true">&laquo;</span>
                            </a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item disabled"><a
                                class="page-link" href="#"
                                aria-label="Previous"> <span
                                    aria-hidden="true">&laquo;</span>
                            </a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach begin="${startPage}" end="${endPage}"
                        var="i">
                        <li
                            class="page-item ${i == currentPage ? 'active' : ''}"><a
                            class="page-link"
                            href="?page=${i}&size=${pageSize}">${i}</a></li>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${currentPage < totalPages}">
                            <li class="page-item"><a
                                class="page-link"
                                href="?page=${currentPage + 1}&size=${pageSize}"
                                aria-label="Next"> <span
                                    aria-hidden="true">&raquo;</span>
                            </a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item disabled"><a
                                class="page-link" href="#"
                                aria-label="Next"> <span
                                    aria-hidden="true">&raquo;</span>
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
