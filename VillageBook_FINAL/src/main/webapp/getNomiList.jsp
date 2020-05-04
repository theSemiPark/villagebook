<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서 추천하기</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include file="/headers/userHeader.jsp" %></c:when>
				<c:when test="${lid == 'admin'}"><%@ include file="/headers/adminHeader.jsp" %></c:when>
				<c:otherwise><%@ include file="/headers/libraryHeader.jsp" %></c:otherwise>
			</c:choose>
		</div>
	</header><br>

		<h2>도서 추천하기</h2>
		
		<form action="getNomiList.do" method="post">
			<table>
				<tr style="background-color:white;">
					<td align="right"><select name="searchCondition">
					<c:forEach items="${conditionMap }" var="option">
						<option value="${option.value }">${option.key }</option>
					</c:forEach>
					</select> 
					<input name="searchKeyword" type="text" /> 
					<input type="submit" 	value="검색" /></td>
				</tr>
			</table>
		</form>

		<table class="list">
			<tr>
				<th width="50">번호</th>
				<th width="250">제목</th>
				<th width="120">작성자</th>
				<th width="100">등록일</th>
				<th width="50">조회수</th>
				<th width="100">별점</th>
				<th width="30"><img src="img/heart-on.png" width="15"></th>
			</tr>
			<c:if test="${nomiList ==  '[]'}"><tr><td colspan="7">등록된 글이 없습니다</td></tr></c:if>
			<c:forEach items="${nomiList}" var="nomi">
				<tr>
					<td>${nomi.seq }</td>
					<td align="left"><a href="getNomi.do?seq=${nomi.seq }">
							${nomi.title }</a></td>
					<td>${nomi.writer }</td>
					<td>${nomi.regDate }</td>
					<td>${nomi.cnt }</td>
					<td><div id="rating_${nomi.seq}"></div>
					<script>
						var rating = document.getElementById("rating_${nomi.seq}");						
 						for(var i = 0 ; i < "${nomi.rating}" ; i++)
 							rating.innerHTML += "<img src='stars/images/star-on.png'>";
 						for(var i = "${nomi.rating}" ; i < 5 ; i++)
 							rating.innerHTML += "<img src='stars/images/star-off.png'>";
					</script>
					</td>
					<td>${nomi.howManyHeart}</td>
				</tr>
			</c:forEach>
		</table>
		<br> <a href="insertNomi.jsp">새 글 등록</a> &nbsp;
		<a href="mainPage.do">메인 페이지</a>
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