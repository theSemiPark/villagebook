<%@ page language="java" import="java.sql.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서 수정/삭제</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	width: 1000px;
}
</style>
</head>

<body bgcolor="white" text="black">

	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include file="/headers/userHeader.jsp" %></c:when>
				<c:when test="${lid == 'admin'}"><%@ include file="/headers/adminHeader.jsp" %></c:when>
				<c:otherwise><%@ include file="/headers/libraryHeader.jsp" %></c:otherwise>
			</c:choose>
		</div>
	</header>
	<br>
	<h2>도서 수정/삭제</h2>
<!-- 검색 시작 -->
	<form action="getLibBookList.do" method="post">
		<table>
			<tr style="background-color:white;">
<!-- 			<tr> -->
<!-- 				<th width="30%">ID</th> -->
<%-- 				<td>${lid }</td> --%>
				<td align="right"><select name="searchCondition">
						<c:forEach items="${conditionMap }" var="option">
							<option value="${option.value}">${option.key}</option>
						</c:forEach>
						
				</select> 
				<input name="searchKeyword" type="text" /> 
				<input type="submit" value="검색" />
				</td>
			
			</tr>
				
		</table>
	</form>
	<!-- 검색 종료 -->

	<table class="list">

		<tr>
			<th width="150">
				<p align="center">
					<span style="font-size: 10pt;"><b>ISBN</b></span>
				</p>
			</th>
			<th width="300">
				<p align="center">
					<span style="font-size: 10pt;"><b>제목</b></span>
				</p>
			</th>
			<th width="200">
				<p align="center">
					<span style="font-size: 10pt;"><b>저자</b></span>
				</p>
			</th>
			<th width="150">
				<p align="center">
					<span style="font-size: 10pt;"><b>출판사</b></span>
				</p>
			</th>
			<th width="150">
				<p align="center">
					<span style="font-size: 10pt;"><b>카테고리</b></span>
				</p>
			</th>
			<th width="200">
				<p align="center">
					<span style="font-size: 10pt;"><b>출판일</b></span>
				</p>
			</th>
			

		</tr>
		<c:if test="${bookList ==  '[]'}"><tr><td colspan="6">해당 내역이 없습니다</td></tr></c:if>
		<c:forEach items="${bookList}" var="book">
			<tr>
				<td> <a	href="lib_modifyBook.do?isbn=${book.isbn }">${book.isbn }</a></td>
				<td>${book.bookname }</td>
				<td>${book.author }</td>
				<td>${book.publisher}</td>
				<td>${book.genre }</td>
				<td>${book.pdate }</td>
			</tr>

		</c:forEach>
		
		<tr  style="background-color:white;">
			<td colspan="6" width="1350">
				<p align="center">
					<b><a href="libraryMainPage.do"> 뒤로</a></b>
				</p>
			</td>
		</tr>
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