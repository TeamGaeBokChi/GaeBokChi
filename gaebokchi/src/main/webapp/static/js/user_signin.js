document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('signinForm');
    const loginButton = document.getElementById('btnSignin');

    loginButton.addEventListener('click', function(e) {
        e.preventDefault(); // 기본 폼 제출 동작 방지

        const userid = document.getElementById('userid').value;
        const password = document.getElementById('password').value;

        // 입력값 검증
        if (!userid || !password) {
            alert('아이디와 비밀번호를 모두 입력해주세요.');
            return;
        }

        // axios를 사용하여 서버에 로그인 요청
        axios.post('/login', {
            userid: userid,
            password: password
        })
        .then(function (response) {
            if (response.data.success) {
                alert('로그인 성공!');
                window.location.href = '/gaebokchi'; // 로그인 성공 시 리다이렉트할 페이지
            } else {
                alert('로그인 실패. 아이디 또는 비밀번호를 확인해주세요.');
            }
        })
        .catch(function (error) {
            console.error('Error:', error);
            alert('로그인 중 오류가 발생했습니다. 다시 시도해주세요.');
        });
    });
});