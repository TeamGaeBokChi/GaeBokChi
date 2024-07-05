<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>환전 관리</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .container { width: 80%; margin: 0 auto; padding: 20px; }
        h1 { color: #2c3e50; text-align: center; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; background-color: #fff; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #e0e0e0; }
        th { background-color: #3498db; color: #fff; }
        tr:hover { background-color: #f5f5f5; }
        .btn { padding: 8px 12px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-approve { background-color: #2ecc71; color: #fff; }
        .btn-reject { background-color: #e74c3c; color: #fff; }
        .nav { background-color: #2c3e50; padding: 10px 0; }
        .nav ul { list-style-type: none; padding: 0; margin: 0; display: flex; justify-content: center; }
        .nav ul li { margin: 0 10px; }
        .nav ul li a { color: #ecf0f1; text-decoration: none; font-weight: bold; }
        .nav ul li a:hover { color: #3498db; }
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
        <h1>환전 요청 관리</h1>
        <table>
            <thead>
                <tr>
                    <th>요청 ID</th>
                    <th>회원명</th>
                    <th>요청 금액</th>
                    <th>요청 일시</th>
                    <th>상태</th>
                    <th>액션</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1001</td>
                    <td>홍길동</td>
                    <td>500,000원</td>
                    <td>2024-07-05 14:30</td>
                    <td>대기 중</td>
                    <td>
                        <button class="btn btn-approve" onclick="approveExchange(1001)">승인</button>
                        <button class="btn btn-reject" onclick="rejectExchange(1001)">거절</button>
                    </td>
                </tr>
                <!-- 더 많은 행 추가 -->
            </tbody>
        </table>
    </div>
    <script>
        function approveExchange(id) {
            alert(id + "번 환전 요청이 승인되었습니다.");
            // 여기에 AJAX 요청 등의 실제 처리 로직 추가
        }
        function rejectExchange(id) {
            alert(id + "번 환전 요청이 거절되었습니다.");
            // 여기에 AJAX 요청 등의 실제 처리 로직 추가
        }
    </script>
</body>
</html>