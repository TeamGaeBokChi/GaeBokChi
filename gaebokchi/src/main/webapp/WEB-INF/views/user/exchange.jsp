<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>포인트환전｜GOLFRO</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    rel="stylesheet">

<link rel="stylesheet" href="../css/user_exchange.css" />

</head>
<body>

    <header>
        <%@ include file="../fragments/header.jspf"%>
    </header>

    <div class="container" id="user">
        <h3>내 포인트 환전하기</h3>
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">내 포인트</h5>
            </div>

            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h5 class="display-4">
                            <c:out value="${userPoint}" default="0" />
                        </h5>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h5 class="card-title">나의 출금계좌</h5>
            </div>
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">

                        <h5 class="display-4">
                            <c:out value="${userAccount}" default="0" />
                        </h5>
                    </div>
                    <div class="col-md-6 text-end">
                        <button class="exchangebtn" >
                            <c:url var="changeUserAccount" value="/user/privacy?userid=${signedInUser}&account=change" />
                            <a href="${changeUserAccount}" class="text-black">
                                <i class="fas fa-exchange-alt me-2" id="btn2"></i>계좌 변경
                            </a>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h5 class="card-title">출금 가능금액</h5>
            </div>
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">

                        <h5 class="display-4">
                            <c:out value="${userPoint}" default="0" />
                        </h5>
                    </div>
                    <div class="col-md-6">
                        <label for="withdraw" class="form-label">출금
                            신청금액</label> <input type="text" id="withdraw"
                            name="withdraw" class="form-control"
                            required placeholder="금액 입력"> <small
                            id="amountError"
                            class="form-text text-danger d-none">숫자만
                            입력 가능합니다.</small>
                    </div>
                </div>
            </div>
        </div>

        <div class="card" >
            <div class="card-body" id="last">
                <div class="row align-items-center">
                    <div class="col-md-6 mt-2 mb-1">
                        <label for="exchangePw" class="form-label" id="exchangePw1">
                            비밀번호</label> <input type="password" id="exchangePw"
                            class="form-control" name="password"
                            required placeholder="비밀번호 입력">
                    </div>
                    <div class="col-md-6 text-end mt-3">
                        <button class="exchangebtn" id="btnExchange">
                            <i class="fas fa-coins me-2"></i>출금 신청
                        </button>
                    </div>
                    <div id="exchangeError"
                        class="alert alert-danger mt-3"
                        style="display: none;">
                        <p id="errorMessage"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.
        });
    </script>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <c:url var="exchange" value="/js/exchange.js" />
    <script src="${exchange}"></script>
</body>
</html>