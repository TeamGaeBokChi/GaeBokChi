<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 포인트 출금</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    rel="stylesheet">
<style>
body {
    background-color: #f8f9fa;
    font-family: 'Noto Sans KR', sans-serif;
}

.container {
    max-width: 600px;
    margin-top: 80px;
}

.card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    transition: transform 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
}

.card-body {
    padding: 25px;
}

.card-title {
    color: #495057;
    font-weight: 600;
}

.display-4 {
    font-size: 2.5rem;
    font-weight: 700;
    color: #007bff;
}

.btn-primary {
    background-color: #007bff;
    border: none;
    border-radius: 50px;
    padding: 10px 20px;
    transition: background-color 0.3s ease;
}

.btn-primary:hover {
    background-color: #0056b3;
}

input.form-control {
    border-radius: 50px;
    padding: 12px 20px;
}

.text-muted {
    font-size: 0.8rem;
}

.fixed-top {
    background-color: #007bff !important;
    color: white;
    padding: 15px 0;
}
</style>
</head>
<body>
    <div class="fixed-top text-center">
        <h2>나의 포인트 출금</h2>
    </div>
    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h5 class="card-title">내 포인트</h5>
                        <h5 class="display-4">
                            <c:out value="${userPoint}" default="0" />
                        </h5>
                    </div>

                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h5 class="card-title">나의 출금계좌</h5>
                        <h5 class="display-4">
                            <c:out value="${userAccount}" default="0" />
                        </h5>
                    </div>
                    <div class="col-md-6 text-end">
                        <button class="btn btn-primary">
                            <a href=# class="text-white"><i
                                class="fas fa-exchange-alt me-2"></i></a>계좌
                            변경
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h5 class="card-title">출금 가능금액</h5>
                        <h5 class="display-4">
                            <c:out value="${userPoint - userWithdraw}" default="0" />
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

        <div class="card">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <label for="exchangePw" class="form-label">
                            비밀번호</label> <input type="password" id="exchangePw"
                            class="form-control" name="password"
                            required placeholder="비밀번호 입력">
                    </div>
                    <div class="col-md-6 text-end mt-3">
                        <button class="btn btn-primary" id="btnExchange">
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

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <c:url var="exchange" value="/js/exchange.js" />
    <script src="${exchange}"></script>
</body>
</html>