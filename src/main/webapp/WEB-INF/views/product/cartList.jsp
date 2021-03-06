<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
</style>
<section>
	<div class="allCheck">
		<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
	</div>
 
	<div class="delBtn">
		<button type="button" class="selectDelete_btn">선택 삭제</button> 
	</div>
	<div class="cartList">
		<div class="cartContent">체크</div>
		<div class="cartContent">이미지</div>
		<div class="cartContent">상품명</div>
		<div class="cartContent">잔여수량</div>
		<div class="cartContent">가격</div>
		<div class="cartContent">배송비</div>
		<div class="cartContent">주문 수량</div>
		<div class="cartContent">제거</div>
	</div>
	<c:forEach items="${list }" var="cartList">
		<div class="cartList">
			<div class="cartContent">
				<input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNo }">
				<img style="width: 100px; height: 100px;" alt="장바구니 이미지" src="${contextPath }/resources${cartList.productThumb}">
				<input type="text" name="productName" value="${cartList.productName }" readonly="readonly">
				<%-- <c:choose>
					<c:when test="${cartList.productCnt <= 20 }">
						<b> [${cartList.productCnt}]</b>
					</c:when>
					<c:otherwise>
					
					</c:otherwise>
				</c:choose> --%>
				<input type="number" name="productCnt" value="${cartList.productCnt}" readonly="readonly">
				<input type="text" class="productPrice" name="productPrice" value="${cartList.productPrice }" readonly="readonly">
				<input type="text" value="${cartList.deleveryPrice }" readonly="readonly">
				<input type="number" class="inputCnt" name="inputCnt" value="" placeholder="체크 후 입력" readonly="readonly">
				<button type="button" class="delete_${cartList.cartNo}_btn" data-cartNo="${cartList.cartNo}">&times;</button>
				<input type="number" name="orderPrice" value="" style="display: none;">
				<script type="text/javascript">
					$(".delete_${cartList.cartNo}_btn").click(function(){
						var confirm_val = confirm("정말 삭제하시겠습니까?");
	
						var operForm = $("#operForm");
						 
						var userid = null;
						
						<sec:authorize access="isAuthenticated()">
							userid = '<sec:authentication property="principal.username"/>';
						</sec:authorize>
						
						if(confirm_val) {
							var checkArr = new Array();
						  	
							checkArr.push($(this).attr("data-cartNo"));
						             
							$.ajax({
								url : "${contextPath}" + "/product/deleteCart",
								type : "post",
								beforeSend : function(xhr) {
									var $token = $("#token");
									xhr.setRequestHeader($token.data("token-name"), $token.val());
								},
								data : { 	chbox : checkArr,
											userid : userid
										},
								success : function(result){
									if(result == "success") {            
										operForm.find("input[name='cartId']").val(userid);
										operForm.attr("action","${contextPath}/product/cartList").submit();
									} else {
										alert("삭제 실패");
									}
								}
							});
						} 
					});
				</script>
			</div>
		</div>
	</c:forEach>
	<div style="margin: 10px; text-align: right;">
		합계 : <input type="number" value="" name="totalPrice">
	</div>
	<input type="hidden" id="token" data-token-name="${_csrf.headerName}" placeholder="Password" value="${_csrf.token}">
	<form id="operForm" action="${contextPath}/product/list" method="GET">
		<input type="hidden" id="cartId" name="userid" value="">
		<input type="hidden" id="productNo" name="productNo" value="${cartList.productNo }">
		<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" id="amount" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	</form>
	<button data-oper="list" class="btn btn-info">List</button>
	<button data-oper="order" id="check_module" class="btn btn-success">Order</button>
</section>

<script type="text/javascript">
$(document).ready(function(){

	var totalPrice = new Array();
	var unique = new Array();
	
	var userid = null;
	
	<sec:authorize access="isAuthenticated()">
		userid = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	var operForm = $("#operForm");
	
	$("button").on("click", function(e){
		e.preventDefault();

		var operation = $(this).data("oper");

		if(operation === "list"){
			operForm.find("#productNo").remove();
			
			operForm.attr("action","${contextPath}/product/list").submit();
			
		}else if(operation === "order"){
			
			var checkArr = new Array();

			$("input[class='chBox']:checked").each(function(){
				console.log("data-cartNum : " + $(this).attr("data-cartNum"));
				console.log("data-cartCnt : " + $(this).data("cartCnt"));
				
				checkArr.push($(this).attr("data-cartNum"));
				checkArr.push($(this).data("cartCnt"));
			});

			alert(checkArr);

			$.ajax({
				url : "${contextPath}" + "/product/orderCntConfirm",
				type : "post",
				beforeSend : function(xhr) {
					var $token = $("#token");
					xhr.setRequestHeader($token.data("token-name"), $token.val());
				},
				data : { 	chbox : checkArr,
							userid : userid
						},
				success : function(result){
					if(result == "success") {
						alert("컨펌 성공");
						//operForm.find("input[name='userid']").val(userid);
						//operForm.attr("action","${contextPath}/product/cartList").submit();
						
					} else {
						alert("컨펌 실패");
					}
				}
			});
			
		}
		
	});

	$("#allCheck").click(function(){
		var chk = $("#allCheck").prop("checked");
		if(chk) {
			$(".chBox").prop("checked", true);
		} else {
			$(".chBox").prop("checked", false);
		}
	});

	$(".chBox").click(function(){
		$("#allCheck").prop("checked", false);
	});

	$(".selectDelete_btn").click(function(){
		
		var confirm_val = confirm("정말 삭제하시겠습니까?");
		  
		if(confirm_val) {
			var checkArr = new Array();
		  
			$("input[class='chBox']:checked").each(function(){
				checkArr.push($(this).attr("data-cartNum"));
			});
			    
			$.ajax({
				url : "${contextPath}" + "/product/deleteCart",
				type : "post",
				beforeSend : function(xhr) {
					var $token = $("#token");
					xhr.setRequestHeader($token.data("token-name"), $token.val());
				},
				data : { 	chbox : checkArr,
							userid : userid
						},
				success : function(result){
					if(result == "success") {
						operForm.find("input[name='cartId']").val(userid);
						operForm.attr("action","${contextPath}/product/cartList").submit();
						
					} else {
						alert("삭제 실패");
					}
				}
			});
		} 
	});

	$("input[name='inputCnt'][readonly='readonly']").on("click", function(){
		var papa = $(this).parent();
		var grandpa = papa.parent();
		var ggrandpa = grandpa.parent();

		console.log("test");
		papa.find("input[name='chBox']").prop("checked", true);
		$(this).removeAttr("readonly");
	});
	
	$("input:checkbox[class='chBox']").on("change", function(){

		var papa = $(this).parent();
		var grandpa = papa.parent();
		var ggrandpa = grandpa.parent();
		
		if($(this).prop("checked")){
			grandpa.find("input[name='inputCnt']").removeAttr('readonly');

		}else{
			var removePrice = grandpa.find("input[name='orderPrice']").val();

			totalPrice = jQuery.grep(totalPrice, function(value){
				return value != removePrice;
			});

			if(totalPrice.length >= 1){
				var sum = totalPrice.reduce((stack, el) => {
					return stack + el;
				});
				ggrandpa.find("input[name='totalPrice']").val(sum);
				
			}else{
				var sum = 0;
				ggrandpa.find("input[name='totalPrice']").val(sum);
			}
			
			
			grandpa.find("input[name='inputCnt']").val("");
			grandpa.find("input[name='orderPrice']").val("");
			grandpa.find("input[name='inputCnt']").attr("readonly", "readonly");
		}
	});

	// 수량 입력란이 변경되면
	$(".inputCnt").change(function(){
		var papa = $(this).parent();
		var grandpa = papa.parent();
		var ggrandpa = grandpa.parent();
		
		var inputCnt = $(this).val();

		// 상품 가격
		var searchProductPrice = papa.find("input[name='productPrice']").val();
		// 수량 * 가격
		var searchOrderPrice = papa.find("input[name='orderPrice']").val((inputCnt * searchProductPrice));

		$(".chBox").data("cartCnt",inputCnt);

		var cartCnt = $(".chBox").data("cartCnt");

		console.log("inputCnt : " + inputCnt);
		console.log("가격 : " + searchProductPrice);
		console.log("체크 인풋 수량 데이터 : " + cartCnt);
		
		console.log("구매 금액 : " + searchOrderPrice.val());
		
		totalPrice.push(Number(searchOrderPrice.val()));

		var sum = totalPrice.reduce((stack, el) => {
			return stack + el;
		});

		// 유니크하게 만들기
		/* var set = new Set(totalPrice);

		unique = [...set];

		var sum = unique.reduce((stack, el) => {
			return stack + el;
		}); */

		ggrandpa.find("input[name='totalPrice']").val(sum);
	});
	
});
</script>
<%@ include file="../include/footer.jsp" %>