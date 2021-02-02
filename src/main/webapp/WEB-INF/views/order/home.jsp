<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<section>
	<h1>
		주문 결제 페이지
	</h1>
	<from>
		<table>
			<caption>List</caption>
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="5%">
				<col width="5%">
			</colgroup>
			<thead>
				<tr>
					<th>aaa</th>
					<th>bbb</th>
					<th>ccc</th>
					<th>ddd</th>
					<th>eee</th>
				</tr>
			</thead>
			<tbody>
				<%-- <c:choose>
					<c:when test="${empty orderList }">
						<tr><td colspan="5" align="center">주문 데이터가 없습니다</td></tr>
					</c:when>
						<c:forEach var="list" items="${orderList }" varStatus="sts">
							<tr id="">
								<input>
							</tr>						
						</c:forEach>
				</c:choose> --%>
			</tbody>
		</table>
	</from>
</section>

<%@ include file="../include/footer.jsp" %>