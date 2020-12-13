$(document).ready(function() {
//	var result = '<c:out value="${result}"/>';
	var result = "${result}";
	
	// 파라메터에 따라서 모달창을 보여주거나 내용을 수정한 뒤 보이도록 작성하기 위함.
	checkModal(result);
	
	// history 객체에 현재 저장된 데이터를 변경 (새 기록을 작성하는 대신 사용자의 동작에 따라
	// 현재 히스토리 엔트리의 URL을 업데이트 하려고 할 때 매우 유용)
	// window.history.replace(data, title [, url]);
	// 사용 예) window.history.replaceState("http://example.ca", "Sample Title", "/example/path.html");
    // 이 예제는 현재 기록, 주소 표시 줄 및 페이지 제목을 바꿉니다.
	history.replaceState({}, null, null);
	
	function checkModal(result) {
		if (result === "" || history.state) {
			return;
		}

		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}

		$("#myModal").modal("show");
    }
	
	$("#regBtn").on("click", function() {
		self.location = "${contextPath}/board/register";
	});
	
	// 페이지 번호를 클릭하면 처리하는 부분
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e) {
		e.preventDefault(); // <a>태그를 클릭해도 페이지 이동이 없도록 처리
		
		console.log("click");

		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});

	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"
										+ $(this).attr("href")
										+ "'>");
		actionForm.attr("action", "${contextPath}/board/read");
		actionForm.submit();
	});

	/*var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e) {
		if (!searchForm.find("option:selected").val()) {
			alert("검색종류를 선택하세요");
			
			return false;
		}

		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요");
			
			return false;
		}

		searchForm.find("input[name='pageNum']").val("1");
		
		e.preventDefault();

		searchForm.submit();

	});
*/
	/*var serachFrom = $("#searchForm");

	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요.");

			return false;
		}

		if(!searchForm.find("input[name='keyword']").val()){
			alert("검색어를 입력하세요.");

			return false;
		}

		searchForm.find("input[name='pageNum']").val("1");

		e.preventDefault();
		searchForm.submit();
	});*/
});