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
<style type="text/css">
.flex {
    display: flex;
    gap: 10px;
}

#btnConfirm {
    padding: 0px 30px;
    white-space: nowrap;
}
</style>
</head>
<body>
    <div class="container-fluid">
        <c:set var="pageTitle" value="User Profile" scope="page" />

        <main>
            <div class="card mt-2">
                <div class="card-header">
                    <h2>내 정보</h2>
                </div>
                <div class="card-body">
                    <form id="modifyForm">
                        <div class="mt-2">
                            <label class="form-label" for="userid">Login Id</label>
                            <input class="form-control"
                                type="text" name="userid"
                                value="${user.userid}" readonly />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="password">Password</label>
                            <input class="form-control" id="password"
                                type="text" name="password"
                                value="${user.password}" readonly />
                            <input class="form-control mt-1" id="changePassword"
                                type="password" name="changePassword" />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="name">Name</label>
                            <input class="form-control" type="text"
                                name="name" value="${user.name}"
                                readonly />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="nickname">Nickname</label>
                            <div class="flex">
                                <input class="form-control"
                                    id="nickname" type="text"
                                    name="nickname"
                                    value="${user.nickname}" />
                                <button id="btnConfirm"
                                    class="btn btn-primary disabled">중복확인</button>
                            </div>
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="birth">Birth</label>
                            <c:set var="number" value="${user.birth}" />
                            <input class="form-control" type="text"
                                name="birth"
                                value="${fn:substring(number,0,4)}.${fn:substring(number,4,6)}.${fn:substring(number,6,8)}"
                                readonly />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="gender">Gender</label>
                            <c:choose>
                                <c:when test="${user.gender eq 0}">
                                    <input class="form-control"
                                        type="text" name="gender"
                                        value="male" readonly />
                                </c:when>
                                <c:otherwise>
                                    <input class="form-control"
                                        type="text" name="gender"
                                        value="female" readonly />
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="phone">Phone</label>
                            <div class="flex">
                                <select class="form-select"
                                    name="carrier" style="width: 20%">
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
                                </select> <input class="form-control" type="text"
                                    name="number"
                                    value="${fn:split(user.phone, '/')[1]}" />
                            </div>
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="email">Email</label>
                            <input class="form-control" type="email"
                                name="email" value="${user.email}"
                                readonly />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="address">Address</label>
                            <div class="flex">
                                <input class="form-control" type="text"
                                    id="postcode" name="postcode" size="5"
                                    value="${fn:split(user.address, '/')[0]}"
                                    style="width: 15%" readonly /> <input
                                    class="form-control"
                                    id="btnAddressSearch" type="button"
                                    value="우편번호검색" style="width: 15%" />
                            </div>
                            <input class="form-control mt-1" type="text"
                                id="mainAddress" name="mainAddress" size="50"
                                value="${fn:split(user.address, '/')[1]}"
                                readonly />
                            <input class="form-control mt-1" type="text"
                                id="detailAddress" name="detailAddress"
                                value="${fn:split(user.address, '/')[2]}" />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="license">License</label>
                            <input class="form-control" type="text"
                                name="license" value="${user.license}" />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="account">Account</label>
                            <div class="flex">
                                <select class="form-select" name="bank"
                                    size="1" style="width: 20%">
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
                                </select> <input class="form-control" type="text"
                                    name="bank_account"
                                    value="${fn:split(user.account, '/')[1]}" />
                            </div>
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="point">Point</label>
                            <input class="form-control" name="point"
                                type="text" value="${user.point}"
                                readonly />
                        </div>
                        <div class="mt-2">
                            <label class="form-label" for="grade">Grade</label>
                            <input class="form-control" name="grade"
                                type="text" value="${user.grade}"
                                readonly />
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <button id="btnUpdate"
                        class="btn btn-outline-success">저장</button>
                </div>
            </div>
        </main>
    </div>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

    <!-- Axio JS 라이브러리 -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <script
        src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <c:url var="user_profile_modify_js"
        value="/js/user_profile_modify.js" />
    <script src="${user_profile_modify_js}"></script>
</body>
</html>
