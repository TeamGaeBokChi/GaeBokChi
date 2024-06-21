<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Golfro Login</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous" />
<style>
body {
    background-color: #f8f9fa;
}

.login-container {
    max-width: 400px;
    margin: 50px auto;
}

.card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

.card-header {
    background-color: #28a745;
    color: white;
    border-radius: 15px 15px 0 0 !important;
}

.form-control {
    border-radius: 10px;
}

.btn-login {
    background-color: #28a745;
    border: none;
    border-radius: 10px;
}

.btn-login:hover {
    background-color: #218838;
}

.links {
    display: flex;
    justify-content: space-between;
    padding: 0;
    list-style-type: none;
}

.links a {
    color: #6c757d;
    text-decoration: none;
}

.links a:hover {
    color: #28a745;
}
</style>
</head>
<body>
    <div class="container login-container">
        <div class="card">
            <div class="card-header text-center py-3">
                <h2 class="mb-0">골프로 로그인</h2>
            </div>
            <div class="card-body p-4">
                <form method="post">
                    <div class="mb-3">
                        <input class="form-control" type="text"
                            name="userid" placeholder="아이디" required />
                    </div>
                    <div class="mb-3">
                        <input class="form-control" type="password"
                            name="password" placeholder="비밀번호" required />
                    </div>
                    <div class="d-grid">
                        <button class="btn btn-login text-white py-2"
                            type="submit">로그인</button>
                    </div>
                </form>
            </div>
            <div class="card-footer bg-white border-top-0 pb-3">
                <ul class="links mt-3">
                    <li><a href="#">아이디 찾기</a></li>
                    <li><a href="#">비밀번호 찾기</a></li>
                    <li><a href="#">회원가입</a></li>
                </ul>
            </div>
        </div>
    </div>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>