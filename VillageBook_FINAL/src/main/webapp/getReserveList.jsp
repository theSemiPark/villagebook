<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>예약 관리</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table{
	width: 800px;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp" %>
		</div>
	</header><br>
	
	<h2>예약 관리</h2>

	<table class="list">
		<tr>
			<th>도서명</th>
			<th width="120px">ISBN</th>
			<th width="120px">도서관</th>
			<th width="100px">예약우선순위</th>
			<th width="50px">삭제</th>
		</tr>
			<c:if test="${reserveList ==  '[]'}"><tr><td colspan="5">예약하신 책이 없습니다</td></tr></c:if>
			<c:forEach items="${reserveList}" var="reserve">
				<tr>
					<td>${reserve.bookname}</td>
					<td>${reserve.isbn}</td>
					<td>${reserve.lname}</td>
					<td>
						<c:if test="${reserve.revrank != 0}">${reserve.revrank}</c:if>
						<c:if test="${reserve.revrank == 0}">
							<input type="button" class="cart_${reserve.revid}" value="장바구니">
							<script>
								$(".cart_${reserve.revid}").click(function(){
									var bookname = '${reserve.bookname}';
									var lid = '${reserve.lid}';
									var lname = '${reserve.lname}';
									var isbn = '${reserve.isbn}';
									$.ajax({
										url : "insertCart.do",
										type : "post",
		 								data : {bookname : bookname, isbn : isbn, lId : lid, lname : lname},
										success : function(result){
											if(result) {
												location.href = "getCart.do?";
											} else {
												alert("장바구니에 넣기 실패");
											}
										}
									});
								});
							</script>
						</c:if>
					</td>
					<td><button type="button" class="delete_${reserve.revid}" data-revid="${reserve.revid}" data-lid="${reserve.lid}" data-isbn="${reserve.isbn}" data-revrank="${reserve.revrank}">삭제</button>
					<script>
						$(".delete_${reserve.revid}").click(function(){
							var revid = $(this).attr("data-revid");
							var isbn = $(this).attr("data-isbn");
							var revrank = $(this).attr("data-revrank");
							var lid = $(this).attr("data-lid");
							$.ajax({
								url : "deleteReserve.do",
								type : "post",
								data : {revid : revid, isbn : isbn, revrank : revrank, lid : lid},
								success : function(result){
									if(result) {
										location.href = "getReserveList.do";
									} else {
										alert("삭제 실패");
									}
								}
							})
						});
					</script>
					</td>
				</tr>
			</c:forEach>
	</table>
	<footer id="footer">
		<div id="footer_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include file="/footers/userFooter.jsp" %></c:when>
				<c:when test="${lid == 'admin'}"><%@ include file="/footers/adminFooter.jsp" %></c:when>
				<c:otherwise><%@ include file="/footers/libraryFooter.jsp" %></c:otherwise>
			</c:choose>
		</div>
	</footer>
</body>
</html>