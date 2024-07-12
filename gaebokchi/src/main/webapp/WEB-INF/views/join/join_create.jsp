<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>조인｜GOLFRO</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous" />
<link rel="stylesheet" href="../css/join_create.css" />
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>
<body>
    <header>
        <%@ include file="../fragments/header.jspf"%>
    </header>

    <main>
        <div class="container">

            <div class="card border-0">
                <div class="card-header border-0 form-control">
                    <div
                        style="display: inline-block; margin-right: 10px;">
                        <h3 style="display: inline;">모임 구하기</h3>
                    </div>
                    <div style="display: inline-block;">
                        <p style="display: inline;">같이 골프쳐요!</p>
                    </div>
                </div>



                <div class="card-body form-control border-0">
                    <c:url var="joinCreatePage"
                        value="/join/join_create" />
                    <form method="post" action="${joinCreatePage}">
                        <div class="mt-2">
                            <span>골프장</span> <input
                                class="form-control mt-2 mb-4"
                                type="text" name="title"
                                placeholder="골프장 입력" required autofocus />
                        </div>
                        <div class="mt-2">
                            <span>주소</span>
                            <div class="input-group mt-2 mb-4">
                                <input id="address" class="form-control"
                                    type="text" name="gcadress"
                                    placeholder="주소 입력" required />
                                <button type="button" class="btn"
                                    onclick="execDaumPostcode()">주소
                                    검색</button>
                            </div>
                            <div>
                                <input type="hidden" name="category"
                                    value="P003" />
                            </div>
                        </div>
                        <div class="mt-2">
                            <span>날짜</span> <input
                                class="form-control mt-2 mb-4"
                                type="datetime-local" name="teeoff"
                                placeholder="티오프" required />
                        </div>
                        <div class="mt-2">
                            <span>그린 피</span> <input
                                class="form-control mt-2 mb-4"
                                type="number" name="greenfee"
                                placeholder="그린 피 입력" required />
                        </div>
                        <div class="mt-2">
                            <span>홀수</span> <input
                                class="form-control mt-2 mb-4"
                                type="number" name="hole"
                                placeholder="홀수 입력" required />
                        </div>
                        <div class="mt-2">
                            <input class="form-control" type="hidden"
                                name="author"
                                value="${loggedInUser.userid}" required />
                        </div>
                        <div class="mt-2">
                            <span>상세 설명</span>
                            <textarea class="form-control mt-2 mb-4"
                                rows="5" name="content"
                                placeholder="내용 및 연락처 , 인원수 등 입력"
                                required></textarea>
                        </div>
                        <!-- 하단 버튼 영역 -->
                        <div
                            class="lastbtn mt-2 d-flex justify-content-end">
                            <div>
                                <a href="join_main"
                                    class="m-2 btn">취소하기</a>
                            </div>
                            <div>
                                <input class="m-2 btn" type="submit"
                                    id="submit" value="작성완료" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <script>
		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					var addr = data.address;
					document.getElementById('address').value = addr;
				}
			}).open();
		}
	</script>
    <script>
    	   document.addEventListener('DOMContentLoaded', () => {
    	        const form = document.querySelector('form'); // 폼 요소 가져오기

    	        // 제목, 그린피, 홀수, 내용 입력란
    	        const title = document.querySelector('input[name="title"]');
    	        const greenfee = document.querySelector('input[name="greenfee"]');
    	        const hole = document.querySelector('input[name="hole"]');
    	        const content = document.querySelector('textarea[name="content"]');

    	        // 제목, 그린피, 홀수 입력란 길이 체크 이벤트 리스너
    	        title.addEventListener('input', function() {
    	            if (title.value.trim().length > 20) {
    	                alert('골프장명은 20자 이내로 입력해주세요!');
    	                title.value = title.value.trim().substring(0, 20);
    	            }
    	        });

    	        greenfee.addEventListener('input', function() {
    	            if (greenfee.value.trim().length > 6) {
    	                alert('그린피는 10만원 단위 이내로 입력해주세요!');
    	                greenfee.value = greenfee.value.trim().substring(0, 6);
    	            }
    	        });

    	        hole.addEventListener('input', function() {
    	            if (hole.value.trim().length > 2) {
    	                alert('홀은 2자리로 입력해주세요!');
    	                hole.value = hole.value.trim().substring(0, 2);
    	            }
    	        });

    	        content.addEventListener('input', function() {
    	            if (content.value.trim().length > 1000) {
    	                alert('내용은 1000자 이내로 입력해주세요!');
    	                content.value = content.value.trim().substring(0, 1000);
    	            }
    	        });
    });
</script>


    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
