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
            <%@ include file="../fragments/menu.jspf"%>

            <div class="col-8">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>포스트 번호</th>
                            <th>내용</th>
                            <th>채택</th>
                            <th>작성시간</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${comments}">
                            <tr>
                                <td>${c.postId}</td>
                                <td><c:url var="mainPostDetailsPage" value="/mainPost/details">
                                        <c:param name="id" value="${c.postId}"></c:param>
                                        <c:param name="commentId" value="${c.id}"></c:param>
                                    </c:url>
                                    <a href="${mainPostDetailsPage}">${c.content}</a>
                                </td>
                                <c:choose>
                                    <c:when test="${c.selection eq 0}">
                                        <td>미채택</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>채택됨</td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${c.modifiedTime ne null}">
                                        <td>${c.modifiedTime}</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${c.createdTime}</td>
                                    </c:otherwise>
                                </c:choose>
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