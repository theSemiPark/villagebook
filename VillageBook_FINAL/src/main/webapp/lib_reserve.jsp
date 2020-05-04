<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>예약도서관리</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/libraryHeader.jsp" %>
		</div>
	</header><br>
	
	<h2>예약도서관리</h2>
	<table class="list">
		<tr>
			<th>도서명</th>
			<th>ISBN</th>
			<th>예약우선순위</th>
			<th>예약자</th>
			<th>삭제</th>
		</tr>
			<c:if test="${reserveList ==  '[]'}"><tr><td colspan="5">해당 내역이 없습니다</td></tr></c:if>
			<c:forEach items="${reserveList}" var="reserve">
				<tr>
					<td>${reserve.bookname}</td>
					<td>${reserve.isbn}</td>
					<td>${reserve.revrank}</td>
					<td>${reserve.cid}</td>
					<td><button type="button" class="delete_${reserve.revid}" data-revid="${reserve.revid}" data-isbn="${reserve.isbn}" data-revrank="${reserve.revrank}">삭제</button>
					<script>
						$(".delete_${reserve.revid}").click(function(){
							var revid = $(this).attr("data-revid");
							var isbn = $(this).attr("data-isbn");
							var revrank = $(this).attr("data-revrank");
							$.ajax({
								url : "deleteReserve.do",
								type : "post",
								data : {revid : revid, isbn : isbn, revrank : revrank},
								success : function(result){
									if(result) {
										location.href = "lib_reserve.do";
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