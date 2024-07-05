<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>새 조인 작성</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />
<style>
body {
	background-color: #ffffff;
	font-family: 'Noto Sans KR', sans-serif;
}

.container {
	max-width: 1000px;
	margin-top: 30px;
}

.card {
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #ffffff;
}

.card-header {
	background-color: #2A7E50;
	color: white;
	border-top-left-radius: 15px;
	border-top-right-radius: 15px;
}

.card-title {
	margin-bottom: 0;
}

.post-info {
	font-size: 0.9rem;
	color: #6c757d;
}

.post-content {
	background-color: #f8f9fa;
	border-radius: 15px;
	padding: 20px;
	margin-bottom: 20px;
}

.btn-like {
	background-color: #ff6b6b;
	border: none;
	transition: all 0.3s ease;
}

.btn-like:hover {
	background-color: #ff4757;
	transform: scale(1.05);
}

.comment-form {
	margin-bottom: 20px;
}

.comment-list {
	max-height: 300px;
	overflow-y: auto;
}

.comment {
	border-bottom: 1px solid #dee2e6;
	padding: 10px 0;
}

.comment:last-child {
	border-bottom: none;
}

.btn-custom {
	height: 50px;
	padding: 10px 20px;
}

.position-relative {
	position: relative;
}

.center-btn {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
}
</style>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>
<body>
	<main class="container">
		<div class="mt-2 card">
			<div class="card-header">
				<h2>새 조인 작성하기</h2>
			</div>
			<div>
				<c:url var="listUrl" value="join_main" />
				<a href="${listUrl}" class="btn btn-link"><i class="bi bi-list"></i>
					메인으로</a>
			</div>
			<div class="card-body">
				<c:url var="joinCreatePage" value="/join/join_create" />
				<form method="post" action="${joinCreatePage}">
					<div class="mt-2">
						<input class="form-control" type="text" name="title"
							placeholder="골프장 입력" required autofocus />
					</div>
					<div class="mt-2">
						<div class="input-group">
							<input id="address" class="form-control" type="text"
								name="gcadress" placeholder="주소 입력" required />
							<button type="button" class="btn btn-outline-secondary"
								onclick="execDaumPostcode()">주소 검색</button>
						</div>
						<div>
							<input type="hidden" name="category" value="P003" /> <input
								type="hidden" name="clubtype" value="DR" />
						</div>
					</div>
					<div class="mt-2">
						<input class="form-control" type="datetime-local" name="teeoff"
							placeholder="티오프" required />
					</div>
					<div class="mt-2">
						<input class="form-control" type="number" name="greenfee"
							placeholder="그린 피 입력" required />
					</div>
					<div class="mt-2">
						<input class="form-control" type="number" name="hole"
							placeholder="홀수 입력" required />
					</div>
					<div class="mt-2">
						<input class="form-control" type="text" name="author"
							placeholder="작성자" required />
					</div>
					<div class="mt-2">
						<textarea class="form-control" rows="5" name="content"
							placeholder="내용 및 연락처 , 인원수 등 입력" required></textarea>
					</div>
					<div class="mt-2">
						<input class="form-control btn btn-outline-success" type="submit"
							value="저장" />
					</div>
				</form>
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
