<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Golfro</title>
    <c:url var="profileUpdate" value="../css/profile_style.css" />
    <link rel="stylesheet" href="${profileUpdate}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
    <header>
        <%@ include file="../fragments/header.jspf"%>
    </header>

    <div class="container">
        <div class="row">
            <%@ include file="../fragments/menu.jspf" %>
            
            <div class="col-8">
                <h3 class="bold_title">프로필 관리</h3>
                <div class="bottom_line">
                    <div class="info_card">
                        <div class="user_image m-4">
                            <input type="hidden" id="imagePath" value="${user.image}" />
                            <img id="image" src="" alt="Uploaded Image">
                                
                            <script>
                            	// 이미지 URL을 가져와서 이미지 태그에 설정
                                var file = document.getElementById('imagePath').value;
                                var imageUrl = './file/image?file=' + encodeURIComponent(file);  // 이미지 파일명에 맞게 설정
                                    
                                fetch(imageUrl)
                                	.then(response => response.blob())
                                    .then(blob => {
                                        var reader = new FileReader();
                                        reader.onload = function() {
                                            document.getElementById('image').src = reader.result;
                                        };
                                        reader.readAsDataURL(blob);
                                    })
                                    .catch(error => {
                                        console.error('Error fetching image:', error);
                                 	});
    						</script>
                        </div>
                        <div>
                            <h5 id="titleNickname" class="user_data m-0">${user.nickname}</h5>
                            <input type="hidden" id="userid" value="${user.userid}" />
                            <div>
                                <label id="fileUpload" class="mt-2 btn active" for="input_file">이미지 변경</label>
                                <a class="mt-2 btn active" id="fileRemove">삭제</a>
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
                                <input id="introduce" type="text" class="input_none basic_font" value="${user.career}" placeholder="나를 소개하세요" readonly />
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
    
    <c:url var="profile_management_js" value="/js/profile_management.js" />
    <script src="${profile_management_js}"></script>
</body>
</html>