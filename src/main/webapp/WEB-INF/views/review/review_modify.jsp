<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>수정하기</title>
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
	height: 500px; /* 에디터 높이 조정 */
}
</style>
</head>
<body>
	<div class="container-fluid">
		<header class="toolbar">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<c:url var="reviewMainPage" value="/review/review_main" />
					<a class="navbar-brand" href="${reviewMainPage}">메인</a>
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
					<form id="modifyForm">
						<input type="hidden" name="id" value="${post.id}" />
						<div class="row mb-3">
							<div class="col-auto">
								<select class="form-control" name="category" id="categorySelect">
									<option value="P002">리뷰</option>
								</select>
							</div>
							<div class="col">
								<input class="form-control" type="text" name="title"
									value="${post.title}" required autofocus />
							</div>
						</div>
						<div class="mb-3">
							<div id="editor-container"></div>
							<textarea name="content" id="content" style="display: none;">${post.content}</textarea>
						</div>

						<div class="row mb-3">
							<div class="col">
								<input class="form-control" type="file" name="photo" />
							</div>
						</div>
						<div class="d-grid gap-2">
							<button id="btnUpdate" class="btn btn-outline-success"
								type="button">업데이트</button>
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

	<c:url var="comm_modify_js" value="/js/comm_modify.js" />
	<script src="${comm_modify_js}"></script>

	<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
	<script>
		var quill = new Quill('#editor-container', {
			theme : 'snow',
			modules : {
				toolbar : [ [ {
					'font' : []
				} ], [ {
					'size' : [ 'small', false, 'large', 'huge' ]
				} ], [ {
					'header' : [ 1, 2, 3, 4, 5, 6, false ]
				} ], [ 'bold', 'italic', 'underline', 'strike' ], [ {
					'color' : []
				}, {
					'background' : []
				} ], [ {
					'list' : 'ordered'
				}, {
					'list' : 'bullet'
				} ], [ {
					'align' : []
				} ], [ 'video' ], [ 'clean' ] ]
			}
		});

		// Quill 에디터에서 입력된 내용의 길이 체크 및 제한
		quill.on('text-change', function(delta, oldDelta, source) {
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

		var content = document.querySelector('textarea[name=content]').value;
		quill.root.innerHTML = content;

		// 폼 제출 시 Quill 에디터의 내용을 숨은 textarea에 설정
		document.querySelector('form').onsubmit = function() {
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
			reader.onload = function() {
				var output = document.getElementById('imagePreview');
				output.src = reader.result;
				output.style.display = 'block';
			};
			reader.readAsDataURL(event.target.files[0]);
		}
	</script>
</body>
</html>
