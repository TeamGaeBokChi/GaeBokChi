<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>새 글 쓰기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
	rel="stylesheet">
<style>
body {
	background-color: #ffffff;
	display: flex;
	justify-content: center;
	padding: 20px;
}

.container-fluid {
	background-color: white;
	border-radius: 10px;
	padding: 20px;
	max-width: 1000px; /* 페이지를 더 넓게 조정 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-header {
	background-color: #2A7E50;
}

.btn-outline-success {
	color: #28a745;
	border-color: #28a745;
}

.btn-outline-success:hover {
	background-color: #28a745;
	color: white;
}

.toolbar {
	margin-bottom: 20px;
}

#editor-container {
	height: 600px; /* 에디터 높이 조정 */
}

#imagePreview {
	max-width: 100%;
	max-height: 300px;
	display: none;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<header class="toolbar">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<c:url var="reviewMainPage" value="/review/review_main" />
					<a class="navbar-brand" href="${commMainPage}">메인으로</a>
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarNav"
						aria-controls="navbarNav" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
				</div>
			</nav>
		</header>
		<main>
			<div class="mt-2 card">
				<div class="card-header">
					<h2></h2>
				</div>
				<div class="card-body">
					<c:url var="reviewPostCreatePage" value="/review/review_create" />
					<form method="post" action="${reviewPostCreatePage}"
						enctype="multipart/form-data">
						<div class="row mb-3">
							<div class="col-auto">
								<select class="form-control" name="category" id="categorySelect"
									required>
									<option value="P004">리뷰</option>
								</select>
							</div>
							<div class="col">
								<input class="form-control mb-2" type="text" name="title"
									placeholder="제목 입력" required autofocus /> <input
									class="form-control mb-2" type="text" name="author"
									placeholder="작성자" required /> <input class="form-control mb-2"
									type="text" name="clubtype" placeholder="클럽타입" required />
							</div>
						</div>
						<div class="mb-3">
							<div id="editor-container"></div>
							<textarea name="content" id="content" style="display: none;"></textarea>
						</div>
						<div class="row mb-3">
							<div class="col">
								<input class="form-control" type="file" name="media"
									id="mediaFile" accept="image/*" onchange="previewImage(event)" />
							</div>
						</div>
						<div class="row mb-3">
							<div class="col">
								<img id="imagePreview" alt="사진 미리보기" />
							</div>
						</div>
						<div class="d-grid gap-2">
							<input class="btn btn-outline-success" type="submit" value="저장" />
						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
	<script>
    var quill = new Quill('#editor-container', {
        theme: 'snow',
        modules: {
            toolbar: [
                [{ 'font': [] }],
                [{ 'size': ['small', false, 'large', 'huge'] }],
                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                ['bold', 'italic', 'underline', 'strike'],
                [{ 'color': [] }, { 'background': [] }],
                [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                [{ 'align': [] }],
                ['video'],
                ['clean']
            ]
        }
    });

    // Quill 에디터에서 입력된 내용의 길이 체크 및 제한
    quill.on('text-change', function (delta, oldDelta, source) {
        if (source === 'user') {
            var quillContent = quill.root.innerHTML;
            
            // 내용 길이 체크
            if (quillContent.length > 1000) {
                alert('내용은 1000자 이내로 입력해주세요!');
                // 에디터의 내용을 1000자 이내로 잘라냄
                quill.deleteText(1000, quill.getLength());
            }
        }
    });

    // 폼 제출 시 Quill 에디터의 내용을 숨은 textarea에 설정
    document.querySelector('form').onsubmit = function () {
        var content = document.querySelector('textarea[name=content]');
        // Quill 에디터의 현재 내용 가져오기
        var quillContent = quill.root.innerHTML;
        
        // 내용 길이 체크
        if (quillContent.length > 1000) {
            alert('내용은 1000자 이내로 입력해주세요!');
            return false; // 폼 제출을 막음
        }
        
        content.value = quillContent; // 폼 데이터에 할당
    };

    function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function () {
            var output = document.getElementById('imagePreview');
            output.src = reader.result;
            output.style.display = 'block';
        };
        reader.readAsDataURL(event.target.files[0]);
    }

 	   document.addEventListener('DOMContentLoaded', () => {
	        const form = document.querySelector('form'); // 폼 요소 가져오기
	        // 제목, 내용
	        const title = document.querySelector('input[name="title"]');
	        // 제목, 내용 길이 체크 이벤트 리스너
	        title.addEventListener('input', function() {
	            if (title.value.trim().length > 20) {
	                alert('제목은 20자 이내로 입력해주세요!');
	                title.value = title.value.trim().substring(0, 20);
	            }
	        });
 	   });
    </script>
</body>
</html>
