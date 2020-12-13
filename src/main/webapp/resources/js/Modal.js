function modal_login() {
	
	/*$('html, body').css({'overflow-y': 'auto', 'height': '100%'});
	$('#element').on('scroll touchmove mousewheel', function(event) { 
    event.preventDefault();
    event.stopPropagation();

    return false;
    
	});*/
	
	var custom_modal = document.getElementById('custom_modal');
	var loginForm = document.getElementById('loginForm');
	var joinForm = document.getElementById('joinForm');
	
	$(loginForm).find('form')[0].reset();
	$(joinForm).find('form')[0].reset();
	
	custom_modal.style.display = "block";
    loginForm.style.display = "block";
}
function modal_join() {
	
	/*$('html, body').css({'overflow-y': 'auto', 'height': '100%'});
	$('#element').on('scroll touchmove mousewheel', function(event) { 
    event.preventDefault();
    event.stopPropagation();

    return false;
    
	});*/
	
	var custom_modal = document.getElementById("custom_modal");
	var contract = document.getElementById("contract");
	var joinForm = document.getElementById("joinForm");
	var loginForm = document.getElementById('loginForm');
	
	$(loginForm).find('form')[0].reset();
	$(joinForm).find('form')[0].reset();
	
	custom_modal.style.display = "block";
	contract.style.display = "block";
	joinForm.style.display = "none";
	loginForm.style.display = "none";
}
// 닫기
function modal_close() {
	var custom_modal = document.getElementById("custom_modal");
	var contract = document.getElementById("contract");
	var joinForm = document.getElementById("joinForm");
	var loginForm = document.getElementById('loginForm');
	
	custom_modal.style.display = "none";
	contract.style.display = "none";
	joinForm.style.display = "none";
	loginForm.style.display = "none";
}

function go_home() {
	var contextPath = document.login.contextPath.value;
	location.href = contextPath + "/";
}
//약관 동의
function go_next(){
	contract.style.display = "none";
	joinForm.style.display = "block";
	contract.scrollTo(0,0);
	joinForm.scrollTo(0,0);
}

// 사용자가 모달 외부의 아무 곳이나 클릭하면 닫습니다.
/*window.onclick = function(event) {
    if (event.target == join) {
        join.style.display = "none";
    }
}*/

/* 로그인 버튼 */
$(function(){
	$("#login_btn").click(function(){
		login();
	})		
})

/* 제약사항 */
function login(){

	var contextPath = document.login.contextPath.value;
	var inputID = document.getElementById("inputID");
	var inputPWD = document.getElementById("inputPWD");
	
	if(document.login.inputID.value == ""){
		alert("아이디를 입력해 주세요.");
		document.login.inputID.focus();
	}else if(document.login.inputPWD.value == ""){
		alert("비밀번호를 입력해 주세요.");
		document.login.inputPWD.focus();
	}
	$.ajax({
		url: contextPath + "/login",
		type :  "POST",
		dataType : "json",
		data : {
			ID : $("#inputID").val(),
			PWD : $("#inputPWD").val()
		},
		beforeSend : function(xhr) {
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success : function(response){
			if(response.code == "200"){
				// 정상 처리 된 경우
				location.href = response.message;
			} else {
				$("#loginChkMessage").html("아이디나 비밀번호를 확인해주세요").css("color", "red");
			}
		},
		error : function(a,b,c){
			location.reload();
			console.log(a,b,c);
		}
		
	})
	
}