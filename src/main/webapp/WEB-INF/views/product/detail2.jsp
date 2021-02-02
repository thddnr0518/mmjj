<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<section >
	<h2>${pDto.productName}</h2>
	
	<table>
		<tr>
			<td colspan="3"><img alt="상품이미지가 없습니다"></td>
		
	        <td> 상품명 : ${pDto.productName}</td>
	        <td> 가격 : ${pDto.productPrice}</td>
	        
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
	    <tr>
    		<td>
    			<h1>
    				${pDto.productContent}
    			</h1>
    		</td>
	    </tr>
	    <tr><td><h1>222</h1></td></tr>
	    <tr><td><h1>333</h1></td></tr>
	</table>
	<span class="clck">
    	<a href="${contextPath}/product/list">상품목록</a>
    </span>
</section>

<%@ include file="../include/footer.jsp" %>