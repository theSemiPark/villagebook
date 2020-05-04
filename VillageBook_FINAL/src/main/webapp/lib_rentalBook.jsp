<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여현황</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>

	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/libraryHeader.jsp"%>
		</div>
	</header>
	<br>

	<h2>대여현황</h2>
	
	<c:set var="sum" value="0"/>
	<table>
		<tr>
<!-- 			<th width="100">아이디</th> -->
			<th width="180">책 제목</th>
			<th width="100">ISBN</th>
			<th width="100">대여개수</th>
			<th width="100">보유권수</th>
		</tr>

		<c:set var="total" value="0"/>
		<c:set var="total2" value="0"/>
		<c:if test="${rentalList ==  '[]'}"><tr><td colspan="4">해당 내역이 없습니다</td></tr></c:if>
		<c:forEach items="${rentalList }" var="rental" varStatus="status">
			<tr>
				<td>${rental.bookname}</td>
				<td>${rental.isbn }</td>
				<td>
					<c:if test="${rental.rcnt > 0}">
					<a href="lib_rentalStatus.do?isbn=${rental.isbn}">${rental.rcnt }</a>
					</c:if>
					<c:if test="${rental.rcnt <= 0}">
					${rental.rcnt}
					</c:if>
				</td>
				<td>${rental.havecnt }</td>
			</tr>
			<c:set var="total" value="${total + rental.rcnt }"/>
			<c:set var="total2" value="${total2 + rental.havecnt }"/>
		</c:forEach>
		
		<p>총 대여개수 : <c:out value="${total }"/>권 / 총 보유권수 : <c:out value="${total2 }"/>권</p>

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