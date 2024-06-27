document.addEventListener('DOMContentLoaded', () => {
    const idbutton = document.querySelector('button#idbutton');
    const nicknamebutton = document.querySelector('button#nicknamebutton');
    const submitButton = document.querySelector('button#submitButton');
    let useridChecked = false;
    let nicknameChecked = false;

    // Submit 버튼 비활성화 함수
    function updateSubmitButton() {
        submitButton.disabled = !(useridChecked && nicknameChecked);
    }

    // 초기 상태에서 submit 버튼 비활성화
    updateSubmitButton();

    idbutton.addEventListener('click', () => {
        const userid = document.querySelector('input#userid').value;
        const iduri = `./checkUserid?userid=${userid}`;
        axios
            .get(iduri)
            .then((response) => {
                if (response.data === 'Y') {
                    alert('사용 가능한 아이디 입니다.')
                    useridChecked = true;
                } else {
                    alert('사용 불가능한 아이디 입니다.')
                    useridChecked = false;
                }
                updateSubmitButton();
            })
            .catch((error) => {
                console.log('error', error);
                useridChecked = false;
                updateSubmitButton();
            });
    });

    nicknamebutton.addEventListener('click', () => {
        const nickname = document.querySelector('input#nickname').value;
        const nickuri = `./checkNickname?nickname=${nickname}`;
        axios
            .get(nickuri)
            .then((response) => {
                if (response.data === 'Y') {
                    alert('사용 가능한 닉네임 입니다.')
                    nicknameChecked = true;
                } else {
                    alert('사용 불가능한 닉네임 입니다.')
                    nicknameChecked = false;
                }
                updateSubmitButton();
            })
            .catch((error) => {
                console.log('error', error);
                nicknameChecked = false;
                updateSubmitButton();
            });
    });




    const password = document.getElementById('userPassword');
    const passwordConfirm = document.getElementById('userPasswordConfirm');
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




});