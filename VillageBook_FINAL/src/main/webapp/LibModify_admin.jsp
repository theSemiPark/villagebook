<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서관 정보 수정</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
input{
	width: 530px;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/adminHeader.jsp"%>
		</div>
	</header>
	<br>

	<h2>도서관 정보 수정</h2>
	<form action="LibModify_admin.do" method="post">
		<table>
			<tr>
				<th width="150px">도서관명</th>
				<td><input type="text" value="${lib.lname}" name="lname" required></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="hidden" value="${lib.lid}" name="lid">${lib.lid}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" value="${lib.ltel}" name="ltel" required></td>
			</tr>
			<tr>
				<th>공휴일</th>
				<td><input type="text" value="${lib.lholiday}" name="lholiday" required></td>
			</tr>
			<tr>
				<th>운영시간</th>
				<td><input type="text" value="${lib.loperate}" name="loperate" required></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" value="${lib.laddr}" name="laddr" required></td>
			</tr>
		</table>
		
		<br><button type="submit">수정</button>
		<button type="reset">초기화</button>
		
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