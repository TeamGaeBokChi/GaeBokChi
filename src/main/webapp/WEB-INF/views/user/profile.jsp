<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Golfro</title>
    <c:url var="profileUpdate" value="/css/profile_style.css" />
    <link rel="stylesheet" href="${profileUpdate}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <div class="row">
            <%@ include file="../fragments/menu.jspf" %>
            
            <div class="col-8">
                <h3 class="bold_title">프로필 관리</h3>
                <div class="bottom_line">
                    <div class="info_card">
                        <div class="user_image m-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                            </svg>
                        </div>
                        <div>
                            <h5 class="user_data m-0">${user.nickname}</h5>
                            <input id="userid" value="${user.userid}" class="d-none"/>
                            <div>
                                <label class="mt-2 btn active" for="input_file">이미지 변경</label>
                                <c:url var="userRemoveImage" value="/user/remove" />
                                <a class="mt-2 btn active" href="${userRemoveImage}">삭제</a>
                                <input type="file" id="input_file" name="input_file" class="d-none" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <h4 class="bold_title mt-5">프로필 정보</h4>
                <div class="mt-3">
                    <h6 class="small_title">프로필 이름</h6>
                    <div class="container">
                        <div class="row">
                            <div class="bottom_line col-5 p-0">
                                <input id="nickname" type="text" class="input_none basic_font" value="${user.nickname}" readonly />
                            </div>
                            <div class="col-5">
                                <button type="button" id="btnNicknameUpdate" class="btn active">변경</button>
                            </div>
                        </div>
                        <div class="mt-2 d-none" id="btnNicknameGroup">
                            <button type="button" class="btn active" id="btnCancelNickname">취소</button>
                            <button type="button" class="btn active" id="btnSaveNickname">저장</button>
                        </div>
                    </div>
                </div>
                <div class="mt-5">
                    <h6 class="small_title">수상 경력</h6>
                    <div class="container">
                        <div class="row">
                            <div class="bottom_line col-5 p-0">
                                <input id="introduce" type="text" class="input_none basic_font" placeholder="나를 소개하세요" readonly />
                            </div>
                            <div class="col-5">
                                <button type="button" id="btnIntroduceMyself" class="btn active">변경</button>
                            </div>
                        </div>
                        <div class="mt-2 d-none" id="btnIntroduceGroup">
                            <button type="button" class="btn active" id="btnCancelIntroduce">취소</button>
                            <button type="button" class="btn active" id="btnSaveIntroduce">저장</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    
    <c:url var="profile_management_js" value="/js/profile_management.js" />
    <script src="${profile_management_js}"></script>
</body>
</html>