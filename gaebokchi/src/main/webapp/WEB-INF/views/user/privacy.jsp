<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Golfro</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous" />
<link rel="stylesheet" href="../css/user_privacy.css" />

</head>

<body>
    <header>
        <%@ include file="../fragments/header.jspf"%>
    </header>

    <div class="container" id="mypage">
        <div class="row">
            <%@ include file="../fragments/menu.jspf"%>

            <div class="col-8">
                <div class="card" id="card">
                    <div class="card-header" id="login-info">
                        <h3>로그인 정보</h3>
                        <h5>내 계정</h5>
                    </div>
                    <div class="card-body">                        
                        <form>
                            <div class="mt-2">
                                <label class="form-label" for="userid">아이디</label> <input class="form-control"
                                    type="text" id="userid"
                                    name="userid" value="${user.userid}"
                                    readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="password">비밀번호</label>
                                <input class="form-control"
                                    id="password" type="password"
                                    name="password"
                                    value="${user.password}" readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="name">이름</label>
                                <input class="form-control" id="name"
                                    type="text" name="name"
                                    value="${user.name}" readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="nickname">닉네임</label>
                                <input class="form-control"
                                    id="nickname" type="text"
                                    name="nickname"
                                    value="${user.nickname}" readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="birth">생년월일</label>
                                <c:set var="number"
                                    value="${user.birth}" />
                                <input class="form-control" type="text"
                                    id="birth" name="birth"
                                    value="${fn:substring(number,0,4)}.${fn:substring(number,4,6)}.${fn:substring(number,6,8)}"
                                    readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="gender">성별</label>
                                <c:choose>
                                    <c:when test="${user.gender eq 0}">
                                        <input class="form-control"
                                            type="text" id="gender"
                                            name="gender" value="male"
                                            readonly />
                                    </c:when>
                                    <c:otherwise>
                                        <input class="form-control"
                                            type="text" id="gender"
                                            name="gender" value="female"
                                            readonly />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="phone">휴대폰 번호</label>
                                <div class="flex">
                                    <select class="form-select"
                                        name="carrier"
                                        style="width: 20%" disabled>
                                        <option value="SKT"
                                            <c:if test="${fn:split(user.phone, '/')[0] == 'SKT'}">selected</c:if>>SKT</option>
                                        <option value="KT"
                                            <c:if test="${fn:split(user.phone, '/')[0] == 'KT'}">selected</c:if>>KT</option>
                                        <option value="LG_U+"
                                            <c:if test="${fn:split(user.phone, '/')[0] == 'LG_U+'}">selected</c:if>>LG
                                            U+</option>
                                        <option value="SKT_ALTTEUL"
                                            <c:if test="${fn:split(user.phone, '/')[0] == 'SKT_ALTTEUL'}">selected</c:if>>SKT
                                            알뜰폰</option>
                                        <option value="KT_ALTTEUL"
                                            <c:if test="${fn:split(user.phone, '/')[0] == 'KT_ALTTEUL'}">selected</c:if>>KT
                                            알뜰폰</option>
                                        <option value="LG_U+_ALTTEUL"
                                            <c:if test="${fn:split(user.phone, '/')[0] == 'LG_U+_ALTTEUL'}">selected</c:if>>LG
                                            U+ 알뜰폰</option>
                                    </select> <input class="form-control"
                                        type="text" id="phone"
                                        name="number"
                                        value="${fn:split(user.phone, '/')[1]}"
                                        readonly />
                                </div>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="email">이메일</label>
                                <input class="form-control" id="email"
                                    type="email" name="email"
                                    value="${user.email}" readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="address">주소</label>
                                <input class="form-control" type="text"
                                    name="postcode" size="5"
                                    value="${fn:split(user.address, '/')[0]}"
                                    style="width: 15%" readonly /> <input
                                    class="form-control mt-1"
                                    type="text" id="address"
                                    name="mainAddress" size="50"
                                    value="${fn:split(user.address, '/')[1]}"
                                    readonly /> <input
                                    class="form-control mt-1"
                                    type="text" name="detailAddress"
                                    value="${fn:split(user.address, '/')[2]}"
                                    readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="license">라이센스</label>
                                <input class="form-control" type="text"
                                    id="license" name="license"
                                    value="${user.license}" readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="account">어카운트</label>
                                <div class="flex">
                                    <select class="form-select"
                                        name="bank" size="1"
                                        style="width: 20%" disabled>
                                        <option value="">선택</option>
                                        <option value="KWANGJU"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'KWANGJU'}">selected</c:if>>광주</option>
                                        <option value="BNK"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'BNK'}">selected</c:if>>경남</option>
                                        <option value="KB"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'KB'}">selected</c:if>>국민</option>
                                        <option value="IBK"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'IBK'}">selected</c:if>>기업</option>
                                        <option value="NH"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'NH'}">selected</c:if>>농협</option>
                                        <option value="DGB"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'DGB'}">selected</c:if>>대구</option>
                                        <option value="BUSAN"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'BUSAN'}">selected</c:if>>부산</option>
                                        <option value="KDB"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'KDB'}">selected</c:if>>산업</option>
                                        <option value="MG"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'MG'}">selected</c:if>>새마을금고</option>
                                        <option value="SH"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'SH'}">selected</c:if>>수협</option>
                                        <option value="SOL"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'SOL'}">selected</c:if>>신한</option>
                                        <option value="ShinHyup"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'ShinHyup'}">selected</c:if>>신협</option>
                                        <option value="WOORI"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'WOORI'}">selected</c:if>>우리</option>
                                        <option value="PO"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'PO'}">selected</c:if>>우체국</option>
                                        <option value="JB"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'JB'}">selected</c:if>>전북</option>
                                        <option value="kakao"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'kakao'}">selected</c:if>>카카오뱅크</option>
                                        <option value="Toss"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'Toss'}">selected</c:if>>토스</option>
                                        <option value="KEB"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'KEB'}">selected</c:if>>하나</option>
                                        <option value="SC"
                                            <c:if test="${fn:split(user.account, '/')[0] == 'SC'}">selected</c:if>>SC제일</option>
                                    </select> <input class="form-control"
                                        type="text" id="account"
                                        name="bank_account"
                                        value="${fn:split(user.account, '/')[1]}"
                                        readonly />
                                </div>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="point">포인트</label>
                                <input class="form-control" id="point"
                                    name="point" type="text"
                                    value="${user.point}" readonly />
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="grade">등급</label>
                                <input class="form-control" id="grade"
                                    name="grade" type="text"
                                    value="${user.grade}" readonly />
                            </div>
                        </form>
                    </div>
                    <div class="card-footer" id="card-footer">
                        <c:url var="userModifyPage" value="/user/modify">
                            <c:param name="userid" value="${user.userid}" />
                        </c:url>
                        <a class="btn"
                            href="${userModifyPage}">수정하기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
					
				</script>
</body>
</html>
