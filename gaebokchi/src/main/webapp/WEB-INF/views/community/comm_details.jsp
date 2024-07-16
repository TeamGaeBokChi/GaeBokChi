<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>커뮤니티｜GOLFRO</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
    rel="stylesheet">
<link rel="stylesheet" href="../css/comm_details.css" />
</head>
<body>
    <div class="container-fluid">
        <header>
            <%@ include file="../fragments/header.jspf"%>
        </header>
        <div class="card border-0">
            <h3>
                <a href="comm_main">전체글</a>
            </h3>

            <div class="card-header">

                <small>${category_name[post.category]}</small> <input
                    type="hidden" id="postId" value="${post.id}" />
                <h2 class="card-title">${post.title}</h2>
                <span><i class="bi bi-person"></i>${userNicknames[post.author]}
                </span> <small class="text-black">${post.formattedCreatedTime}</small>
            </div>


            <div class="card-body">
                <div class="post-info d-flex justify-content-between">

                    <span><i class="bi bi-eye"></i> ${post.views}</span>
                    <span><i class="bi bi-hand-thumbs-up"></i> <span
                        id="likesCount">${post.likes}</span></span> <span><i
                        class="bi bi-chat-dots"></i> ${commentcount}</span>
                </div>



                <div class="post-content">
                    <c:if test="${not empty post.media}">
                        <div class="image-container">
                            <c:url var="mediaUrl"
                                value="/community/media/${post.media}" />
                            <img alt="" src="${mediaUrl}"
                                class="img-fluid max-size">
                        </div>
                    </c:if>
                    <div>${post.content}</div>
                </div>
                <c:if test="${post.author ne loggedInUser.userid}">
                    <div class="position-relative mb-4 text-center">
                        <c:choose>
                            <c:when test="${not empty loggedInUser}">
                                <!-- 로그인한 사용자가 있을 때의 버튼 -->
                                <button id="btnLikes"
                                    class="btn btn-like btn-lg btn-custom">
                                    좋아요</button>
                            </c:when>
                            <c:otherwise>
                                <!-- 로그인한 사용자가 없을 때의 처리 -->
                                <button id="btnLikes-notloggedIn"
                                    class="btn btn-like btn-lg btn-custom">좋아요</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <div class="lastbtn d-flex justify-content-end mt-2">
                    <c:url var="postModifyPage"
                        value="/community/comm_modify">
                        <c:param name="id" value="${post.id}" />
                    </c:url>
                    <c:if
                        test="${post.author eq loggedInUser.userid or loggedInUser.userid eq 'admin'}">
                        <form action="${postModifyPage}" method="get"
                            style="display: inline;">
                            <input type="hidden" name="id"
                                value="${post.id}" />
                            <button type="submit"
                                class="m-2 btn">수정하기</button>
                        </form>
                        <input type="hidden" name="postId"
                            value="${post.id}" />
                        <button id="btnDelete"
                            class="m-2 btn">삭제하기</button>
                    </c:if>
                </div>
            </div>





            <c:if test="${not empty loggedInUser}">
                <form class="comment-form">
                    <small>댓글</small>
                    <div class="d-flex justify-content-center">
                        <div
                            class="input-group d-flex justify-content-between mb-3">
                            <div class="col-2">
                                <input name="author" type="hidden"
                                    class="form-control"
                                    value="${loggedInUser.userid}">
                            </div>
                            <div class="row w-100 mt-3">
                                <div class="col-10">
                                    <textarea name="content"
                                        id="content"
                                        class="form-control" rows="3"
                                        placeholder="댓글을 입력하세요"></textarea>
                                </div>
                                <div class="col-2">
                                    <input type="hidden" name="postId"
                                        value="${post.id}">
                                    <button id="btnRegisterComment"
                                        class="btn btn-success btn-register-comment"
                                        type="submit">등록</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </c:if>
            <!-- 포커싱할 댓글 id -->
            <input type="hidden" id="commentId" value="${commentId}" />
            <div class="comment-list">
                <c:forEach var="comment" items="${commentlist}">
                    <div class="comment" id="comment-${comment.id}">
                        <b>${userNicknames[comment.author]}</b>
                        <p>${comment.content}</p>
                        <div>
                            <small class="text-muted">${comment.formattedModifiedTime}</small>
                            <input type="hidden" name="commentId"
                                value="${comment.id}">
                            <c:if
                                test="${comment.author eq loggedInUser.userid or loggedInUser.userid eq 'admin'}">
                                <button id="btnUpdateComment"
                                    class="btn btn-success btn-register-comment"
                                    type="submit">수정</button>
                                <input type="hidden" name="commentId"
                                    value="${comment.id}">
                                <button id="btnDeleteComment"
                                    class="btn btn-success btn-register-comment"
                                    type="submit">삭제</button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div
                class="btnList d-flex justify-content-between mt-2 mb-4"
                id="btnList">
                <c:url var="previousPostUrl"
                    value="/community/comm_details">
                    <c:param name="id"
                        value="${previousPost != null ? previousPost.id : ''}" />
                </c:url>
                <a href="${previousPostUrl}"
                    class="btn btn-outline-secondary ${previousPost == null ? 'disabled' : ''}">
                    <i class="bi bi-chevron-left"></i> 이전 글
                </a>
                <c:url var="listUrl" value="comm_main" />
                <a href="${listUrl}" class="btn btn-outline-secondary"><i
                    class="bi bi-list"></i> 목록으로</a>
                <c:url var="nextPostUrl" value="/community/comm_details">
                    <c:param name="id"
                        value="${nextPost != null ? nextPost.id : ''}" />
                </c:url>
                <a href="${nextPostUrl}"
                    class="btn btn-outline-secondary ${nextPost == null ? 'disabled' : ''}">
                    다음 글 <i class="bi bi-chevron-right"></i>
                </a>
            </div>
        </div>

    </div>

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <c:url var="comm_details_js" value="/js/comm_details.js" />
    <script src="${comm_details_js}"></script>
</body>
</html>
