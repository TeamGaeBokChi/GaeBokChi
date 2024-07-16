<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>회원정보｜GOLFRO</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <c:url var="css" value="/css/my_lesson_list.css" />
    <link rel="stylesheet" type="text/css" href="${css}">
</head>
<body>
    <header>
        <%@ include file="../fragments/header.jspf"%>
    </header>

    <div class="container">
        <div class="row">
            <%@ include file="../fragments/menu.jspf"%>

            <div class="col-8">
                <div class="card border-0">
                    <div class="card-body mb-1">
                        <!-- 메인 게시판 목록 영역 -->
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th class="col-1">클럽종류</th>
                                    <th class="col-3">제목</th>
                                    <th class="col-1">조회</th>
                                    <th class="col-1">좋아요</th>
                                    <th class="col-2">작성일</th>
                                    <th class="col-1">채택</th>
                                </tr>
                            </thead>
                            
                            <!-- 메인 게시판 목록 생성 영역 -->
                            <tbody>
                                <c:forEach var="p" items="${post}">
                                    <tr>
                                        <td class="text-center" id="club">${p.clubType}</td>
                                        <td id="post">
                                            <c:url var="mainPostDetailsPage" value="/mainPost/details">
                                                <c:param name="id" value="${p.id}" />
                                            </c:url> <a href="${mainPostDetailsPage}">${p.title}</a>
                                        </td>
                                        <td class="text-center">${p.views}</td>
                                        <td class="text-center">${p.likes}</td>
                                        <td class="text-center">${p.createdTime}</td>
                                        <td class="text-center">${p.selection}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
    
                        <!-- 페이징 UI 추가 -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <c:choose>
                                    <c:when test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" aria-label="Previous">
                                            	<span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&size=${pageSize}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:choose>
                                    <c:when
                                        test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script
	   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	   integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	   crossorigin="anonymous"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>