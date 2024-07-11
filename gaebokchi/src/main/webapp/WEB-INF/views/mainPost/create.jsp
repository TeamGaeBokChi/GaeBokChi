<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<title>게시물 작성</title>
<style>
	body{
	padding-top:100px;
	}
</style>
</head>
<body>
	<div class="container-fluid" ]>
			<c:set var="pageTitle" value="새글 작성하기" />
		<%@ include file="../fragments/header.jspf"%>

		<main>
			<div class="mt-2 card form-control">
				<div class="card-header form-control">
					<h2>새 글 작성하기</h2>
				</div>
				<div class="card-body form-control">
					<c:url var="mainPostCreate" value="/mainPost/create" />
					<form method="post" action="${mainPostCreate}" enctype="multipart/form-data">
						<!-- 카테고리 선택 + 제목 영역 -->
						<div class="mt-2 row">
							<div class="col-2">
								<select id="clubType" class="form-control" name="clubType">
								<c:forEach items="${clubs}" var="c">
									<option value="${c.id}">${c.name}</option>
								</c:forEach>
								</select>
							</div>
							<div class="col-8">
								<input id="title" class="form-control" type="text" name="title" placeholder="제목을 입력하세요." />
							</div>
							<div class="col-2">
								<input id="author" class="form-control d-none" type="text" name="author" placeholder="작성자 코드값" required value="${signedInUser}"/>
							</div>
						</div>
						<!-- 내용 본문 영역 -->
						<div class="container">
							<div class="mt-2 row">
								<div class="col-md-2">
									<input id="height" class="form control" name="height" type="number" placeholder="키 입력" maxlength="3"/>
								</div>
								<div class="col-md-2">
									<input id="career" class="form control" name="career" type="number" placeholder="구력 입력" maxlength="3"/>
								</div>
								<div class="col-md-2">
									<input id="handy" class="form control" name="handy" type="number"  step="0.1" placeholder="평균 핸디 입력" maxlength="4"/>
								</div>
								<div class="col-md-2">
									<input id="ironDistance" class="form control" name="ironDistance" type="number" placeholder="7번 아이언 평균 비거리" maxlength="3"/>
								</div>
								<div class="col-md-2">
									<input id="driverDistance" class="form control" name="driverDistance" type="number" placeholder="드라이버 평균 비거리" maxlength="3"/>
								</div>
							</div>
						</div>
						<div>
							<textarea class="mt-2 form-control" name=content rows="15"
								placeholder="동영상에 대한 설명과 코칭 받고 싶은 부분을 상세히 적어주세요." required></textarea>
						</div>

						<!-- 영상 업로드 영역 -->
						<div class="form-group mt-2">
							<input id="media" type="file" accept="video/*" class="form-control-file" name="media" required />
						</div>
						<!-- 하단 버튼 영역 -->
						<div class="mt-2 d-flex justify-content-end">
							<div>
								<input class="m-2 btn btn-outline-primary" type="submit"
									value="작성완료"/>
							</div>
							<div>
								<button class="m-2 btn btn-outline-primary" id="preview"
									type="button">미리 보기</button>
							</div>
							<div>
								<button class="m-2 btn btn-outline-primary" id="btnMainPostList"
									type="button">목록보기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</main>

	</div>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

	
	
</body>
</html>