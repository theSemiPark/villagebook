<%@page import="com.spring.biz.delivery.DeliveryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>대여 히스토리 상세</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table{
	width: 600px;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp" %>
		</div>
	</header><br>
	<h2>대여 히스토리 상세</h2>
	<c:set var="lname" value="0"/>
	
	<c:forEach items="${boardList }" var="board">
		<c:if test="${board.lname != lname }">
			<table><tr><td colspan="3">${board.lname }</td></tr></table>
			<br>
		</c:if>
		
			
		
		<table>
			<tr>
				<td colspan="1" bgcolor="#dae3f3">주문번호</td>
				<td colspan="2">${board.ordid }</td>
			</tr>
			<tr>
				<td colspan="1" bgcolor="#dae3f3">책 이름</td>
				<td colspan="2">${board.bookname }</td>
			</tr>
			<tr>
				<td colspan="1" bgcolor="#dae3f3">ISBN</td>
				<td colspan="2">${board.isbn }</td>
			</tr>
			<tr>
				<td colspan="1" bgcolor="#dae3f3">수량</td>
				<td colspan="2">${board.ordercnt }</td>
			</tr>
			<tr>
				<td colspan="1" bgcolor="#dae3f3">배송비</td>
				<td colspan="2">${board.ordmoney }</td>
			</tr>
			<tr>
				<td bgcolor="#dae3f3" width="100">주문일</td>
				<td bgcolor="#dae3f3" width="100">대여일</td>
				<td bgcolor="#dae3f3" width="100">반납일</td>
			</tr>
			<tr>
				<td>${board.orderdate }</td>
				<td>${board.startdate }</td>
				<td>${board.returndate }</td>
			</tr>
			<tr>
				<td colspan="1" bgcolor="#dae3f3">배송 현황</td>
				<td colspan="2"><c:choose>
						<c:when test="${board.shipping == 0 }">배송 준비중</c:when>
						<c:when test="${board.shipping == 1 }">배송 중</c:when>
						<c:when test="${board.shipping == 2 }">배송 완료</c:when>
						<c:when test="${board.shipping == 5 }">주문 취소</c:when>
						<c:otherwise>확인 중</c:otherwise>
					</c:choose></td>
			</tr>
		</table>
		<br>
		<c:set var="lname" value="${board.lname}"/>
	</c:forEach>
	<a href="deliveryHistoryList.do">대여 히스토리 전체 목록</a>
	
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