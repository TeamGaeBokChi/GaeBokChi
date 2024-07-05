document.addEventListener('DOMContentLoaded', function() {
    const btnExchange = document.getElementById('btnExchange');
    const exchangeError = document.getElementById('exchangeError');
    const errorMessage = document.getElementById('errorMessage');

    const amountInput = document.getElementById('amount');
    const amountError = document.getElementById('amountError');

    amountInput.addEventListener('input', function() {

        let input = amountInput.value;

        if (/[^0-9]/.test(input)) {
            amountError.classList.remove('d-none');
            btnExchange.disabled = true;
        } else {
            amountError.classList.add('d-none');
            btnExchange.disabled = false;
        }
    });



    btnExchange.addEventListener('click', function() {
        const point = document.getElementById('amount').value;
        const password = document.getElementById('exchangePw').value;

        if (!point || !password) {
            showError('금액과 비밀번호를 모두 입력해주세요.');
            return;
        }

        const exchangeData = {
            password: password,
            point: point
        };
        console.log(exchangeData)
        axios.post('./exchange', exchangeData)
            .then(function(response) {
                if (response.data === 'Y') {
                    alert('출금 신청이 성공적으로 처리되었습니다.');
                    window.location.href = '/gaebokchi';
                } else if(response.data === 'N'){
                    showError('비밀번호가 틀렸습니다.');
                } else {
                    showError('출금 포인트는 보유 포인트 미만이어야 합니다.');
                }
            })
            .catch(function(error) {
                if (error.response) {

                    showError(error.response.data || '서버 오류가 발생했습니다.');
                } else if (error.request) {

                    showError('서버로부터 응답을 받지 못했습니다.');
                } else {

                    showError('요청 중 오류가 발생했습니다.');
                }
            });
    });

    function showError(message) {
        errorMessage.textContent = message;
        exchangeError.style.display = 'block';
    }
});