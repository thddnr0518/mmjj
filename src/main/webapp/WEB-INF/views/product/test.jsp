<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />
		</div>
	</header>
<style>
	.inputArea { margin:10px 0; }
	label { display:inline-block; width:70px; padding:5px; }
	label[for='gdsDes'] { display:block; }
	input { width:150px; }
	textarea#gdsDes { width:400px; height:180px; }
	.select_img img {margin: 20px 0;}
</style>
<section>
	<div class="customBoard">
		<div class="customBoard1">
		
			<form action="${contextPath}/product/test?${_csrf.parameterName}=${_csrf.token}" method="post" autocomplete="off" enctype="multipart/form-data" id="pro">
			
				<div class="inputArea">
					<label for="productName">상품명</label>
					<input type="text" id="productName" name="productName" />
				</div>
				
				<div class="inputArea">
					<label for="productPrice">상품가격</label>
					<input type="text" id="productPrice" name="productPrice" />
				</div>
				
				<div class="inputArea">
					<label for="productCnt">상품수량</label>
					<input type="text" id="productCnt" name="productCnt" />
				</div>
				
				<div class="inputArea">
					<label for="deleveryPrice">배송비</label>
					<input type="text" id="deleveryPrice" name="deleveryPrice" />
				</div>
				
				<div class="inputArea">
					<label for="productContent">상품소개</label>
					<textarea rows="5" cols="50" id="productContent" name="productContent"></textarea>
				</div>
				
				<div class="inputArea">
					<label for="sallerId">판매 회사</label>
					<input type="text" id="sallerId" name="sallerId"  value="test" readonly="readonly"/>
				</div>
				
			
				<div class="inputArea">
					<label for="productImg">이미지</label>
					<input type="file" id="productImg" name="file" />
					<div class="select_img">
						<img src="" />
					</div>
				
				<script>
				$("#productImg").change(function(){
					
					if(this.files && this.files[0]) {
						
						var reader = new FileReader;
						
						reader.onload = function(data) {
							
							$(".select_img img").attr("src", data.target.result).width(500);   
							     
						}
						
					reader.readAsDataURL(this.files[0]);
					
					}
					
				});
				</script>
					<%=request.getRealPath("/") %>
				</div>
				
				<div class="inputArea">
					<button type="button" id="register_Btn" class="btn btn-primary">등록</button>
				</div>
			
			</form>	
		
		</div>
	</div>

</section>
<script>
$(document).ready(function(){
	$("#register_Btn").click(function(){
		//console.log("action:"+$("#pro").attr("action"));
		console.log($("#pro").html());
		console.log($("#productImg").html);
		$("#pro").submit();
	});
});
</script>
<%@include file="../include/footer.jsp"%>