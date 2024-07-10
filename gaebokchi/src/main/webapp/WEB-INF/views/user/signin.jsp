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
<link rel="stylesheet" href="../css/user_signin.css" />


<c:if test="${not empty signupSuccess}">
    <script>
					var userType = '${signupSuccess}';
					if (userType === 'normal') {
						alert("일반회원 가입을 축하드립니다!");
					} else if (userType === 'expert') {
						alert("전문가 회원 가입을 축하드립니다! 관리자 승인 후 전문가 등급으로 변경됩니다.");
					}
				</script>

</c:if>
</head>
<body>

    <header>
        <%@ include file="../fragments/header.jspf"%>
    </header>

    <div class="container login-container" id="login">
        <div class="card" id="card">
            <div class="card-header text-center py-3" id="card-header">
                <div class="logo">
                    <c:url var="logoImage" value="/images/002.png" />
                    <img src="${logoImage}" alt="Logo Title">
                </div>
                <h5>프로를 향한 골프의 꿈, 골프로</h5>
            </div>
            <div class="card-body p-4">
                <form action="/gaebokchi/user/signin" method="post">
                    <div class="mb-1">
                        <input class="form-control" type="text"
                            name="userid" placeholder="아이디" required />
                    </div>
                    <div class="mb-4">
                        <input class="form-control" type="password"
                            name="password" placeholder="비밀번호" required />
                    </div>
                    <div class="d-grid">
                        <button class="btn btn-login text-white py-2"
                            name="btnSignin" type="submit">로그인</button>
                    </div>
                </form>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message text-center mt-3">${errorMessage}</div>
                </c:if>
            </div>
            <div class="card-footer bg-white border-top-0">
                <ul class="links">
                    <li><a href="#" data-bs-toggle="modal"
                        data-bs-target="#findIdModal">아이디 찾기</a></li>
                    <li><a href="#" data-bs-toggle="modal"
                        data-bs-target="#findPwModal">비밀번호 찾기</a></li>
                    <li><a href="signup">회원가입</a></li>
                </ul>
            </div>
            <!-- 아이디 찾기 모달 -->
            <div class="modal fade" id="findIdModal" tabindex="-1"
                aria-labelledby="findIdModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" id="modal-id">
                    <!-- modal-dialog-centered 클래스 추가 -->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"
                                id="findIdModalLabel">아이디 찾기</h5>
                            <button type="button" class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- 아이디 찾기 폼 내용 -->
                            <form id="findIdForm">
                                <div class="mb-3">
                                    <label for="findIdName"
                                        class="form-label">이름</label> <input
                                        type="text" class="form-control"
                                        id="findIdName" name="name"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label for="findIdEmail"
                                        class="form-control-label">이메일</label>
                                    <input type="email"
                                        class="form-control"
                                        id="findIdEmail" name="email"
                                        required>
                                </div>
                                <button type="submit"
                                    class="btn btn-primary"
                                    id="findIdBtn">아이디 찾기</button>
                            </form>
                            <div id="findIdError"
                                class="alert alert-danger mt-3"
                                style="display: none;">
                                <p id="errorMessage"></p>
                            </div>
                            <div id="findIdResult" class="mt-3"
                                style="display: none;">
                                <p id="foundId"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 비밀번호 찾기 모달 -->
            <div class="modal fade" id="findPwModal" tabindex="-1"
                aria-labelledby="findPwModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <!-- modal-dialog-centered 클래스 추가 -->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"
                                id="findPwModalLabel">비밀번호 찾기</h5>
                            <button type="button" class="btn-close"
                                data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- 비밀번호 찾기 폼 내용 -->
                            <form id="findPwForm">
                                <div class="mb-3">
                                    <label for="findPwId"
                                        class="form-label">아이디</label> <input
                                        type="text" class="form-control"
                                        id="findPwId" name="userid"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label for="findPwEmail"
                                        class="form-label">이메일</label> <input
                                        type="email"
                                        class="form-control"
                                        id="findPwEmail" name="email"
                                        required>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">휴대폰
                                        번호</label>
                                    <div class="flex"
                                        style="display: flex; flex-direction: row; gap: 5px;">
                                        <select class="form-select"
                                            name="phone0"
                                            style="width: 30%;">
                                            <option value="SKT">SKT</option>
                                            <option value="KT">KT</option>
                                            <option value="LG U+">LG
                                                U+</option>
                                            <option value="SKT 알뜰폰">SKT
                                                알뜰폰</option>
                                            <option value="KT 알뜰폰">KT
                                                알뜰폰</option>
                                            <option value="LG U+ 알뜰폰">LG
                                                U+ 알뜰폰</option>
                                        </select> <input type="text"
                                            class="form-control"
                                            id="phone1" name="phone1"
                                            style="width: 20%;" required>
                                        <input type="text"
                                            class="form-control"
                                            id="phone2" name="phone2"
                                            placeholder="앞자리" required
                                            style="width: 25%;">
                                        <input required type="text"
                                            class="form-control"
                                            id="phone3" name="phone3"
                                            placeholder="뒷자리" required
                                            style="width: 25%;">
                                    </div>
                                    <button type="submit"
                                        class="btn btn-primary"
                                        id="findPwBtn" name="findPwBtn">비밀번호
                                        찾기</button>
                                </div>
                            </form>
                            <!-- 새 비밀번호 설정 폼 (초기에는 숨김) -->
                            <form id="setNewPwForm"
                                style="display: none;" class="mt-3">
                                <div class="mb-3">
                                    <label for="newPassword"
                                        class="form-label">새
                                        비밀번호</label> <input type="password"
                                        class="form-control"
                                        id="userPassword"
                                        placeholder="8~15자의 숫자, 특수문자, 영문자 조합"
                                        name="password" required>
                                    <div id="passwordStrength"></div>
                                </div>
                                <div class="mb-3">
                                    <label for="userPasswordConfirm"
                                        class="form-label">새
                                        비밀번호 확인</label> <input type="password"
                                        class="form-control"
                                        id="userPasswordConfirm"
                                        placeholder="비밀번호를 다시 입력하세요"
                                        required>
                                    <div id="passwordMatch"></div>
                                </div>
                                <button type="submit"
                                    class="btn btn-primary"
                                    id="setNewPwBtn">새 비밀번호 설정</button>
                            </form>
                            <!-- 오류 메시지 표시 영역 -->
                            <div id="findPwError"
                                class="alert alert-danger mt-3"
                                style="display: none;">
                                <p id="errorMessagePw"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모달이 닫힐 때 입력 필드 초기화 -->
            <script>
													// 아이디 찾기 모달이 숨겨질 때 실행할 함수
													const findIdModal = document
															.getElementById('findIdModal');
													findIdModal
															.addEventListener(
																	'hidden.bs.modal',
																	function(
																			event) {
																		// 폼 초기화
																		document
																				.getElementById(
																						'findIdForm')
																				.reset();
																		// 에러 메시지 영역 초기화
																		document
																				.getElementById('findIdError').style.display = 'none';
																		document
																				.getElementById('errorMessage').textContent = '';
																		// 결과 영역 초기화
																		document
																				.getElementById('findIdResult').style.display = 'none';
																		document
																				.getElementById('foundId').textContent = '';
																	});
												</script>

            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                crossorigin="anonymous"></script>
            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
            <c:url var="userSignInJS" value="/js/user_signin.js" />
            <script src="${userSignInJS}"></script>
</body>
</html>