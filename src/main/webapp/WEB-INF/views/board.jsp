<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="include/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />
		</div>
	</header>
<section>
	<div>
		<div class="customBoard" style="padding-top: 50px;">
			<div class="panel panel-default">
			    <div class="panel-heading">
			        MungMungJackJack
			    </div>
			    <!-- /.panel-heading -->
				<div class="panel-body">
				    <table class="table table-striped table-bordered table-hover">
				        <thead>
				            <tr>
				                <th>#번호</th>
				                <th>제목</th>
				                <th>작성자</th>
				                <th>작성일</th>
				                <th>조회수</th>
				            </tr>
				        </thead>
				        <tbody>
				        	<c:forEach items="${list }" var="board">
								<tr>
									<td>${board.bno }</td>
									<td><a class="move" href="${board.bno}">${board.title} 
										<c:choose>
											<c:when test="${board.replycnt > 0 }">
												<b> [${board.replycnt }]</b>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</a></td>
								<td>${board.writer}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}"/></td>
								<td><span class="badge bg-ref">${board.viewcnt}</span></td>
								</tr>
							</c:forEach>
				    	</tbody>
					</table> <!-- table태그 끝 -->
				                       
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
				<!--  end Pagination -->
				
				<!-- 실제 페이지를 클릭하면 동작을 하는 부분  -->
				<form id='actionForm' action="${contextPath}/board" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='${pageMaker.cri.type}'>
					<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
				</form>                            
				<!-- Modal  추가 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
				<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
				</div>
			<!-- /.panel-body -->
			</div>
		<!-- /.panel -->
		</div>
	<!-- /.col-lg-12 -->
	</div>
</section>
<div style="top: 50px; width: 100%; position: fixed; z-index: 4; background-color: #fffff3;">
	<div style="display: table; width: 80%">
		<div style="display:table-cell; width: 80%; vertical-align: bottom; padding-left: 10px; text-align: center;">
			<form action="${contextPath }/board" method="get" id="searchForm">
				<select name="type">
					<%-- <option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>---</option> --%>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
					<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
					<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자</option>
					<option value="CW" <c:out value="${pageMaker.cri.type eq 'CW'?'selected':'' }"/>>내용 or 작성자</option>
					<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
				</select>
				<input type="text" name="keyword" placeholder="검색어를 입력하세요." value="${pageMaker.cri.keyword}"/>
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<button class="btn btn-default">검색</button>
			</form>
		</div>
		<div style="display:table-cell; width: 20%; height: 60px; vertical-align: bottom;">
			<span id="regBtn" class="clck pull-right" style="font-size: 25px">글쓰기</span>
	 	</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
//		var result = '<c:out value="${result}"/>';
		var result = "${result}";
		
		// 파라메터에 따라서 모달창을 보여주거나 내용을 수정한 뒤 보이도록 작성하기 위함.
		checkModal(result);
		
		// history 객체에 현재 저장된 데이터를 변경 (새 기록을 작성하는 대신 사용자의 동작에 따라
		// 현재 히스토리 엔트리의 URL을 업데이트 하려고 할 때 매우 유용)
		// window.history.replace(data, title [, url]);
		// 사용 예) window.history.replaceState("http://example.ca", "Sample Title", "/example/path.html");
	    // 이 예제는 현재 기록, 주소 표시 줄 및 페이지 제목을 바꿉니다.
		history.replaceState({}, null, null);
		
		function checkModal(result) {
			if (result === "" || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}

			$("#myModal").modal("show");
	    }
		
		$("#regBtn").on("click", function() {
			location.href = "${contextPath}/board/register";
			/* self.location = "${contextPath}/board/register"; */
		});
		
		// 페이지 번호를 클릭하면 처리하는 부분
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault(); // <a>태그를 클릭해도 페이지 이동이 없도록 처리
			
			console.log("click");

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"
											+ $(this).attr("href")
											+ "'>");
			actionForm.attr("action", "${contextPath}/board/read");
			actionForm.submit();
		});

		var searchForm = $("#searchForm");

		$("#searchForm button").on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				
				return false;
			}

			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");
			
			e.preventDefault();

			searchForm.submit();

		});

	});
</script>
<%@include file="include/footer.jsp"%>