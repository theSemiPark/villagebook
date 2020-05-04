<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서 추천하기 등록</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
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
	<h2>도서 추천하기 등록</h2>

	<br>
	<form action="insertNomi.do" method="post">
		<table>
			<tr>
				<th width="70">제목</th>
				<td align="left"><input type="text" name="title" required/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<c:choose>
					<c:when test="${cid != null}">
						<td align="left"><input type="text" name="writer"
							value="${cid }" readonly /></td>
					</c:when>
					<c:otherwise>
						<td align="left"><input type="text" name="writer"
							value="${lname }" readonly /></td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<th>내용</th>
				<td align="left"><textarea name="content" cols="90" rows="10" required></textarea></td>
			</tr>
			<tr>
				<th>별점</th>
				<td align="left" width="600"><input type="hidden" name="rating" id="rating"
					value="5" min="0" max="5" step="1" required/>
					<div id="star"></div>
					<script type="text/javascript" src="stars/jquery.raty.js"></script>
					<script type="text/javascript">
						$(function() {
							$('div#star').raty({
								score : 5,
								path : "stars/images/",
								width : 200,
								click : function(score, evt) {
									$("#rating").val(score);
								}
							});
						});
					</script></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value=" 새 글 등록 " /></td>
			</tr>
		</table>
	</form>
	<br>
	<a href="getNomiList.do">글 목록 가기</a>

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