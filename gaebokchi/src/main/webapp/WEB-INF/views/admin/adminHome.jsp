<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>골프장 관리자 홈</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .container { width: 80%; margin: 0 auto; padding: 20px; }
        h1 { color: #2c3e50; text-align: center; margin-bottom: 30px; }
        .dashboard { display: flex; justify-content: space-between; flex-wrap: wrap; }
        .card { background-color: #fff; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); padding: 20px; margin-bottom: 20px; width: calc(50% - 10px); transition: all 0.3s ease; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 6px 8px rgba(0,0,0,0.15); }
        .card h2 { color: #3498db; margin-top: 0; }
        .card p { color: #7f8c8d; }
        .nav { background-color: #2c3e50; padding: 10px 0; }
        .nav ul { list-style-type: none; padding: 0; margin: 0; display: flex; justify-content: center; }
        .nav ul li { margin: 0 10px; }
        .nav ul li a { color: #ecf0f1; text-decoration: none; font-weight: bold; }
        .nav ul li a:hover { color: #3498db; }
        .card a { text-decoration: none; color: inherit; }
        .card-link { display: block; padding: 10px; background-color: #3498db; color: #fff; text-align: center; border-radius: 4px; margin-top: 10px; transition: background-color 0.3s ease; }
        .card-link:hover { background-color: #2980b9; }
    </style>
</head>
<body>
    <div class="nav">
        <ul>
            <li><a href="adminHome">홈</a></li>
            <li><a href="adminExchange">환전 관리</a></li>
            <li><a href="adminMembers">회원 관리</a></li>
            <li><a href="adminSignup">가입 승인</a></li>
            <li><a href="adminPosts">게시글 관리</a></li>
        </ul>
    </div>
    <div class="container">
        <h1>골프장 관리자 대시보드</h1>
        <div class="dashboard">
            <div class="card">
                <a href="adminMembers">
                    <h2>회원 통계</h2>
                    <p>전체 회원 수: 1,234</p>
                    <p>신규 회원 (이번 달): 56</p>
                    <span class="card-link">회원 관리로 이동</span>
                </a>
            </div>
            <div class="card">
                <a href="adminExchange">
                    <h2>환전 요청</h2>
                    <p>대기 중인 요청: 23</p>
                    <p>오늘 처리된 요청: 15</p>
                    <span class="card-link">환전 관리로 이동</span>
                </a>
            </div>
            <div class="card">
                <a href="adminPosts">
                    <h2>게시글 현황</h2>
                    <p>전체 게시글: 789</p>
                    <p>오늘의 새 게시글: 12</p>
                    <span class="card-link">게시글 관리로 이동</span>
                </a>
            </div>
            <div class="card">
                <a href="adminSignup">
                    <h2>가입 승인 대기</h2>
                    <p>승인 대기 중: 7</p>
                    <p>오늘 승인된 회원: 3</p>
                    <span class="card-link">가입 승인으로 이동</span>
                </a>
            </div>
        </div>
    </div>
</body>
</html>