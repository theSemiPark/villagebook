<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 조정</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/adminHeader.jsp"%>
		</div>
	</header>
	<br>

	<h2>포인트 조정</h2>

	<form action="pointUpdates.do" method="post">
		<table>
			<tr>
				<td><p>${point.cname } 회원님</p></td>
			</tr>
			<tr>
				<td>새 포인트 :</td>
				<td><input type="number" name="cpoint" value="${point.cpoint }" required></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
				<input type="submit" value="수정" style="width: 50px" required/>
			</tr>
		</table>
	</form>
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