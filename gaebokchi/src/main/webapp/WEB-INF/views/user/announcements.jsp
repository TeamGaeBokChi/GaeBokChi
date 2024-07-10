<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Golfro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style type="text/css">
        .container {
            width: 1080px;
            margin: 0 auto;
            margin-top: 100px;
        }
    </style>
</head>
<body>
    <header>
        <%@ include file="../fragments/header.jspf"%>
    </header>
    
    <div class="container">
        <div class="row">
            <%@ include file="../fragments/menu.jspf" %>

            <div class="col-8">
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
                                <td>
                                    <c:url var="commPostDetailsPage" value="/community/comm_details">
                                        <c:param name="id" value="${p.id}"></c:param>
                                    </c:url>
                                    <a href="${commPostDetailsPage}" class="custom-link">${p.title}</a>
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
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>