<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
</style>
<section>
<table>
	<div class="allCheck">
		<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
	</div>
 
	<div class="delBtn">
		<button type="button" class="selectDelete_btn">선택 삭제</button> 
	</div>
	<thead>
		<tr>
			<td>체크</td>
			<td>이미지</td>
			<td>상품명</td>
			<td>잔여수량</td>
			<td>가격</td>
			<td>배송비</td>
			<td>주문 수량</td>
			<td>제거</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="cartList">
			<input type="hidden" name="userid" value="${cartList.userid }">
			<tr>
				<td>
					<input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNo }">
				</td>
				<td>
					<div style="width: 100px; height: 100px;">
						<img alt="장바구니 이미지" src="${contextPath }/resources${cartList.productThumb}">
					</div>
				</td>
				<td>
					<input type="text" name="" value="${cartList.productName }" readonly="readonly">
					<%-- <c:choose>
						<c:when test="${cartList.productCnt <= 20 }">
							<b> [${cartList.productCnt}]</b>
						</c:when>
						<c:otherwise>
						
						</c:otherwise>
					</c:choose> --%>
				</td>
				<td>
					<input type="number" id="productCnt" name="productCnt" value="${cartList.productCnt}" readonly="readonly">
				</td>
				<td>
					<input type="text" id="productPrice" name="productPrice" value="${cartList.productPrice }" readonly="readonly">
				</td>
				<td>
					<input type="text" id="deleveryPrice" name="deleveryPrice" value="${cartList.deleveryPrice }" readonly="readonly">
				</td>
				<td>
					<input type="number" id="orderCnt" name="orderCnt" data-orderCnt="5">
				</td>
				<td>
					<button type="button" class="delete_${cartList.cartNo}_btn" data-cartNo="${cartList.cartNo}">&times;</button>
				</td>
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
											operForm.find("input[name='userid']").val(userid);
											operForm.attr("action","${contextPath}/product/cartList").submit();
										} else {
											alert("삭제 실패");
										}
									}
								});
							} 
						});
					</script>
				</tr>
				<tr>
					<td colspan="8">
						<div style="text-align: right;" id="totalPrice"></div>
					</td>
				</tr>
		</c:forEach>
	</tbody>
</table>

	<input type="hidden" id="token" data-token-name="${_csrf.headerName}" placeholder="Password" value="${_csrf.token}">
	<form id="operForm" action="${contextPath}/product/list" method="GET">
		<input type="hidden" id="userid" name="userid" value="">
		<input type="hidden" name="productNo" value="${cartList.productNo }">
		<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" id="amount" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	</form>
	<button data-oper="list" class="btn btn-info">List</button>
	<button data-oper="order" id="check_module" data-oper="orderConfirm" class="btn btn-success">Order</button>
</section>
<script>
var productPrice = document.querySelector('#productPrice');
var orderCnt = document.querySelector('#orderCnt');
var totalPrice = document.querySelectorAll('#totalPrice');

orderCnt.addEventListener("keyup", productSum);

function productSum() {

	var sumTotal = (orderCnt.value * productPrice.value);
	console.log(orderCnt.value);
	console.log(productPrice.value);
	console.log(sumTotal);
	
	totalPrice[0].color = "red";
	totalPrice[0].innerHTML = sumTotal;
	totalPrice[0].style.display = "block";
}
</script>
<script type="text/javascript">
$(document).ready(function(){

	var productNo = $("input[name=productNo]").data("productNo");
	var orderCnt = $("input[name=orderCnt]").data("orderCnt");
	
	$("span").data("productNo",productNo);
	$("span").data("orderCnt",orderCnt);

	var productNo2 = $("span").data("productNo");
	var orderCnt2 = $("span").data("orderCnt");
	
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
				checkArr.push($(this).attr("data-cartNum"));
				checkArr.push($(this).attr("data-orderCnt"));
			});

			console.log(productNo2 + "\n" +orderCnt2);
			alert(	checkArr + "\n" +
					productNo2 + "\n" +
					orderCnt2);
			
			
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
						operForm.find("input[name='userid']").val(userid);
						operForm.attr("action","${contextPath}/product/cartList").submit();
						
					} else {
						alert("삭제 실패");
					}
				}
			});
		} 
	});

});
</script>
<script>

</script>
<%@ include file="../include/footer.jsp" %>