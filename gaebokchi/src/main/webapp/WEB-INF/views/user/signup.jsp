<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Golfro 회원가입</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    rel="stylesheet">
<style>
:root {
    --primary-color: #4CAF50;
    --secondary-color: #45a049;
    --background-color: #f8f9fa;
    --text-color: #333;
}

body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: var(--background-color);
    color: var(--text-color);
}

.navbar {
    background-color: var(--primary-color);
}

.navbar-brand, .nav-link {
    color: white !important;
}

.container {
    max-width: 800px;
    margin-top: 30px;
    background-color: white;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

h4 {
    color: var(--primary-color);
    margin-bottom: 20px;
}

.form-control, .btn {
    border-radius: 5px;
}

.btn-primary {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
}

.btn-primary:hover {
    background-color: var(--secondary-color);
    border-color: var(--secondary-color);
}

.form-group {
    margin-bottom: 20px;
}

.form-label {
    font-weight: bold;
}

.flex {
    display: flex;
    gap: 10px;
    align-items: center;
}

#bank {
    flex: 1;
}

#account {
    flex: 2;
}
</style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="/gaebokchi">골프로</a>
            <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link"
                        href="home.jsp">메인</a></li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown"><a
                        class="nav-link dropdown-toggle" href="#"
                        id="navbarDropdown" role="button"
                        data-bs-toggle="dropdown"> 접속하기 </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item"
                                href="singin.jsp">로그인</a></li>
                            <li><a class="dropdown-item"
                                href="signup.jsp">회원가입</a></li>
                        </ul></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h4 class="text-center">골프로 회원가입</h4>
        <form>
            <div class="form-group">
                <label for="id" class="form-label">아이디</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="userid"
                        name="userid" placeholder="아이디를 입력하세요">
                    <button class="btn btn-outline-secondary"
                        type="button">중복체크</button>
                </div>
            </div>

            <div class="form-group">
                <label for="userPassword1" class="form-label">비밀번호</label>
                <input type="password" class="form-control"
                    id="userPassword1" name="userPassword1"
                    placeholder="비밀번호를 입력하세요">
            </div>

            <div class="form-group">
                <label for="userPassword2" class="form-label">비밀번호
                    확인</label> <input type="password" class="form-control"
                    id="userPassword2" name="userPassword2"
                    placeholder="비밀번호를 다시 입력하세요">
            </div>

            <div class="form-group">
                <label for="userName" class="form-label">이름</label> <input
                    type="text" class="form-control" id="userName"
                    name="userName" placeholder="이름을 입력하세요">
            </div>

            <div class="form-group">
                <label class="form-label">휴대폰 번호</label>
                <div class="flex">
                    <select class="form-select" name="phone0">
                        <option value="SKT">SKT</option>
                        <option value="KT">KT</option>
                        <option value="LG U+">LG U+</option>
                        <option value="SKT 알뜰폰">SKT 알뜰폰</option>
                        <option value="KT 알뜰폰">KT 알뜰폰</option>
                        <option value="LG U+ 알뜰폰">LG U+ 알뜰폰</option>
                    </select> <input type="text" class="form-control"
                        name="phone1" placeholder="010"> <input
                        type="text" class="form-control" name="phone2"
                        placeholder="앞자리"> <input type="text"
                        class="form-control" name="phone3"
                        placeholder="뒷자리">
                </div>
            </div>

            <div class="form-group">
                <label for="userAge" class="form-label">나이</label> <input
                    type="number" class="form-control" id="userAge"
                    name="userAge" placeholder="나이를 입력하세요">
            </div>

            <div class="form-group">
                <label class="form-label">성별</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio"
                            name="userGender" id="male" value="남자"
                            checked> <label
                            class="form-check-label" for="male">남자</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio"
                            name="userGender" id="female" value="여자">
                        <label class="form-check-label" for="female">여자</label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="userEmail" class="form-label">이메일</label> <input
                    type="email" class="form-control" id="userEmail"
                    name="userEmail" placeholder="이메일을 입력하세요">
            </div>

            <div class="form-group">
                <label for="address" class="form-label">주소</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="address"
                        name="address" placeholder="주소를 입력하세요">
                    <button class="btn btn-outline-secondary"
                        type="button" onclick="openAddressSearch()">
                        <i class="fas fa-search"></i> 주소 검색
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label for="address2" class="form-label">상세주소</label> <input
                    type="text" class="form-control" id="address2"
                    name="address2" placeholder="상세주소를 입력하세요">
            </div>

            <div class="form-group">
                <label class="form-label">회원 유형</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio"
                            name="userType" id="normalUser" value="일반회원"
                            checked> <label
                            class="form-check-label" for="normalUser">일반회원</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio"
                            name="userType" id="expertUser" value="전문가">
                        <label class="form-check-label" for="expertUser">전문가</label>
                    </div>
                </div>
            </div>

            <div class="form-group" id="accountGroup">
                <label class="form-label">계좌번호 입력</label>
                <div class="flex">
                    <select class="form-select" id="bank" name="bank">
                        <option value="">은행 선택</option>
                        <option value="KWANGJU">광주</option>
                        <option value="BNK">경남</option>
                        <option value="KB">국민</option>
                        <option value="IBK">기업</option>
                        <option value="NH">농협</option>
                        <option value="DGB">대구</option>
                        <option value="BUSAN">부산</option>
                        <option value="KDB">산업</option>
                        <option value="MG">새마을금고</option>
                        <option value="SH">수협</option>
                        <option value="SOL">신한</option>
                        <option value="ShinHyup">신협</option>
                        <option value="WOORI">우리</option>
                        <option value="PO">우체국</option>
                        <option value="JB">전북</option>
                        <option value="kakao">카카오뱅크</option>
                        <option value="Toss">토스</option>
                        <option value="KEB">하나</option>
                        <option value="SC">SC제일</option>

                    </select> <input type="text" class="form-control"
                        id="account" name="account"
                        placeholder="계좌번호를 입력하세요">
                </div>
            </div>

            <div class="form-group" id="licenseGroup">
                <label for="LicenseUpload" class="form-label">라이센스
                    등록</label>
                <div class="input-group">
                    <input type="text" class="form-control"
                        id="LicenseUpload" name="LicenseUpload"
                        placeholder="라이센스 번호를 등록하세요">
                </div>
            </div>

            <div class="d-grid gap-2 mt-4" id="submitButtonContainer">
                <button type="submit" class="btn btn-primary btn-lg">회원가입</button>
            </div>

            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script
                src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
            <script
                src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
													function openAddressSearch() {
														new daum.Postcode(
																{
																	oncomplete : function(
																			data) {
																		document
																				.getElementById('address').value = data.address;
																	}
																}).open();
													}
												</script>
            <script>
													// 사용자 유형에 따라 계좌번호 입력창과 라이센스 등록창을 보여주거나 숨기는 함수
													function toggleFormFields() {
														var expertUserChecked = document
																.getElementById('expertUser').checked;
														var accountGroup = document
																.getElementById('accountGroup');
														var licenseGroup = document
																.getElementById('licenseGroup');
														var submitButtonContainer = document
																.getElementById('submitButtonContainer');

														if (expertUserChecked) {
															accountGroup.style.display = 'block';
															licenseGroup.style.display = 'block';
															submitButtonContainer.style.display = 'block'; // 전문가일 때 버튼 보이기
														} else {
															accountGroup.style.display = 'none';
															licenseGroup.style.display = 'none';
															submitButtonContainer.style.display = 'block'; // 일반회원일 때도 버튼 보이기
														}
													}

													// 페이지 로드시 초기 호출
													toggleFormFields();

													// 라디오 버튼 변경 이벤트 감지
													var radios = document
															.querySelectorAll('input[type=radio][name=userType]');
													radios
															.forEach(function(
																	radio) {
																radio
																		.addEventListener(
																				'change',
																				toggleFormFields);
															});
												</script>
</body>
</html>