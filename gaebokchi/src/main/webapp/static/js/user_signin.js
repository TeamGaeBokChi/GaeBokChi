document.addEventListener('DOMContentLoaded', function() {
    // 폼 제출 이벤트 리스너 추가
    document.getElementById('findIdForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const name = document.getElementById('findIdName').value;
        const email = document.getElementById('findIdEmail').value;
        const findIdUrl = './findId';
        const data = { name, email };

        axios.post(findIdUrl, data)
            .then(function(response) {
                // 성공적으로 아이디를 찾은 경우
                document.getElementById('findIdResult').style.display = 'block';
                document.getElementById('foundId').textContent = `찾은 아이디: ${response.data.userid}`;
                document.getElementById('findIdError').style.display = 'none';
            })
            .catch(function(error) {
                if (error.response) {
                    // 서버가 에러 응답을 보낸 경우 (예: 404, 500 등)
                    document.getElementById('findIdError').style.display = 'block';
                    document.getElementById('errorMessage').textContent = error.response.data.error || '아이디를 찾을 수 없습니다.';
                    document.getElementById('findIdResult').style.display = 'none';
                } else {
                    // 요청이 실패한 경우 (네트워크 오류 등)
                    document.getElementById('findIdError').style.display = 'block';
                    document.getElementById('errorMessage').textContent = '서버와의 통신 중 오류가 발생했습니다.';
                    document.getElementById('findIdResult').style.display = 'none';
                }
            });
    });

    document.getElementById('findPwForm').addEventListener('submit', function(e) {
        e.preventDefault();
        var phone0 = document.querySelector('select[name="phone0"]').value;
        var phone1 = document.getElementById('phone1').value;
        var phone2 = document.getElementById('phone2').value;
        var phone3 = document.getElementById('phone3').value;

        var phone = phone0 + '/' + phone1 + '-' + phone2 + '-' + phone3;

        const userid = document.getElementById('findPwId').value;
        const email = document.getElementById('findPwEmail').value;
        const findPwUrl = `./findPw`;
        const data = { userid, email, phone }

        axios.post(findPwUrl, data)
            .then((response) => {
                if (response.data === 'Y') {
                    document.getElementById('setNewPwForm').style.display = 'block';
                } else {
                    document.getElementById('errorMessagePw').textContent = '해당 정보와 일치하는 계정이 없습니다.';
                    document.getElementById('findPwError').style.display = 'block';
                }
            })
            .catch((error) => {
                console.log(error);
                document.getElementById('errorMessagePw').textContent = '오류가 발생했습니다. 다시 시도해주세요.';
                document.getElementById('findPwError').style.display = 'block';
            });

    });

    document.getElementById('setNewPwForm').addEventListener('submit', function(e) {
        const password = document.getElementById('newPassword');
        const passwordConfirm = document.getElementById('newPasswordConfirm');
        const passwordStrength = document.getElementById('passwordStrength');
        const passwordMatch = document.getElementById('passwordMatch');

        function checkPasswordStrength(password) {
            let strength = 0;
            if (password.match(/[a-z]+/)) strength += 1;
            if (password.match(/[A-Z]+/)) strength += 1;
            if (password.match(/[0-9]+/)) strength += 1;
            if (password.match(/[@$!%*#?&]+/)) strength += 1;

            return strength;
        }

        function getStrengthText(strength) {
            switch (strength) {
                case 0: return "매우 약함";
                case 1: return "약함";
                case 2: return "보통";
                case 3: return "강함";
                case 4: return "매우 강함";
            }
        }

        function getStrengthColor(strength) {
            switch (strength) {
                case 0: return "red";
                case 1: return "orange";
                case 2: return "blue";
                case 3: return "lightgreen";
                case 4: return "green";
            }
        }

        if (password && passwordConfirm && passwordStrength && passwordMatch) {
            password.addEventListener('input', function() {
                if (this.value.length > 0) {
                    const strength = checkPasswordStrength(this.value);
                    const strengthText = getStrengthText(strength);
                    const strengthColor = getStrengthColor(strength);

                    passwordStrength.textContent = `비밀번호 안정성: ${strengthText}`;
                    passwordStrength.style.color = strengthColor;
                } else {
                    passwordStrength.textContent = '';
                }
            });

            passwordConfirm.addEventListener('input', function() {
                if (this.value === password.value) {
                    passwordMatch.textContent = '비밀번호가 일치합니다.';
                    passwordMatch.style.color = 'green';
                } else {
                    passwordMatch.textContent = '비밀번호가 일치하지 않습니다.';
                    passwordMatch.style.color = 'red';
                }
            });
        } else {
            console.error('비밀번호 관련 요소를 찾을 수 없습니다.');
        }
        
        const data = { userid, email, phone, password }
        const updatePwUrl = `./updatePw`;
        axios.post(updatePwUrl,data)
            .then((response) => {

                if (response.data === 'Y') {
                    alert('비밀번호가 성공적으로 변경 되었습니다.')
                } else {
                    alert('비밀번호를 다시 확인하세요.')
                }

            })
            .catch((error) => console.log(error));

    });

});








