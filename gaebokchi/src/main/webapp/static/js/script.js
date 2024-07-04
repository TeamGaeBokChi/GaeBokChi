function navigateTo(page) {
    // 모든 카테고리 클릭 시 동일한 페이지로 이동
    window.location.href = '/mainPost/list';
}

document.addEventListener("DOMContentLoaded", function() {
    const loginButton = document.querySelector(".login-button");
    const dropdownMenu = document.querySelector(".dropdown-menu");

    // 로그인 버튼에 마우스를 올릴 때 드롭다운 메뉴 표시
    loginButton.addEventListener("mouseenter", function() {
        dropdownMenu.style.display = "block";
    });

    // 로그인 버튼에서 마우스가 떠날 때, 메뉴 외부로 이동한 경우에만 메뉴 숨김
    loginButton.addEventListener("mouseleave", function(event) {
        if (!dropdownMenu.contains(event.relatedTarget)) {
            dropdownMenu.style.display = "none";
        }
    });

    // 드롭다운 메뉴에 마우스를 올릴 때 메뉴 계속 표시
    dropdownMenu.addEventListener("mouseenter", function() {
        dropdownMenu.style.display = "block";
    });

    // 드롭다운 메뉴에서 마우스가 떠날 때 메뉴 숨김
    dropdownMenu.addEventListener("mouseleave", function() {
        dropdownMenu.style.display = "none";
    });
});

function showDropdownMenu(category) {
    // 해당 카테고리의 드롭다운 메뉴를 보이게 하기
    const dropdownMenu = document.getElementById('dropdown-' + category);
    dropdownMenu.style.display = 'block';
}

function hideDropdownMenu(category) {
    // 해당 카테고리의 드롭다운 메뉴를 숨기기
    const dropdownMenu = document.getElementById('dropdown-' + category);
    dropdownMenu.style.display = 'none';
}

// 카테고리 메뉴에서 마우스가 벗어날 때 드롭다운 메뉴를 숨기기
document.addEventListener('DOMContentLoaded', function() {
    const categories = ['MAIN', 'MEET', 'REVIEW', 'COMMUNITY'];

    categories.forEach(function(category) {
        const navItem = document.getElementById('카테고리-' + category);
        navItem.addEventListener('mouseleave', function() {
            hideDropdownMenu(category);
        });
    });
});

// 검색 기능
function performSearch() {
    const search = document.querySelector(".search");
    const btn = document.querySelector(".search-btn");
    const input = document.querySelector(".input");
    
    
}

// DOMContentLoaded 이벤트를 추가하여 페이지 로드 후 스크립트가 실행되도록 합니다.
document.addEventListener("DOMContentLoaded", function() {
    performSearch();
});

