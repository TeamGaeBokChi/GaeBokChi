<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>GOLFRO</title>
<c:url var="footer" value="css/footer.css" />
<link rel="stylesheet" type="text/css" href="${footer}">
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous" />

<c:url var="mainCss" value="css/main.css" />
<link rel="stylesheet" type="text/css" href="${mainCss}">

</head>

<body>
    <div class="container-fluid">
        <c:set var="pageTitle" value="Home" scope="page" />
        <%@ include file="./fragments/header.jspf"%>
    </div>

    <section class="header container-fluid">
        <div class="title">
            <c:url var="mainTitle" value="images/main.png" />
            <img src="${mainTitle}" alt="main picture"
                style="object-fit: cover; width: 100%; height: 100%;">
        </div>
    </section>

    <main>

        <!--------------- 글럽별 레슨받기 ------------------>
        <section class="image-category container">
            <h2>클럽별 레슨받기</h2>
            <ul class="row list-unstyled" id="clubCategory">
                <li class="col-md-2 col-6">
                    <div class="card text-center">
                        <a
                            href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=WG&textSearchSelect=&selectSelection=selectFalse">
                            <img src="images/웨지.png"
                            class="card-img-top" alt="Category 2">
                            <div class="card-body">
                                <h5 class="card-title">웨지</h5>
                            </div>
                        </a>
                    </div>
                </li>
                <li class="col-md-2 col-6">
                    <div class="card text-center">
                        <a
                            href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=UT&textSearchSelect=&selectSelection=selectFalse">
                            <img src="images/유틸.png"
                            class="card-img-top" alt="Category 3">
                            <div class="card-body">
                                <h5 class="card-title">유틸</h5>
                            </div>
                        </a>
                    </div>
                </li>
                <li class="col-md-2 col-6">
                    <div class="card text-center">
                        <a
                            href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=WD&textSearchSelect=&selectSelection=selectFalse">
                            <img src="images/우드.png"
                            class="card-img-top" alt="Category 4">
                            <div class="card-body">
                                <h5 class="card-title">우드</h5>
                            </div>
                        </a>
                    </div>
                </li>
                <li class="col-md-2 col-6">
                    <div class="card text-center">
                        <a
                            href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=IR&textSearchSelect=&selectSelection=selectFalse">
                            <img src="images/아이언.png"
                            class="card-img-top" alt="Category 5">
                            <div class="card-body">
                                <h5 class="card-title">아이언</h5>
                            </div>
                        </a>
                    </div>
                </li>
                <li class="col-md-2 col-6">
                    <div class="card text-center">
                        <a
                            href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=DR&textSearchSelect=&selectSelection=selectFalse">
                            <img src="images/드라이버.png"
                            class="card-img-top" alt="Category 6">
                            <div class="card-body">
                                <h5 class="card-title">드라이버</h5>
                            </div>
                        </a>
                    </div>
                </li>
                <li class="col-md-2 col-6">
                    <div class="card text-center">
                        <a
                            href="/gaebokchi/mainPost/search?userid=&searchCategory=searchClubs&clubSelect=PT&textSearchSelect=&selectSelection=selectFalse">
                            <img src="images/퍼터.png"
                            class="card-img-top" alt="Category 6">
                            <div class="card-body">
                                <h5 class="card-title">퍼터</h5>
                            </div>
                        </a>
                    </div>
                </li>
            </ul>
        </section>

        <!--------------- 프로 랭킹 및 광고 ------------------>

        <section class="meet-pro container">
            <h2>인기 순위</h2>
            <div class="meet-pro-box">
                <div class="pro-rank text-center">
                    <h4>실시간 프로 랭킹</h4>
                    <div class="rank">
                        <table class="text-center">

                            <tr>
                                <th>순위</th>
                                <th></th>
                                <th>이름</th>
                                <th>보유 포인트</th>
                            </tr>

                            <c:forEach items="${rank}" var="r" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>
                                        <div class="rank-thum">
                                            <input type="hidden" id="imagePath-${status.index}" value="${r.image}" />
                                            <img id="image-${status.index}" class="profile-image" src="" alt="Uploaded Image">
                                            
                                            <script>
                                                // 이미지 URL을 가져와서 이미지 태그에 설정
                                                var file = document.getElementById('imagePath-${status.index}').value;
                                                var imageUrl = './user/file/image?file=' + encodeURIComponent(file);  // 이미지 파일명에 맞게 설정
                                                    
                                                fetch(imageUrl)
                                                    .then(response => response.blob())
                                                    .then(blob => {
                                                        var reader = new FileReader();
                                                        reader.onload = function() {
                                                            document.getElementById('image-${status.index}').src = reader.result;
                                                        };
                                                        reader.readAsDataURL(blob);
                                                    })
                                                    .catch(error => {
                                                        console.error('Error fetching image:', error);
                                                    });
                                            </script>
                                        </div>
                                    </td>
                                    <td>${r.name}</td>
                                    <td>${r.point}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </section>



        <!-- ---- 광고 배너  -->
        <div class="ad-slider">
        
        </div>
        <!--------------- HOT 게시글 ------------------>

        <section class="hot-posts container">
            <h2>HOT 게시글</h2>


            <div class="bn">
                <div class="bn1" id="bnv">
                    <Strong>조회수 높은</Strong>
                    <table>
                        <thead>
                            <th>클럽</th>
                            <th>제목</th>
                            <th>조회</th>
                        </thead>
                        <tbody>
                            <c:forEach items="${viewsRank}" var="v">
                                <tr>
                                    <td>${v.clubType}</td>
                                    <c:url var="postViewsRank"
                                        value="/mainPost/details">
                                        <c:param name="id"
                                            value="${v.id}" />
                                    </c:url>
                                    <td><a href="${postViewsRank}">${v.title}
                                    </a></td>
                                    <td>${v.views}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>



                <div class="bn1" id="bnr">
                    <strong>추천수 높은</strong>
                    <table>
                        <thead>
                            <th>클럽</th>
                            <th>제목</th>
                            <th>추천</th>
                        </thead>
                        <tbody>
                            <c:forEach items="${likesRank}" var="l">
                                <tr>
                                    <td>${l.clubType}</td>
                                    <c:url var="postLikesRank"
                                        value="/mainPost/details">
                                        <c:param name="id"
                                            value="${l.id}" />
                                    </c:url>
                                    <td><a href="${postLikesRank}">${l.title}
                                    </a></td>
                                    <td>${l.likes}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
        </section>





        <!--------------- 인스타그램 ------------------>

        <section class="instagram container">
            <div class="instagram-header">
                <h2>GOLFRO INSTAGRAM</h2>
                <h5>@GOLFRO_KR</h5>
            </div>
            <div class="instagram-slider">
                <blockquote class="instagram-media"
                    data-instgrm-permalink="https://www.instagram.com/p/C9cQp2_ycqd/"
                    data-instgrm-version="14"></blockquote>
                <blockquote class="instagram-media"
                    data-instgrm-permalink="https://www.instagram.com/p/C9cRuiUSWK4/"
                    data-instgrm-version="14"></blockquote>
                <blockquote class="instagram-media"
                    data-instgrm-permalink="https://www.instagram.com/p/C9cRw_jyR4o/"
                    data-instgrm-version="14"></blockquote>
                <blockquote class="instagram-media"
                    data-instgrm-permalink="https://www.instagram.com/p/C9cR-K5Sz9Z/"
                    data-instgrm-version="14"></blockquote>
                <blockquote class="instagram-media"
                    data-instgrm-permalink="https://www.instagram.com/p/C9cSA_wSocX/"
                    data-instgrm-version="14"></blockquote>
                <blockquote class="instagram-media"
                    data-instgrm-permalink="https://www.instagram.com/p/C9cSnOKypk7/"
                    data-instgrm-version="14"></blockquote>
            </div>
        </section>
    </main>
    <footer>
        <div class="container">
            <div class="left">
                <h1>COLFRO</h1>
                <p>골프 레슨은 여기에서! 골프로</p>
            </div>
            <div class="right mt-2">
                <div class="list">
                    <h4>CONTENT</h4>
                    <ul>
                        <li>회사소개</li>
                        <li>광고문의</li>
                        <li>이용약관</li>
                        <li>제휴안내</li>
                    </ul>
                </div>
                <div class="list">
                    <h4>ABOUT</h4>
                    <ul>
                        <li>오시는 길</li>
                        <li>개인정보 처리방침</li>
                        <li>문의하기</li>
                        <p>> 평일: 전체 문의 상담 토요일, 공휴일: ~ 오후 2시 문의 상담
                            일요일: 휴무</p>
                        <p>
                            평일: 전체 문의 상담<br>토요일, 공휴일: ~ 오후 2시 문의 상담<br>일요일:
                            휴무
                        </p>
                    </ul>
                </div>
            </div>
        </div>


        <div class="text-center">
            <span>Copyright ⓒ - 2024 GOLFRO. All rights reserved.</span>
        </div>


    </footer>



    <c:url var="main_header" value="js/main_header.js" />
    <script src="${main_header}"></script>
    <script async src="https://www.instagram.com/embed.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>


    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const slider = document.querySelector('.instagram-slider');
            let isDown = false;
            let startX;
            let scrollLeft;
    
            slider.addEventListener('mousedown', (e) => {
                isDown = true;
                slider.classList.add('active');
                startX = e.pageX - slider.offsetLeft;
                scrollLeft = slider.scrollLeft;
            });
    
            slider.addEventListener('mouseleave', () => {
                isDown = false;
                slider.classList.remove('active');
            });
    
            slider.addEventListener('mouseup', () => {
                isDown = false;
                slider.classList.remove('active');
            });
    
            slider.addEventListener('mousemove', (e) => {
                if (!isDown) return;
                e.preventDefault();
                const x = e.pageX - slider.offsetLeft;
                const walk = (x - startX) * 3; // 스크롤 속도 조정
                slider.scrollLeft = scrollLeft - walk;
            });
        });
	</script>
</body>
</html>