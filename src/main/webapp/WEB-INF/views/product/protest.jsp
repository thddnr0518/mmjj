<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${contextPath }/resources/mogo/js/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#postgo").click(function(){
		$("#postnice").submit();
	});
	
});
</script>
</head>
<body>
<h1>ddd</h1>

	<form action="${contextPath}/product/protest" method="post" id="postnice" autocomplete="off" enctype="multipart/form-data" >
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		<button type="submit">aaaa</button>
	</form>
	<button id="postgo">dddd</button>
</body>
</html>