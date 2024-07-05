/**
 * 
 */

document.addEventListener("DOMContentLoaded", function() {
	// 페이지 로드 시 URL에서 searchCategory 값을 읽어옴
	var urlParams = new URLSearchParams(window.location.search);
	var searchCategory = urlParams.get('searchCategory');
	if (searchCategory) {
		document.getElementById("searchCategory").value = searchCategory;
	}
	toggleSearchField();



});


	function toggleSearchField() {
		var searchCategory = document.getElementById("searchCategory").value;
		var clubSelectField = document.getElementById("clubSelectField");
		var textSearchSelectField = document.getElementById("textSearchSelectField");
		var searchSelectionField = document.getElementById("searchSelectionField");

		if (searchCategory === "searchClubs") {
			clubSelectField.style.display = "block";
			textSearchSelectField.style.display = "none";
			searchSelectionField.style.display = "none";
		} else if (searchCategory === "searchSelection") {
			clubSelectField.style.display = "none";
			textSearchSelectField.style.display = "none";
			searchSelectionField.style.display = "block";
		} else {
			clubSelectField.style.display = "none";
			textSearchSelectField.style.display = "block";
			searchSelectionField.style.display = "none";
		}
	}


