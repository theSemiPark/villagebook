<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서 추천하기 수정</title>
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
	<h2>도서 추천하기 수정</h2>

	<hr>

			<form action="updateNomi.do?seq=${nomi.seq }" method="post">
				<table>
					<tr>
						<th width="70">제목</th>
						<td align="left"><input type="text" name="title"
							value="${nomi.title }" required/></td>
					</tr>
					<tr>
						<th width="70">작성자</th>
						<td align="left"><input type="text" name="writer"
							value="${nomi.writer }" readonly /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td align="left"><textarea name="content" cols="90" rows="10" required>${nomi.content }</textarea></td>
					</tr>
					<tr>
						<th>별점</th>
						<td align="left" width="600"><input type="hidden"
							name="rating" id="rating" value="${nomi.rating }" min="0" max="5"
							step="1" required/>
							<div id="star"></div>
					<script type="text/javascript" src="stars/jquery.raty.js"></script>
					<script type="text/javascript">
						$(function() {
							$('div#star').raty({
								score : "${nomi.rating}",
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
						<td colspan="2" align="center">
						<input type="button" value="글 수정 " id="sub" />
						<script>
							$("#sub").click(function(){
								if("${lid}" == 'admin'){
									$("form").attr("action", "updateNomiByAdmin.do?seq=${nomi.seq }");
								}
								if($('input[name="title"]').val() == "" || $('textarea[name="content"]').val() == "")
									alert("제목과 내용은 필수 입력입니다");
								else $("form").submit();
							});
						</script>
						</td>
					</tr>
				</table>
			</form>
	<hr>
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