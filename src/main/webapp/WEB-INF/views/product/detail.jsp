<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
#totalPrice {
	display: none;
}
</style>
<section >
	<table style="margin: 0 auto;">
		<tr>
			<td rowspan="2" colspan="2">
				<img src="${contextPath }/resources${pDto.productImg}" alt="상품 디테일 이미지">
			</td>
		</tr>
		<tr>
	    	<td>	
	    			상품명 : ${pDto.productName}<br>
	    			별점 란						<br>
	    			가격 : ${pDto.productPrice}	<br>
	    			배송비 : ${pDto.deleveryPrice}
	    	</td>
	    </tr>
	    <tr>
    		<td colspan="2">
    			<div style="background-color: #D3D3D3; height: 30px;">
    				　
    			</div>
    		</td>
	    </tr>
	    <tr>
    		<td colspan="2">
    			<h1>
    				${pDto.productContent}
    			</h1>
    		</td>
	    </tr>
	    <tr>
    		<td colspan="2">
    			<div style="background-color: #D3D3D3; height: 30px;">
    				　
    			</div>
    		</td>
	    </tr>
	    <tr>
	    	<td>
	    		<h1>추천 상품 입니다</h1>
	    	</td>
	    </tr>
	    <tr>
    		<td>
    			<div style="background-color: #D3D3D3; height: 30px;">
    				　
    			</div>
    		</td>
	    </tr>
	    <tr>
	    	<td>
	    		<h1>리뷰 입니다</h1>
	    	</td>
	    </tr>
	    <tr>
	    	<td>
	    		<div>　</div>
	    	</td>
	    </tr>
	    <tr>
	    	<td>
			    <sec:authentication property="principal" var="prin"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${prin.username eq pDto.sallerId }">
						<button data-oper="modify" class="btn btn-default">Modify</button>
					</c:if>
				</sec:authorize>
				
				<button data-oper="list" class="btn btn-info">List</button>
				<sec:authorize access="isAuthenticated()">
					<button data-oper="orderOpen" class="btn btn-success">Order</button>
				</sec:authorize>
	    	</td>
	    </tr>
	</table>
	
	
	<form id="operForm" action="${contextPath}/product/modify" method="GET">
		<input type="hidden" id="productNo" name="productNo" value="${pDto.productNo}">
		<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" id="amount" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	 </form>
</section>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Order</h4>
            </div>
            <div class="modal-body">
            	<div class="form-group">
            		<img alt="주문 이미지" src="${contextPath }/resources${pDto.productImg}" width="50px;" height="50px;">
            	</div>
            	<form id="orderForm" method="GET" action="">
	            	<div class="form-group">
	            		<label>상품가격</label>
	            		<input class="form-control" id="productPrice" value="${pDto.productPrice}" maxlength="333" readonly="readonly">
	            		<label for="orderCnt">주문수량</label>
	            		<input class="form-control" id="orderCnt" name="orderCnt" value="" autocomplete="off" maxlength="333">
	            	</div>
	            	<div class="form-group">
	            	</div>
	            	<div class="form-group">
	            		<label>총 결제 금액</label>
	            		<span class="form-control" id="totalPrice"></span>
	            	</div>
	       			<input class="form-control" name="productNo" value="${pDto.productNo}" type="hidden">
	       			<input class="form-control" name=userid value="" type="hidden">
				</form>
            </div>
			<div class="modal-footer">
        		<button data-oper="order" id="orderBtn" type="button" class="btn btn-warning">Order</button>
        		<button data-oper="close" id="closeBtn" type="button" class="btn btn-default">Close</button>
      		</div>          
    	</div>
          <!-- /.modal-content -->
	</div>
<!-- /.modal-dialog -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	// 아이디 operForm
	var operForm = $("#operForm");
	// 아이디 orderForm
	var orderForm = $("#orderForm");

	var modal = $(".modal");

	var modalOrderBtn = $("#orderBtn");
    var modalCloseBtn = $("#closeBtn");

	var orderCnt = document.querySelector('#orderCnt');
	
    var userid = null;

    <sec:authorize access="isAuthenticated()">
		userid = '<sec:authentication property="principal.username"/>';
	</sec:authorize>

	// 버튼이 클릭될때
	$("button").on("click", function(e){
		// 이벤트 전파외엔 모두 진행
		// 이벤트 전파에는 두가지가 있음
		// 1. 버블링
		// 자식 element에서 발생된 event가 부모 element순으로 전달 되는 현상
		// 2. 캡쳐링
		// 부모 element에서 발생된 event가 자식 element순으로 전달 되는 현상
		// 다른 기능으로는 evnt.stopPropagation(); 이 있는데
		// 이벤트가 상위 DOM으로 전달,전파를 하지 않도록 하는 코드입니다.
		// 이벤트 전파를 막아주지만 기본 이벤트를 막아주진 않습니다.
		e.preventDefault();

		// 실행된 개체의 data-oper를 operation으로 선언
		var operation = $(this).data("oper");

		// 콘솔로 선택된 오퍼 확인
		console.log(operation);

		// 선택된 오퍼가 리스트라면
		if(operation === "list"){
			// operForm에서 아이디가 productNo 찾고 해당 요소를 지워라
			operForm.find("#productNo").remove();
			// operForm의 액션 주소를 바꾸고 진입
			operForm.attr("action","${contextPath}/product/list").submit();
			
		// 선택된 오퍼가 주문이라면
		} else if (operation === "orderOpen") {
	    	//modal.find("input").val("");

	    	$(".modal").modal("show");
			
		// 선택된 오퍼가 수정이라면
		} else if (operation === "modify") {
			// operForm의 액션 주소를 바꾸고 진입
			operForm.attr("action","${contextPath}/product/modify").submit();
			
		}
	});

	// 모달의 주문버튼 클릭
	$("#orderBtn").on("click", function(e){
    	console.log("orderBtn click ****");
    	if(orderCnt.value < 1){
			alert("0 이상의 주문 수량을 입력해주세요.");
			return;
        }else if (userid != null) {

        	modal.find("input[name='userid']").val(userid);
			// orderForm의 액션 주소를 바꾸고 진입
			orderForm.attr("action","${contextPath}/product/order").submit();
        }
    	
    });

    // 모달의 클로즈버튼 클릭
	$("#closeBtn").on("click", function(e){
    	console.log("modal close click ****");
        // 모달창을 숨겨라
    	modal.modal("hide");
    });
    
});
</script>
<script type="text/javascript">
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


<%@ include file="../include/footer.jsp" %>