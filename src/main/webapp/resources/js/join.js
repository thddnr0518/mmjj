var id = document.querySelector('#userid');
var error = document.querySelectorAll('.error_next_box');
var succesID = document.querySelector('#succesID');
id.addEventListener("keyup", checkId);
var contextPath = document.login.contextPath.value;

function checkId() {
    var idPattern = /[a-zA-Z0-9_-]{5,20}/;
    if(!idPattern.test(id.value)) {
		error[0].style.color = "red";
        error[0].innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
        error[0].style.display = "block";
    } else {
    var userid = $("#userid").val();
		$.ajax({
				type:"GET",
				processData: false, 
				contentType: false,
				url: contextPath + "/member/idChk",
				dataType:"json",
				data: "userid=" + userid,
				success:function(data){
					if (data == "0") {
						error[0].style.color = "red";
						error[0].innerHTML = "중복된 아이디 입니다.";
				        error[0].style.display = "block";
				        succesID.style.display = "none";
					}else{
				        succesID.style.color = "#03c75a";
				        succesID.innerHTML = "사용 가능";
						succesID.style.display = "block";
				        error[0].style.display = "none";
					}
				},
				fail:function(){
					alert("시스템 에러");
				}
			});
    }
}

var pwd = document.querySelector('#userpw');
var pwdMsg = document.querySelector('#alertTxt');
var pwdImg = document.querySelector('#pwd_img');

var pwdChk = document.querySelector('#pwdChk');
var pwdChkImg = document.querySelector('#pwdChk_img');
var pwdMsgArea = document.querySelector('.int_pass');

pwd.addEventListener("keyup", checkPwd);
pwdChk.addEventListener("keyup", comparePwd);

function checkPwd() {
    var pwdPattern = /[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}/;
    if(!pwdPattern.test(pwd.value)) {
		error[1].style.color = "red";
        error[1].innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
        pwdMsg.innerHTML = "사용불가";
        pwdMsgArea.style.paddingRight = "93px";
        error[1].style.display = "block";
        pwdMsg.style.display = "block";
        pwdImg.src = "resources/img/naver/m_icon_not_use.png";
    } else {
        error[1].style.display = "none";
        pwdMsg.style.color = "#03c75a";
        pwdMsg.innerHTML = "안전";
        pwdMsg.style.display = "block";
        pwdImg.src = "resources/img/naver/m_icon_safe.png";
		document.getElementById("pwdChk").disabled = false;
    }
}
function comparePwd() {
    if(pwdChk.value === pwd.value && pwdChk.value != "") {
        pwdChkImg.src = "resources/img/naver/m_icon_check_enable.png";
        error[2].style.display = "none";
    } else if(pwdChk.value !== pwd.value) {
        pwdChkImg.src = "resources/img/naver/m_icon_check_disable.png";
		error[2].style.color = "red";
        error[2].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[2].style.display = "block";
    }
}

var nickName = document.querySelector('#nickName');
nickName.addEventListener("keyup", nickChk);
function nickChk() {
    var namePattern = /[a-zA-Z0-9가-힣]{1,10}/;
    if(!namePattern.test(nickName.value) || nickName.value.indexOf(" ") > -1) {
        error[3].color = "red"
		error[3].innerHTML = "1~10자 한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        error[3].style.display = "block";
    } else {
        error[3].style.display = "none";
    }
}

var email1 = document.querySelector('#email1');
var email2 = document.querySelector('#email2');
email1.addEventListener("focusout", Email1Correct);
email2.addEventListener("focusout", Email2Correct);

function Email1Correct() {
    var emailPattern1 = /[a-zA-Z0-9]{2,}/;
    if(!emailPattern1.test(email1.value)) {
        error[4].style.display = "block";
    } else {
        error[4].style.display = "none"; 
    }
}
function Email2Correct() {
	var emailPattern2 = /[a-z0-9-]{2,}\.[a-z0-9]{2,}/;
    if(!emailPattern2.test(email2.value)) {
        error[4].style.display = "block";
    } else {
        error[4].style.display = "none"; 
    }
}

var userName = document.querySelector('#userName');
userName.addEventListener("keyup", checkName);

function checkName() {
    var namePattern = /[a-zA-Z가-힣]{1,10}/;
    if(!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
        error[5].color = "red"
		error[5].innerHTML = "1~10자 한글이름 또는 영문이름을 입력해주세요 (특수기호, 공백 사용 불가)";
        error[5].style.display = "block";
    } else {
        error[5].style.display = "none";
    }
}

var yy = document.querySelector('#yy');
var mm = document.querySelector('#mm');
var dd = document.querySelector('#dd');

yy.addEventListener("focusout", BirthCompleted);
mm.addEventListener("focusout", BirthCompleted);
dd.addEventListener("keyup", BirthCompleted);

function BirthCompleted() {
    var yearPattern = /[0-9]{4}/;

    if(!yearPattern.test(yy.value)) {
        error[6].innerHTML = "태어난 년도 4자리를 정확하게 입력해주세요.";
        error[6].style.display = "block";
    } else {
        MonthSelected();
    }
    function MonthSelected() {
        if(mm.value === "월") {
            error[6].innerHTML = "태어난 월을 선택하세요.";
        } else {
            DateCompleted();
        }
    }
    function DateCompleted() {
        if(dd.value === "") {
            error[6].innerHTML = "태어난 일(날짜) 2자리를 정확하게 입력하세요.";
        } else {
            BirthRight();
        }
    }
}
function BirthRight() {
    var datePattern = /\d{1,2}/;
    if(!datePattern.test(dd.value) || Number(dd.value)<1 || Number(dd.value)>31) {
        error[6].innerHTML = "생년월일을 다시 확인해주세요.";
    } else {
        checkAge();
    }
}
function checkAge() {
    if(Number(yy.value) < 1920) {
        error[6].innerHTML = "정말이세요?";
        error[6].style.display = "block";
    } else if(Number(yy.value) > 2020) {
        error[6].innerHTML = "미래에서 오셨군요. ^^";
        error[6].style.display = "block";
    } else if(Number(yy.value) > 2005) {
        error[6].innerHTML = "만 14세 미만의 어린이는 보호자 동의가 필요합니다.";
        error[6].style.display = "block";
    } else {
        error[6].style.display = "none";
    }
}

var gender = document.querySelector('#gender');

gender.addEventListener("focusout", function() {
    if(gender.value === "성별") {
        error[7].style.display = "block";
    } else {
        error[7].style.display = "none";
    }
})

var phone = document.querySelector('#phone');
phone.addEventListener("focusout", checkPhoneNum);
phone.addEventListener("keyup", checkPhoneNum);

function checkPhoneNum() {
    var isPhoneNum = /([01]{2})([01679]{1})([0-9]{3,4})([0-9]{4})/;

    if(!isPhoneNum.test(phone.value)) {
        error[8].innerHTML = "형식에 맞지 않는 번호입니다.";
        error[8].style.display = "block";
    } else {
        error[8].style.display = "none";
    }
}


function go_save(){
	document.joinfrm.email.value = 
	document.joinfrm.email1.value + "@" + 
	document.joinfrm.email2.value;
	
	document.joinfrm.birth.value = 
	document.joinfrm.yy.value +
	document.joinfrm.mm.value +
	document.joinfrm.dd.value;
	
	document.joinfrm.addr.value = 
	document.joinfrm.addr1.value +  
	document.joinfrm.addr2.value;
	
	if(userid == ""){
		alert("아이디를 입력해 주세요.");
		document.joinfrm.userid.focus(); 
	}else if(userpw.value == ""){
		alert("비밀번호를 입력해 주세요.");
		pwd.focus();
	}else if(pwdChk.value == ""){
		alert("비밀번호를 재확인 하지 않았습니다.");
		pwdChk.focus();
	}else if(nickName.value == ""){
		alert("별명을 입력해 주세요.");
		nickName.focus();
	}else if(email1.value == ""){
		alert("이메일을 입력해주세요");
		email1.focus();
	}else if(email2.value == "입력or선택"){
		alert("도메인을 입력해주세요");
		email2.focus();
	}else if(userName.value == ""){
		alert("이름을 입력해주세요");
		userName.focus();
	}else if(document.joinfrm.yy.value == "" || document.joinfrm.mm.value == "" || document.joinfrm.dd.value == ""){
		alert("생일을 입력해 주세요.");
		yy.focus();
	}else if(gender.value == "성별"){
		alert("성별을 선택 해주세요.");
		gender.focus();
	}else if(document.joinfrm.zipNum.value == "" || document.joinfrm.addr1.value == ""){
		alert("주소를 입력해 주세요.");
		document.joinfrm.zipNum.focus();
	}else if(document.joinfrm.addr2.value == ""){
		alert("상세주소를 입력해 주세요.");
		document.joinfrm.addr2.focus();
	}else if(phone.value == ""){
		alert("전화번호를 입력해 주세요.");
		phone.focus();
	}else if(error[0].style.display == "block" || error[1].style.display == "block" || error[2].style.display == "block" || error[3].style.display == "block" || error[4].style.display == "block" || error[5].style.display == "block" || error[6].style.display == "block" || error[7].style.display == "block" || error[8].style.display == "block"){
		alert("경고창을 확인해주세요");
	}else {
		document.joinfrm.action = contextPath + "/member/join";
		document.joinfrm.submit();
	}
}
	
 //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}