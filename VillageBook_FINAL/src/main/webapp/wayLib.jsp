<%@ page language="java" import="java.sql.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서관용 사용법 안내</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	width: 1000px;
}
</style>
</head>

<body bgcolor="white" text="black" oncontextmenu='return false'>

	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include
						file="/headers/userHeader.jsp"%></c:when>
				<c:when test="${lid == 'admin'}"><%@ include
						file="/headers/adminHeader.jsp"%></c:when>
				<c:otherwise><%@ include
						file="/headers/libraryHeader.jsp"%></c:otherwise>
			</c:choose>
		</div>
	</header>
	<br>
	<h2>
	<br>
		<font color="#333333">도서관용 사용법 안내</font>
	</h2>
	<br><br>
	<a href = "wayLibRental.jsp"><img src="img/rental.png" width="200px"></a>   <a href = "wayLibReturn.jsp"><img src="img/return.png" width="200px"></a>   <a href = "wayLibCommute.jsp"><img src="img/commute.png" width="200px"></a>
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