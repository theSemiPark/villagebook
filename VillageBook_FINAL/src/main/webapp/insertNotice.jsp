<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>공지사항 등록</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${lid == 'admin'}"><%@ include file="/headers/adminHeader.jsp" %></c:when>
				<c:otherwise><%@ include file="/headers/libraryHeader.jsp" %></c:otherwise>
			</c:choose>
		</div>
	</header><br>
	
		<h2>공지사항 등록</h2>

		<form action="insertNotice.do" method="post">
			<table>
				<tr>
					<th>제목</th>
					<td align="left"><input type="text" name="title" required/></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td align="left"><input type="text" name="writer" value="${lname }" readonly/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td align="left"><textarea name="content" cols="80" rows="10" required></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value=" 새 글 등록 " /></td>
				</tr>
			</table>
		</form>
		<br>
		<a href="getNoticeList.do">글 목록 가기</a>
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