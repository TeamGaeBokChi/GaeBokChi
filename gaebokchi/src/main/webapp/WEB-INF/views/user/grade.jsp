<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8" />

<meta name="viewport" content="width=device-width, initial-scale=1" />

<title>회원정보｜GOLFRO</title>

<link

    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"

    rel="stylesheet"

    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"

    crossorigin="anonymous">

<link rel="stylesheet" href="../css/mypage_style.css" />

<link rel="stylesheet" href="../css/mypage.css" />

<style>

.container {

    background: white;

}



#login-info {  

    background-color: white;

    padding: 0;

    border: none;

}



.card-header {

    background: white;

}



.card-header h3 {

    font-family: 'Pretendard-Regular', Pretendard-Regular;

    font-weight: bold;

    padding-bottom: 15px;

    border-bottom: 3px solid #000000;

}

</style>







</head>

<body>

    <header>

        <%@ include file="../fragments/header.jspf"%>

    </header>



    <div class="container" id="mypage">

        <div class="row">

            <%@ include file="../fragments/menu.jspf"%>



            <div class="col-8">

                <div class="card border-0">

                    <div class="card-header border-0" id="login-info">

                        <h3>회원 등급 안내</h3>



                    </div>

                    <c:url var="grade" value="/images/grade.png" />

                    <img src="${grade}" alt="grade picture"

                        style="object-fit: cover; width: 100%; height: 100%;">



                </div>

            </div>

        </div>

    </div>





    <script

        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"

        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"

        crossorigin="anonymous"></script>





</body>

</html>