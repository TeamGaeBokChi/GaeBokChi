<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>GOLFRO</title>
    <c:url var="footer" value="css/footer.css" />
        <link rel="stylesheet" type="text/css" href="${footer}">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
        rel="stylesheet" 
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
        crossorigin="anonymous" />
</head>
<body>
    <div class="container-fluid">
        <c:set var="pageTitle" value="Home" scope="page" />
        <%@ include file="./fragments/header.jspf" %>        
        
        <%@ include file="./fragments/main.jsp" %>
    </div>
    
    
    
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
        crossorigin="anonymous"></script>
</body>

<footer>
    <div class="container">
        <div class="left">
        <h1>COLFRO</h1>
        <p>골프 레슨은 여기에서! 골프로</p>
        </div>
        <div class="right">
            <div class="list">
                <h3>CONTENT</h3>
                <ul>
                    <li>content</li>
                    <li>content</li>
                    <li>content</li>
                    <li>content</li>
                </ul>
            </div>
            <div class="list">
                <h3>ABOUT</h3>
                <ul>
                    <li>about</li>
                    <li>about</li>
                    <li>about</li>
                    <li>about</li>
                </ul>
            </div>
        </div>
    </div>
   <div></div>
</footer>
</html>