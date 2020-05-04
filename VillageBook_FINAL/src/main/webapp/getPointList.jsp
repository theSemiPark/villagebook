<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>포인트 조회</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table{
	width: 600px;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp" %>
		</div>
	</header><br>
	
	<h2>포인트 조회</h2>
	
	<b>${user.cname}</b>님은 ${user.crank }등급입니다 / 현재 포인트 : <b>${user.cpoint }point</b><br><br>
	<table class="list"><tr><th width="200">주문번호</th><th width="150">적립내역</th><th width="150">차감내역</th></tr>
	<c:forEach items="${pointList }" var="point">
		<tr><td>
		<c:choose>
		<c:when test="${point.ordid == 3}">
		관리자 권한
		</c:when>
		<c:when test="${point.ordid == 2}">
		연체료
		</c:when>
		<c:when test="${point.ordid == 1}">
		주문 취소
		</c:when>
		<c:when test="${point.ordid == 0}">
		welcome point
		</c:when>
		<c:otherwise>
		<a href="delivery.do?ordid=${point.ordid}">${point.ordid}</a>
		</c:otherwise>
		</c:choose>
		</td><td>${point.plusp}point</td><td>-${point.minusp}point</td></tr>
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