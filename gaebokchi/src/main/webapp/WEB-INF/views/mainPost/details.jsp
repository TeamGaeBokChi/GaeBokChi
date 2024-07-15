<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Golfro</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">


<link rel="stylesheet" href="../css/main_details.css" />

</head>

<body>
    <header>
        <c:set var="pageTitle" value="새글 작성하기" />
        <%@ include file="../fragments/header.jspf"%>
    </header>

    <main>
        <div class="container">
            <div class="card border-0">
                <h2>LESSON</h2>
                <h7>골프에 대해 궁금한 점들을 물어보세요.</h7>

                <div class="card-header border-0 form-control">
                    <div class="mb-2">
                        <span class="cl"> 클럽종류 / </span> <span
                            class="club"> ${post.clubType}</span>
                    </div>
                    <div class="mb-3">
                        <span id="detailsTitle">${post.title}</span>
                    </div>

                    <div class="nick-date">
                        <div class="nickname mb-1">
                            <span> ${post.nickname}</span>
                        </div>
                        <div class="sub">
                            <div class="date-container">
                                <p>작성시간 ${post.formattedCreatedTime}</p>
                                <p>수정시간
                                    ${post.formattedModifiedTime}</p>
                            </div>

                            <div class="views-likes-container">
                                <span><i class="bi bi-eye"></i>
                                    ${post.views}</span>
                                <button id="likes"
                                    class="likes bi bi-hand-thumbs-up"></button>
                                <p id="likesCounts">${post.likes}</p>

                            </div>
                        </div>
                    </div>
                </div>


                <div class="mainTextArea">
                    <div class="left">
                        <video class="video-container" autoplay controls
                            loop>
                            <c:url var="videoUrl"
                                value="/mainPost/video">
                                <c:param name="file"
                                    value="${post.media}" />
                            </c:url>
                            <source src="${videoUrl}" type="video/mp4">
                            <source src="${videoUrl}" type="video/mov">
                            <source src="${videoUrl}" type="video/wmv">
                            <source src="${videoUrl}" type="video/avi">
                            <source src="${videoUrl}" type="video/mkv">
                        </video>
                    </div>
                    <div class="right form-control">
                        <div class="post-content mt-2 text-center">
                            <div class="mb-1 mt-1 border-0">

                                <c:choose>
                                    <c:when test="${empty post.height}">
                                        <span>키: 데이터 없음 /</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>키: ${post.height}cm
                                            /</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${empty post.career}">
                                        <span>구력: 데이터 없음 /</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>구력: ${post.career}년
                                            /</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${empty post.handy}">
                                        <span>헨디: 데이터 없음 /</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>헨디: ${post.handy} /</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when
                                        test="${empty post.ironDistance}">
                                        <span>아이언 평균 거리: 데이터 없음 /</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>아이언 평균 거리:
                                            ${post.ironDistance}m /</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when
                                        test="${empty post.driverDistance}">
                                        <span>드라이버 평균 거리: 데이터 없음</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>드라이버 평균 거리:  
                                            ${post.driverDistance}m</span>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                            <div class="post-content">
                                <p>${post.content}</p>
                            </div>







                            <!-- 포커싱할 댓글 id -->
                            <input type="hidden" id="commentId"
                                value="${commentId}" />


                            <!-- 댓글 리스트 영역 -->
                            <div class="comments-section form-control mb-3"></div>

                            <!-- <form action="submit_comment_url" method="post"> -->
                            <div class="form-group">
                                <input class="form-control mt-2"
                                    type="hidden" id="signedInUser"
                                    required value="${signedInUser}" />
                                <input type="hidden" id="postId"
                                    value="${post.id}" />
                                <c:choose>
                                    <c:when
                                        test="${signedInUserGrade eq 'G10'}">
                                        <textarea class="form-control"
                                            id="content" name="ctext"
                                            rows="3" required
                                            placeholder="피드백을 작성해주세요."></textarea>
                                    </c:when>
                                    <c:otherwise>
                                        <textarea class="form-control"
                                            id="finishContent"
                                            readonly="readonly">전문가 승인이 완료 된 회원만 작성 할 수 있습니다.</textarea>
                                    </c:otherwise>
                                </c:choose>
                                <c:if
                                    test="${signedInUserGrade eq 'G10'}">
                                    <button id="btnRegisterComment"
                                        class="btn form-control">피드백
                                        작성하기</button>
                                </c:if>
                            </div>


                            <!-- 하단 수정하기, 삭제 버튼 영역 -->
                            <c:if
                                test="${signedInUser eq post.author or signedInUser eq 'admin'}">
                                <div
                                    class="mt-2 d-flex justify-content-end"
                                    id="btnFoot">
                                    <div>
                                        <!-- 수정 -->
                                        <button
                                            class="btn btn-outline-primary btnModifyid">수정하기</button>
                                        <!-- 삭제 -->
                                        <button
                                            class="btn btn-outline-danger btnDeleteMainPost">삭제</button>
                                    </div>
                                </div>
                                <c:url var="commentsSubJS"
                                    value="/js/commentsSub.js" />
                                <script src="${ commentsSubJS }"></script>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
    </main>




    <!-- 부트스트랩 -->
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <c:url var="commentsJS" value="/js/comments.js" />
    <script src="${ commentsJS }"></script>



    <script>
					const signedInUser = "${signedInUser}";
					const postAuthor = "${post.author}";
				</script>


</body>
</html>