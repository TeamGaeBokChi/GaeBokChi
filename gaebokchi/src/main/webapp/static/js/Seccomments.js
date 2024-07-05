// comment_js

document.addEventListener('DOMContentLoaded', function() {
    // 버튼 btnRegisterComment 요소를 찾음.
    const btnRegisterComment = document.querySelector('button#btnRegisterComment');
    
    // 버튼에 클릭 이벤트 리스너를 설정.
    btnRegisterComment.addEventListener('click', registerComment);   
    
    /*-------------------------------------------------*/
    
    // 댓글 등록 이벤트 리스너 콜백(함수):
    function registerComment() {
        // 댓글이 달릴 포스트 번호를 찾음.
        const postId = document.querySelector('input#postId').value;
        
        // 댓글 내용을 찾음.
        const content = document.querySelector('input#content').value;
        
        // 댓글 작성자 아이디를 찾음.
        const author = document.querySelector('input#author').value;
        
        // 댓글 내용, 댓글 작성자가 비어 있는 지 체크
        if (content === '' || author === '') {
            alert('댓글 내용과 작성자는 반드시 입력하세요.');
            return; // 이벤트 리스너를 종료
        }
        
        // Ajax 요청에서 보낼 데이터 객체를 생성.
        /* const data = {
            postId: postId,
            content: content,
            author: author
        }; */
        const data = {postId, content, author};
        console.log(data);
        
        // POST 방식의 Ajax 요청을 보냄. 응답 성공/실패 콜백을 등록.
        axios
        .post('../api/comment', data)
        .then((response) => {
            // console.log(response);
            console.log(response.data); // RestController에서 보낸 응답 데이터
            if (response.data === 1) {
                alert('댓글 1개 등록 성공');
                document.querySelector('textarea#content').value = '';
                document.querySelector('input#author').value = '';
                // 댓글 목록 갱신
                getAllComments();
            }
        })
        .catch((error) => {
            console.log(error);
        });
    }

    // 새로운 댓글을 화면에 표시하는 함수
    function displayComment(comment) {
        var commentList = document.querySelector('.comment-list');

        // 새로운 댓글 요소 생성
        var commentDiv = document.createElement('div');
        commentDiv.classList.add('comment');
        commentDiv.innerHTML = `
            <b>${comment.author}</b>
            <p>${comment.content}</p>
            <small class="text-muted">${comment.modifiedTime}</small>
        `;

        // 댓글 리스트에 추가
        commentList.appendChild(commentDiv);
    }
});
