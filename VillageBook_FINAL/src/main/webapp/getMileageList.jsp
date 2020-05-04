<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>회원 목록</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>

	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/adminHeader.jsp" %>
		</div>
	</header><br>
	
	<h2>회원 목록</h2>

	<table class="list">
		<tr>
			<th width="100">회원 ID</th>
			<th width="100">회원명</th>
			<th width="100">등급</th>
			<th width="100">마일리지</th>
		</tr>

		<c:forEach items="${mileageList }" var="mileage">
			<tr>
				<td>${mileage.cid }</td>
				<td>${mileage.cname }</td>
				<td>${mileage.crank }</td>
				<td>${mileage.cpoint }</td>
			</tr>
		</c:forEach>
	</table>
	<br>
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