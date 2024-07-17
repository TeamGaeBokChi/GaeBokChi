<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골프로 관리자 홈</title>
<style>
    body { 
        font-family: 'Arial', sans-serif; 
        margin: 0; 
        padding: 0; 
        background-color: #f0f2f5; 
    }
    .container { 
        width: 90%; 
        margin: 0 auto; 
        padding: 20px; 
    }
    h1 { 
        color: #1a3a5c; 
        text-align: center; 
        margin-bottom: 30px; 
        font-size: 2.5em;
    }
    .dashboard { 
        display: grid; 
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
    }
    .card { 
        background-color: #fff; 
        border-radius: 10px; 
        box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
        padding: 20px; 
        transition: all 0.3s ease; 
    }
    .card:hover { 
        transform: translateY(-5px); 
        box-shadow: 0 6px 12px rgba(0,0,0,0.15); 
    }
    .card h2 { 
        color: #2c3e50; 
        margin-top: 0; 
        font-size: 1.5em;
    }
    .nav { 
        background-color: #1a3a5c; 
        padding: 15px 0; 
    }
    .nav ul { 
        list-style-type: none; 
        padding: 0; 
        margin: 0; 
        display: flex; 
        justify-content: center; 
    }
    .nav ul li { 
        margin: 0 15px; 
    }
    .nav ul li a { 
        color: #fff; 
        text-decoration: none; 
        font-weight: bold; 
        font-size: 1.1em;
        transition: color 0.3s ease;
    }
    .nav ul li a:hover { 
        color: #3498db; 
    }
    .card a { 
        text-decoration: none; 
        color: inherit; 
    }
    .card-link { 
        display: block; 
        padding: 12px; 
        background-color: #3498db; 
        color: #fff; 
        text-align: center; 
        border-radius: 5px; 
        margin-top: 15px; 
        transition: background-color 0.3s ease; 
        font-weight: bold;
    }
    .card-link:hover { 
        background-color: #2980b9; 
    }
    .card-icon {
        font-size: 3em;
        margin-bottom: 15px;
        color: #3498db;
    }
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<div class="nav">
    <ul>
        <li><a href="adminHome"><i class="fas fa-home"></i> 홈</a></li>
        <li><a href="adminExchange"><i class="fas fa-exchange-alt"></i> 환전 관리</a></li>
        <li><a href="adminMembers"><i class="fas fa-users"></i> 회원 관리</a></li>
        <li><a href="adminSignup"><i class="fas fa-user-plus"></i> 가입 승인</a></li>
        <li><a href="adminPosts"><i class="fas fa-clipboard"></i> 게시글 관리</a></li>
    </ul>
</div>
<div class="container">
    <h1>Golfro 관리자 대시보드</h1>
    <div class="dashboard">
        <div class="card">
            <a href="adminMembers">
                <div class="card-icon"><i class="fas fa-users"></i></div>
                <h2>회원 통계</h2>
                <span class="card-link">회원 관리로 이동</span>
            </a>
        </div>
        <div class="card">
            <a href="adminExchange">
                <div class="card-icon"><i class="fas fa-exchange-alt"></i></div>
                <h2>환전 요청</h2>
                <span class="card-link">환전 관리로 이동</span>
            </a>
        </div>
        <div class="card">
            <a href="adminPosts">
                <div class="card-icon"><i class="fas fa-clipboard"></i></div>
                <h2>게시글 현황</h2>
                <span class="card-link">게시글 관리로 이동</span>
            </a>
        </div>
        <div class="card">
            <a href="adminSignup">
                <div class="card-icon"><i class="fas fa-user-plus"></i></div>
                <h2>가입 승인 대기</h2>
                <span class="card-link">가입 승인으로 이동</span>
            </a>
        </div>
        <div class="card">
            <a href="/gaebokchi">
                <div class="card-icon"><i class="fas fa-home"></i></div>
                <h2>메인 홈 페이지</h2>
                <span class="card-link">메인으로 이동</span>
            </a>
        </div>
    </div>
</div>
</body>
</html>