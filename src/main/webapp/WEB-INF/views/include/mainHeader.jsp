<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="ninodezign.com, ninodezign@gmail.com">
	<meta name="copyright" content="ninodezign.com"> 
	<title>MMJJ</title>
	
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="${contextPath }/resources/vendor/bootstrap/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="${contextPath }/resources/vendor/font-awesome/css/font-awesome.min.css">
	<%-- <link rel="stylesheet" type="text/css" href="${contextPath }/resources/mogo/css/bootstrap.min.css" /> --%>
	<%-- <link rel="stylesheet" type="text/css" href="${contextPath }/resources/mogo/css/materialdesignicons.min.css" /> --%><!-- 팝업 이미지 -->
	<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/MMJJ.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/ghost.css" />
	
	<!-- favicon -->
    <link rel="shortcut icon" href="${contextPath }/resources/mogo/images/ico/favicon.jpg">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${contextPath }/resources/mogo/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${contextPath }/resources/mogo/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${contextPath }/resources/mogo/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${contextPath }/resources/mogo/images/ico/apple-touch-icon-57-precomposed.png">
	
	<style type="text/css">
		/* 모달 스크롤 */
		body {
			overflow-y: scroll;
			width:100%;
		}
		/* 모달 */
		.custom_modal {
		    display: none;
		    position: fixed;
		    z-index: 11;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgb(0,0,0);
		    background-color: rgba(0,0,0,0.4);
		}
		.custom_modal-content {
			z-index: 12;
			display: none;
			top: 20px;
		    background-color: #f5f6f7;
		    margin: 0 auto;
		    border: 1px solid #888;
		    min-height: 100px;
		    max-height: 80%;
		    overflow: auto;
		}
		.custom_modal-content::-webkit-scrollbar{
			background-color: #f5f6f7;
			width: 7px;
		}
		.custom_modal-content::-webkit-scrollbar-thumb{
			border-radius: 6px;
			background-color: #555;
		}
		/* 약관 내용 스크롤바 */
		#contract textarea::-webkit-scrollbar{
			width: 7px;
		}
		#contract textarea::-webkit-scrollbar-thumb{
			border-radius: 6px;
			background-color: #555;
		}
		/* 닫기 버튼 영역*/
		.custom_modalClose {
			top: 0%;
			z-index:13;
		    color: #aaa;
		    float: right;
		    font-size: 40px;
		    font-weight: bold;
		    position: fixed;
		}
		.custom_modalClose:hover,
		.custom_modalClose:focus {
		    color: black;
		    text-decoration: none;
		    cursor: pointer;
		}
		/* 텍스트 버튼 영역 */
		.clck {
		    color: #aaa;
		    float: center;
		    font-size: 30px;
		    font-weight: bold;
		}
		.clck:hover,
		.clck:focus {
		    color: black;
		    text-decoration: none;
		    cursor: pointer;
		}
		.clckk:hover,
		.clckk:focus{
			text-decoration: none;
		    cursor: pointer;
		}
		
		/* 회원가입창 css */
		.box.int_id {
		    padding-right: 110px;
		}
		.box.int_pass {
		    padding-right: 40px;
		}
		.box.int_pass_check {
		    padding-right: 40px;
		}
		.pwdImg {
		    width: 18px;
		    height: 20px;
		    display: inline-block;
		    top: 50%;
		    right: 16px;
		    margin-top: -10px;
		    cursor: pointer;
		    position: absolute;
		}
		.int {
		    display: block;
		    width: 100%;
		    height: 29px;
		    border:0;
		    background: #fff;
		    font-size: 15px;
		}
		#email_wrap {
			display: table;
		    width: 100%;
		}
		#email_1 {
			display: table-cell;
		    width: 45%;
		}
		#email_2 {
			vertical-align: middle;
			text-align:center;
			display: table-cell;
		}
		#email_3 {
			display: table-cell;
		    width: 45%;
		}
		#email_2, #email_3 {
		    padding-left: 10px;
		}
		#bir_wrap {
		    display: table;
		    width: 100%;
		}
		#bir_yy {
		    display: table-cell;
		    width: 40%;
		}
		#bir_mm {
		    display: table-cell;
		    width: 30%;
		    vertical-align: middle;
		}
		#bir_dd {
		    display: table-cell;
		    width: 30%;
		}
		#bir_mm, #bir_dd {
		    padding-left: 10px;
		}
		#road_wrap {
		    display: table;
		    width: 100%;
		}
		#road-A {
		    display: table-cell;
		    width: 65%;
		}
		#road-B{
		    display: table-cell;
		    width: 35%;
		    vertical-align: middle;
		    padding-left: 10px;
		}
		#jibun_wrap {
		    display: table;
		    width: 100%;
		}
		#jibun-A {
		    display: table-cell;
		    width: 65%;
		}
		#jibun-B{
		    display: table-cell;
		    width: 35%;
		    vertical-align: middle;
		    padding-left: 10px;
		}
		
		.sel {
		    width: 100%;
		    height: 29px;
		    font-size: 15px;
		    background: url(resources/img/select.png) no-repeat 95% 50%;
		    -webkit-appearance: none;
		    display: inline-block;
		    text-align: start;
		    border: none;
		    cursor: default;
		    font-family: Dotum,'돋움',Helvetica,sans-serif;
		}
		/* 에러메세지 */
		.error_next_box {
		    margin-top: 10px;
		    margin-bottom: 10px;
		    font-size: 12px;
		    color: red;    
		    display: none;
		}
		#alertTxt {
		    position: absolute;
		    top: 19px;
		    right: 38px;
		    font-size: 12px;
		    color: red;
		    display: none;
		}
		.box {
		    display: block;
		    width: 100%;
		    height: 51px;
		    border: solid 1px #dadada;
		    border-radius:0;
		    padding: 10px 14px 10px 14px;
		    box-sizing: border-box;
		    background: #fff;
		    position: relative;
		}
		/* 버튼 */
		.btnJoin {
			transition: 0.5s all ease;
		    width: 100%;
		    text-align:center;
		    padding: 21px 0 17px;
		    cursor: pointer;
		    color: #FFFFF3;
		    border:none;
		    border-radius:0;
		    background-color: #566270;
		    font-size: 20px;
		    font-weight: 500;
		    font-family: Dotum,'돋움',Helvetica,sans-serif;
		}
		.btnJoin:hover,
		.btnJoin:focus {
			transition: 0.5s all ease;
			color: #566270;
			background-color: #f5f6f7;
			border: none;
		}
		label {
			margin: 15px 0 0 0;
		}
		.FormSize{
			margin: 0 auto;
			margin-top: 10px;
			margin-bottom: 30px;
		}
		@media (max-width: 767px) {
		
			.custom_modal-content {
		    	width: 90%;
			}
			.custom_modalClose {
			 	right: 7%;
			}
		}
		@media (min-width: 768px) and (max-width:1279px) {
		
			.custom_modal-content {
		    	width: 55%;
			}   
			.custom_modalClose {
			 	right: 23.4%;
			}
		}
		@media (min-width: 1280px) {
		
			.custom_modal-content {
		   		width: 40%;
			}
			.custom_modalClose {
			 	right: 30.6%;
			}
		}
	</style>
	
	<script type="text/javascript">
		function logouttest(){
			alert("로그아웃하였습니다.");
			document.logoutfrm.submit();
		}
	</script>
<script type="text/javascript" src="${contextPath }/resources/js/jQuery/3.5.1/jquery-3.5.1.min.js"></script>
</head>
<body>
<header id="nino-header">
	<div id="nino-headerInner">		
		<nav id="nino-navbar" class="navbar navbar-default" role="navigation">
			<div class="container">
				<!-- 모바일 상단바 -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
					 data-toggle="collapse" data-target="#nino-navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<span>
						<a class="navbar-brand" href="${contextPath }/">
							<img alt="상단 메인로고" src="${contextPath }/resources/img/white.png" style="width:50px;">
						</a>
					</span>
				</div>

				<!-- 상단 메뉴 4개 네비바 시작 -->
				<div class="nino-menuItem pull-right">
					<div class="collapse navbar-collapse pull-left" id="nino-navbar-collapse">
						<ul class="nav navbar-nav">
							<li class="active"><a href="#nino-header">Home <span class="sr-only">(current)</span></a></li>
							<li><a href="#board">Board</a></li>
							<!-- <li><a href="#ranking">Rank</a></li> -->
							<li><a href="#shop">Shop</a></li>
							<!-- <li><a href="#nino-portfolio">Animal Park</a></li> -->
							<!-- <li><a href="#About">About</a></li> -->
							<sec:authorize access="isAuthenticated()">
								<li><a class="clckk">My page(<sec:authentication property="principal.member.nickName"/>)</a></li>
								<li>
									<a class="clckk">
										<form role="form" method="post" action="${contextPath }/logout" name="logoutfrm">
											<span id="logout" onclick="logouttest();">LOGOUT</span>
											<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
										</form>
									</a>
								</li>
							</sec:authorize>
							<sec:authorize access="isAnonymous()">
								<li>
									<a class="clckk">
										<span id="loginBtn" onclick="modal_login();">LOGIN</span>
									</a>
								</li>
								<li>
									<a class="clckk" id="joinBtn" style="font-size: 13px" onclick="modal_join();">JOIN</a>
								</li>
							</sec:authorize>
						</ul>
					</div>
					<!-- 상단 메뉴 4개 네비바 끝 -->
				</div>
			</div><!-- /.container-fluid -->
		</nav>
	</div>
