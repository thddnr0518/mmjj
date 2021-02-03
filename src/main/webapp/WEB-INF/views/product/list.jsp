<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
		</div>
	</header>
	
<section id="nino-services">
	<button type="button" id="btnAdd" onclick=""> 상품 등록 </button>
	<div class="container">
		<h2 class="nino-sectionHeading">
			<span class="nino-subHeading">Animal Park</span>
		</h2>
		<p class="nino-sectionDesc">상품 리스트 </p>
		<form id="amountFrm" action="${contextPath }/product/list" method="get">
			<select name="amount" id="pageAmount" onchange="">
				<option value="30" <c:out value="${pageMaker.cri.amount eq '30' || pageMaker.cri.amount eq ''  ?'selected':'' }"/>>30개씩</option>
				<option value="60" <c:out value="${pageMaker.cri.amount eq '60'?'selected':'' }"/>>60개씩</option>
				<option value="150" <c:out value="${pageMaker.cri.amount eq '150'?'selected':'' }"/>>150개씩</option>
			</select>
		</form>
		<!-- 상품 리스트 -->
		<div class="sectionContent">
			<div class="row nino-hoverEffect">
				<c:forEach items="${list }" var="product">
					<div class="col-md-4 col-sm-4" style="padding-top: 30px; padding-bottom: 30px;">
						<div class="item" >
							<a class="overlay" href="${product.productNo}">
								<span class="content">
									View
								</span>
								<img style="width: 300px; height: 200px;" src="${contextPath }/resources${product.productThumb}" alt="최근 게시글1">
							</a>
						</div>
						<div style="display: flex; font-size: 20px;">
							<span style="flex: 1;">${product.productName}</span>
							<span style="flex: 1;"><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>￦</span>
						</div>
						<div style="display: flex; font-size: 20px;">
							<span style="flex: 1;">남은 수량 : ${product.productCnt}</span>
							<span style="flex: 1;">팔린 수량 : ${product.orderCnt}</span>
						</div>
					</div>
				</c:forEach>
				<!-- 페이징 시작-->
			</div>
			<div class='pull-right'>
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a></li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next"><a href="${pageMaker.endPage +1 }">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>


<!-- 실제 페이지를 클릭하면 동작을 하는 부분  -->
<form id='actionForm' action="${contextPath}/product/list" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
	<input type='hidden' name='type' value='${pageMaker.cri.type}'>
	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
</form>

<div style="top: 50px; width: 100%; position: fixed; z-index: 4; background-color: #fffff3;">
	<div style="display: table; width: 80%">
		<div style="display:table-cell; width: 80%; vertical-align: bottom; padding-left: 10px; text-align: center;">
			<form action="${contextPath }/product/list" method="get" id="searchForm">
				<select name="type">
					<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':'' }"/>>상품명</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
					<option value="S" <c:out value="${pageMaker.cri.type eq 'S'?'selected':'' }"/>>판매자</option>
					<option value="NC" <c:out value="${pageMaker.cri.type eq 'NC'?'selected':'' }"/>>상품명 or 내용</option>
					<option value="NS" <c:out value="${pageMaker.cri.type eq 'NS'?'selected':'' }"/>>상품명 or 판매자</option>
					<option value="CS" <c:out value="${pageMaker.cri.type eq 'CS'?'selected':'' }"/>>내용 or 판매자</option>
					<option value="NCS" <c:out value="${pageMaker.cri.type eq 'NCS'?'selected':'' }"/>>상품명 or 내용 or 판매자</option>
				</select>
				<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="${pageMaker.cri.keyword}"/>
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" id="amount" name="amount" value="${pageMaker.cri.amount}">
				<button class="btn btn-default">검색</button>
			</form>
		</div>
		<div style="display:table-cell; width: 20%; height: 60px; vertical-align: bottom;">
			<span id="regBtn" class="clck pull-right" style="font-size: 25px">상품등록</span>
	 	</div>
	</div>
</div>

<script>
$(document).ready(function(){
	// 페이지에 표시될 상품 수가 바뀌면
	$("#pageAmount").change(function(){
		// 바뀌면 폼의 주소로 action
		$("#amountFrm").submit();
	});
	
	var actionForm = $("#actionForm");

	// 페이지 버튼의 앵컬 클릭시
	$(".paginate_button a").on("click", function(e) {
		// 앵커 클릭해도 페이지 이동이 없도록 우선 처리
		e.preventDefault(); 

		// actionForm안에 pageNum인풋을 찾고 값을 누른 앵커의 href값으로 변경 
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		// 바뀐 값을 갖고 action
		actionForm.submit();
	});

	// 상품등록 버튼 클릭시
	$("#regBtn").click(function(){
		// 이 주소로 진입
        location.href="${contextPath}/product/register";    
    });

	// 상품디테일 진입시 
	$(".overlay").on("click", function(e) {
		// overlay의 이벤트를 멈추고
		e.preventDefault(); 
		// actionForm에 새 인풋을 생성
		actionForm.append("<input type='hidden' name='productNo' value='"
										+ $(this).attr("href")
										+ "'>"); // 인풋의 값은 overlay의 href속성(${product.productNo})
		// actionForm의 속성값을 바꾸고
		actionForm.attr("action", "${contextPath}/product/detail");
		actionForm.submit();
	});
});
</script>
<%@ include file="../include/footer.jsp" %>