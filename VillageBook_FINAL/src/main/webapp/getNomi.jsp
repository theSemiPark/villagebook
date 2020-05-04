<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서 추천하기 상세</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
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

	<h2>도서 추천하기 상세</h2>
	<table>
		<tr>
			<th width="70">번호</th>
			<td align="left" colspan="2">${nomi.seq }</td>
		</tr>
		<tr>
			<th width="70">제목</th>
			<td align="left" colspan="2">${nomi.title }</td>
		</tr>
		<tr>
			<th width="70">작성자</th>
			<td align="left" colspan="2">${nomi.writer}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td align="left" width="600" colspan="2"><textarea
					name="content" cols="90" rows="10" readonly style="outline: none;">${nomi.content }</textarea></td>
		</tr>
		<tr>
			<th>별점</th>
			<td align="left" width="600" colspan="2"><div id="rating"></div>
				<script>
					var rating = document.getElementById("rating");
					for (var i = 0; i < "${nomi.rating}"; i++)
						rating.innerHTML += "<img src='stars/images/star-on.png'>";
					for (var i = "${nomi.rating}"; i < 5; i++)
						rating.innerHTML += "<img src='stars/images/star-off.png'>";
				</script></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td align="left" colspan="2">${nomi.regDate }</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td align="left">${nomi.cnt }</td>
			<td align="center" width="40"><img src="img/heart-off.png"
				width="18" id="heart" style="cursor: pointer"> <span
				id="heartMany">${nomi.howManyHeart }</span> <script>
					if ("${nomi.didIHeart}" == "true")
						$("#heart").attr("src", "img/heart-on.png");
					$("#heart").click(function() {
						if ($("#heart").attr("src") == "img/heart-off.png") {
							var seq = "${nomi.seq}";
							$("#heart").attr("src", "img/heart-on.png");
							heartMany = $("#heartMany").text();
							$("#heartMany").text(Number(heartMany) + 1);
							$.ajax({
								url : "insertNomiHeart.do",
								type : "post",
								data : {
									seq : seq
								},
								success : function(result) {
									if (result) {
										//location.href = "getNomi.do?seq=${nomi.seq}";
									} else {
										alert("좋아요 실패");
									}
								}
							});
						} else {
							var seq = "${nomi.seq}";
							$("#heart").attr("src", "img/heart-off.png");
							heartMany = $("#heartMany").text();
							$("#heartMany").text(Number(heartMany) - 1);
							$.ajax({
								url : "deleteNomiHeart.do",
								type : "post",
								data : {
									seq : seq
								},
								success : function(result) {
									if (result) {
										//location.href = "getNomi.do?seq=${nomi.seq}";
									} else {
										alert("좋아요 취소 실패");
									}
								}
							});
						}
					});
				</script></td>
		</tr>
	</table>
	<br>
	<c:if
		test="${cid eq nomi.writer|| lname eq nomi.writer ||  lid eq 'admin' }">
		<a href="deleteNomi.do?seq=${nomi.seq }">글삭제</a> &nbsp;&nbsp;&nbsp;
			<a href="editNomi.do?seq=${nomi.seq }">글수정</a>
	</c:if>
	&nbsp;&nbsp;&nbsp;
	<a href="getNomiList.do">글목록</a>

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