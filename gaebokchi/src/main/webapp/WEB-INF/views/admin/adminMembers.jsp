<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .container { width: 80%; margin: 0 auto; padding: 20px; }
        h1 { color: #2c3e50; text-align: center; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; background-color: #fff; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #e0e0e0; }
        th { background-color: #3498db; color: #fff; }
        tr:hover { background-color: #f5f5f5; }
        .btn { padding: 8px 12px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-edit { background-color: #f39c12; color: #fff; }
        .btn-delete { background-color: #e74c3c; color: #fff; }
        .nav { background-color: #2c3e50; padding: 10px 0; }
        .nav ul { list-style-type: none; padding: 0; margin: 0; display: flex; justify-content: center; }
        .nav ul li { margin: 0 10px; }
        .nav ul li a { color: #ecf0f1; text-decoration: none; font-weight: bold; }
        .nav ul li a:hover { color: #3498db; }
        select { padding: 5px; border-radius: 4px; border: 1px solid #bdc3c7; }
        .grade-bronze { color: #cd7f32; }
        .grade-silver { color: #c0c0c0; }
        .grade-gold { color: #ffd700; }
        .grade-platinum { color: #e5e4e2; }
        .grade-diamond { color: #b9f2ff; }
        .member-type { font-weight: bold; }
        .type-normal { color: #3498db; }
        .type-expert { color: #e74c3c; }
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
        <h1>회원 관리</h1>
        <table>
            <thead>
                <tr>
                    <th>회원 ID</th>
                    <th>이름</th>
                    <th>회원유형</th>
                    <th>가입일</th>
                    <th>등급</th>
                    <th>액션</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>홍길동</td>
                    <td><span class="member-type type-normal">일반회원</span></td>
                    <td>2024-01-01</td>
                    <td>
                        <select onchange="changeGrade(1, this.value)" id="grade-1">
                            <option value="브론즈" class="grade-bronze">브론즈</option>
                            <option value="실버" class="grade-silver">실버</option>
                            <option value="골드" class="grade-gold">골드</option>
                            <option value="플래티넘" class="grade-platinum">플래티넘</option>
                            <option value="다이아" class="grade-diamond">다이아</option>
                        </select>
                    </td>
                    <td>
                        <button class="btn btn-edit" onclick="editMember(1)">수정</button>
                        <button class="btn btn-delete" onclick="deleteMember(1)">삭제</button>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>김철수</td>
                    <td><span class="member-type type-expert">전문가</span></td>
                    <td>2024-02-15</td>
                    <td>
                        <select onchange="changeGrade(2, this.value)" id="grade-2">
                            <option value="브론즈" class="grade-bronze">브론즈</option>
                            <option value="실버" class="grade-silver">실버</option>
                            <option value="골드" class="grade-gold">골드</option>
                            <option value="플래티넘" class="grade-platinum">플래티넘</option>
                            <option value="다이아" class="grade-diamond">다이아</option>
                        </select>
                    </td>
                    <td>
                        <button class="btn btn-edit" onclick="editMember(2)">수정</button>
                        <button class="btn btn-delete" onclick="deleteMember(2)">삭제</button>
                    </td>
                </tr>
                <!-- 더 많은 회원 행 추가 -->
            </tbody>
        </table>
    </div>
    <script>
        function editMember(id) {
            alert(id + "번 회원 정보를 수정합니다.");
            // 여기에 수정 페이지로 이동하는 로직 추가
        }
        function deleteMember(id) {
            if(confirm(id + "번 회원을 정말 삭제하시겠습니까?")) {
                alert(id + "번 회원이 삭제되었습니다.");
                // 여기에 실제 삭제 처리 로직 추가
            }
        }
        function changeGrade(id, grade) {
            alert(id + "번 회원의 등급이 " + grade + "로 변경되었습니다.");
            // 여기에 실제 등급 변경 처리 로직 추가
            // 예: AJAX 요청을 통해 서버에 등급 변경 요청
        }
        // 페이지 로드 시 각 회원의 현재 등급 설정
        window.onload = function() {
            // 예시: 1번 회원의 등급을 골드로 설정
            document.getElementById('grade-1').value = '골드';
            // 예시: 2번 회원의 등급을 플래티넘으로 설정
            document.getElementById('grade-2').value = '플래티넘';
        }
    </script>
</body>
</html>