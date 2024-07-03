<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>조인 예약</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
    .details-header {
        background-color: #f8f9fa;
        padding: 10px;
        border-bottom: 1px solid #dee2e6;
    }
    .details-content {
        padding: 20px;
        border-bottom: 1px solid #dee2e6;
    }
    .details-footer {
        padding: 10px;
        border-top: 1px solid #dee2e6;
    }
    .icon {
        font-size: 1.2rem;
        color: #888;
    }
</style>
</head>
<body>
<div class="container mt-3">
    <div class="details-header d-flex justify-content-between align-items-center">
        <h2>조인</h2>
        <div>
            <button class="btn btn-link">◀ 이전글</button>
            <button class="btn btn-link">다음글 ▶</button>
            <button class="btn btn-link">목록</button>
        </div>
    </div>
    <div class="details-content">
        <div class="mb-3">
            <h5>골프장</h5>
            <p>캐슬파인CC</p>
        </div>
        <div class="mb-3">
            <h5>주소</h5>
            <p>경기도 여주군 강천면 부평리 산 47-1</p>
        </div>
        <div class="mb-3">
            <h5>티오프</h5>
            <p>06/21(금) 11:33 18홀</p>
        </div>
        <div class="mb-3">
            <h5>그린피</h5>
            <p>100,000원</p>
        </div>
        <div class="mb-3">
            <h5>등록자</h5>
  			<p>골린이탈출도전</p>
        </div>
        <div class="mb-3">
            <h5>내용 및 연락처</h5>
            <p>같이 해요~^^ 연락주세요 010-1234-5678</p>
        </div>
    </div>
    <div class="details-footer d-flex justify-content-between">
        <button class="btn btn-outline-danger">⚠ 신고하기</button>
        <button class="btn btn-primary">✏ 조인신청</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
