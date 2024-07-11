<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

.container {
    width: 90%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

h1 {
    color: #2c3e50;
    text-align: center;
    margin-bottom: 30px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
    vertical-align: middle;
}

th {
    background-color: #3498db;
    color: #fff;
}

tr:hover {
    background-color: #f5f5f5;
}

.btn {
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    margin-right: 5px;
}

.btn-change {
    background-color: #2ecc71;
    color: #fff;
}

.btn-delete {
    background-color: #e74c3c;
    color: #fff;
}

.nav {
    background-color: #2c3e50;
    padding: 10px 0;
}

.nav ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
    display: flex;
    justify-content: center;
}

.nav ul li {
    margin: 0 10px;
}

.nav ul li a {
    color: #ecf0f1;
    text-decoration: none;
    font-weight: bold;
}

.nav ul li a:hover {
    color: #3498db;
}

select {
    width: 100px;
    padding: 8px;
    margin-right: 10px;
    border-radius: 4px;
    border: 1px solid #ccc;
    font-size: 14px;
}

.action-buttons {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.grade-form {
    display: flex;
    align-items: center;
}
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
                <th>등급</th>
                <th>회원탈퇴</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${members}" var="members">
            <tr>
                <td>${members.userid}</td>
                <td>${membesr.name}</td>
                <td>
                    <form action="changeGrade" method="post" class="grade-form" onsubmit="return confirm('정말로 변경하시겠습니까?');">
                        <select name="grade">
                            <option value="G21" ${members.grade == 'G21' ? 'selected' : ''}>G21</option>
                            <option value="G22" ${members.grade == 'G22' ? 'selected' : ''}>G22</option>
                            <option value="G23" ${members.grade == 'G23' ? 'selected' : ''}>G23</option>
                            <option value="G24" ${members.grade == 'G24' ? 'selected' : ''}>G24</option>
                            <option value="G10" ${members.grade == 'G10' ? 'selected' : ''}>G10</option>
                        </select>
                        <input type="hidden" name="userid" value="${members.userid}">
                        <button type="submit" class="btn btn-change">변경</button>
                    </form>
                </td>
                <td>
                    <form action="deleteUser" method="post" style="display:inline;" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
                        <input type="hidden" name="userid" value="${members.userid}">
                        <button type="submit" class="btn btn-delete">회원삭제</button>
                    </form>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>