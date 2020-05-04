<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>배송정보 상세</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
th{
	width: 150px;
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
	<h2>배송정보 상세</h2>
	<table>
		<tr>
			<th>이름</th>
			<td>${user.cname}</td>
			<th>아이디</th>
			<td>${user.cid}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td colspan="3">${user.caddr1} ${user.caddr2} (우: ${user.cpostcode})</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td colspan="3">${user.chp}</td>
		</tr>
	</table>
	<h3>상품 목록</h3>
	<table>
		<tr>
			<th>책 이름</th><th>ISBN</th><th>수량</th>
		</tr>
		<c:forEach items="${detailList}" var="detail">
			<tr>
				<td>${detail.bookname}</td><td>${detail.isbn}</td><td>${detail.ordercnt}</td>
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