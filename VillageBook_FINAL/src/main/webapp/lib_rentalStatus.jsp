<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여현황</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
.blue {
color: lightblue;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/libraryHeader.jsp"%>
		</div>
	</header>
	<br>
	<div>
	<h2>대여현황</h2>
		<c:forEach items="${rentalStatus }" var="status">
			<h3 class="blue">${status.bookname }</h3>
			<table>
				<tr>
					<th>대여날짜</th>
					<th>고객명</th>
					<th>아이디</th>
				</tr>
				<tr>
					<td>${status.orderdate }</td>
					<td>${status.cname }</td>
					<td>${status.cid }</td>
				</tr>
			</table>
		</c:forEach>
	</div>
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