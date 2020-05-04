<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="content-type" charset="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서관 정보</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table{
width: 500px;
}

input {
  width:300px;
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

	<h2>정보수정</h2>
	<form action="lib_myInfo.do" method="post">
		<table>
			<tr>
				<th>도서관명</th>
				<td>${lname}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${ltel}</td>
			</tr>

			<tr>
				<th>공휴일</th>
				<td><input type="text" name="lholiday" value="${lholiday }" width="150px" required/></td>
			</tr>
			<tr>
				<th>운영시간</th>
				<td><input type="text" name="loperate" value="${loperate }" required/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${laddr}</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
			<input type="submit" class="mod" value="수정" style="width: 50px" />
			<script>
			</script>
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