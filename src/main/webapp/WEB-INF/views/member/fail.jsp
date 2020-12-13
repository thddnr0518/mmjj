<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		modal_login(1);
	});
</script>
<script type="text/javascript" src="${contextPath }/resources/js/jQuery/3.5.1/jquery-3.5.1.min.js"></script>
<div id="modal" class="modal" style="background-color: rgba(0,0,0,1);">
	<!-- 모달 닫기 -->
	<span id="modalClose" class="modalClose" onclick="modal_close();">&times;</span>
	<!-- 로그인 모달 -->
	<div id="loginForm" class="modal-content">
		<form action="${contextPath }/login" id="login" method="post" name="login" >
			<input type="hidden" name="access" value="true">
			<div style="text-align: center; margin: 0 auto;">
				<a href="../../"><img alt="로그인 상단 이미지" src="${contextPath }/resources/img/MM.png" width="300px;"></a>
			</div>
			<div style="margin: 0 auto; margin-top: 10px; margin-bottom: 30px;text-align: center; width: 50%;">
				<div>
			        <span class="box">
			            <input type="text" id="username" name="username" class="int" maxlength="15" placeholder="아이디" value="admin0" autofocus="autofocus">
			        </span>
		        </div>
		        <div style="margin-top: 20px;">
			        <span class="box">
			            <input type="password" id="password" name="password" class="int" maxlength="15" placeholder="비밀번호" value="pw00">
			        </span>
			        <span style="color: red;">아이디나 비밀번호를 확인해주세요</span>
			    </div>
			</div>
			<div>
	        	<input type="submit">
	        </div>
			<div class="btnJoin" onclick="go_login()">
<!-- 			<div class="btnJoin" onclick="logintest();"> -->
			    <span>로그인</span>
			</div>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		</form>
	</div>
</div>
<script type="text/javascript">
function logintest(){
	document.login.submit();
}
 
</script>
<script type="text/javascript" src="${contextPath }/resources/js/Modal.js"></script>