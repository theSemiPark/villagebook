<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>대여상태조회</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/adminHeader.jsp"%>
		</div>
	</header>
	<br>

	<h2>대여상태조회</h2>
	
	<form action="getDelivery_admin.do" method="post">
		<table id="filter">
			<tr>
				<th>배송상태</th>
				<td><select name="shipping">
						<c:forEach items="${conditionMap_ship}" var="option">
							<option value="${option.value }">${option.key }
						</c:forEach>
					</select>
				</td>
				<th>반납상태</th>
				<td>
					<select name="returnwer">
						<c:forEach items="${conditionMap_return}" var="option">
							<option value="${option.value }">${option.key }
						</c:forEach>
					</select>
				</td>
				<th>주문일자</th>
				<td><input type="date" name="orderdate" value="2020-01-01" required> <font size="2">이후</font></td>
				<td><button type="submit">검색</button></td>
			</tr>
		</table>
	</form>
	<br>
	<table>
		<tr>
			<th>주문번호</th>
			<th>주문일자</th>
			<th>배송상태</th>
			<th>반납상태</th>
			<th>주문자ID</th>
		</tr>
		<c:if test="${deliveryList ==  '[]'}"><tr><td colspan="5">해당 내역이 없습니다</td></tr></c:if>
		<c:forEach items="${deliveryList}" var="delivery">
			<tr>
				<td><a href="getOrderLib_admin.do?ordid=${delivery.ordid}">${delivery.ordid}</a></td>
				<td>${delivery.orderdate}</td>
				<td>
					<c:choose>
						<c:when test="${delivery.shipping == 0}">배송전</c:when>
						<c:when test="${delivery.shipping == 1}">배송중</c:when>
						<c:when test="${delivery.shipping == 2}">배송완료</c:when>
						<c:when test="${delivery.shipping == 5}">주문취소</c:when>
					</c:choose>
					<c:if test="${delivery.shipcnt > 1}"> 외</c:if>
				</td>
				<td>
					<c:choose>
						<c:when test="${delivery.returnwer == 'N' }">반납전</c:when>
						<c:when test="${delivery.returnwer == 'R' }">반납요청</c:when>
						<c:when test="${delivery.returnwer == 'Y' }">반납완료</c:when>
					</c:choose>
					<c:if test="${delivery.retcnt > 1 }"> 외</c:if>
				</td>
				<td>${delivery.cid}</td>
			</tr>
		</c:forEach>
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