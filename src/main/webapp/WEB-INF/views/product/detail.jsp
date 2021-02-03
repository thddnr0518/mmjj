<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
.containerr {
	display: grid;
	grid-template-columns: 250px 2fr;
	grid-template-rows: 200px 200px;
}
</style>
<section >
	<div class="containerr" >
		<div class="item">a</div>
		<div class="item">b</div>
		<div class="item">c</div>
		<div class="item">d</div>
		<div class="item">e</div>
		<div class="item">f</div>
		<div class="item">g</div>
	</div>
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
	            <form name="form1" method="post" 
	            action="${contextPath}/cart/insert">
	                <input type="hidden" name="product"
	                value="${pDto.productNo}">
	                <select name="amount">
	                    <c:forEach begin="1" end="10" var="i">
	                        <option value="${i}">${i}</option>
	                    </c:forEach>
	                </select>
	                <input type="submit" value="장바구니에 담기">
	            </form>
	        </td>
	    </tr>
	</table>
	
	<span class="clck">
    	<a href="${contextPath}/product/list">상품목록</a>
    </span>
    
    <sec:authentication property="principal" var="prin"/>
	<sec:authorize access="isAuthenticated()">
		<c:if test="${prin.username eq pDto.sallerId }">
			<button data-oper="modify" class="btn btn-default">Modify</button>
		</c:if>
	</sec:authorize>
	
	<button data-oper="list" class="btn btn-info">List</button>
	
	<form id="operForm" action="${contextPath}/product/modify" method="get">
		<input type="hidden" id="productNo" name="productNo" value="${pDto.productNo}">
		<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" id="amount" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	 </form>
</section>

<script type="text/javascript">
$(document).ready(function() {
	
	var operForm = $("#operForm");

	// 버튼 중에 데이터 오퍼가 modify가 클릭이 되면
	$("button[data-oper='modify']").on("click", function(e){
		// operForm의 액션 주소를 바꾸고 진입
	  	operForm.attr("action","${contextPath}/product/modify").submit();
	});

	// 버튼 중에 데이터 오퍼가 list가 클릭이 되면
	$("button[data-oper='list']").on("click", function(e){
		// operForm에서 아이디가 productNo 찾고 해당 요소를 지워라
		operForm.find("#productNo").remove();
		// operForm의 액션 주소를 바꾸고 진입
		operForm.attr("action","${contextPath}/product/list").submit();
	});
});
</script>

<%@ include file="../include/footer.jsp" %>