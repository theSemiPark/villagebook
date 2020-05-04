<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<title>Admin Main Page</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<link rel="stylesheet" type="text/css" href="slick/slick.css">
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css">
<style>
.wrapper {
	width: 80%;
	position: relative;
	left: 50%;
	right: 50%;
	margin-left: -40%;
}

table {
	border-radius: 7px;
	border: 7px solid #E8EDF7;
	width: 95%;
	border-spacing: 0 7px;
	background: #E8EDF7;
	box-shadow: 3px 3px #dae3f3;
}

th {
	background: #E8EDF7;
}

td {
	background: white;
}

th, td {
	padding: 5px;
}

td:nth-child(1) {
	border-radius: 5px 0px 0px 5px;
}

td:nth-child(3) {
	border-radius: 0px 5px 5px 0px;
}

td:first-child:last-child {
	border-radius: 5px 5px 5px 5px;
}

.multiple-items div {
	outline: none;
	padding-bottom: 5px;
}
</style>

</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/adminHeader.jsp"%>
		</div>
	</header>
	<br>
	<div class="wrapper">
		<div class="multiple-items">
			<div>
				<h2>🎉 New Order 🎉</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>주문일</th>
						<th>주문금액</th>
					</tr>
					<c:if test="${newOrder == '[]' }">
						<tr>
							<td colspan="3">해당 내역이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach items="${newOrder}" var="order">
						<tr
							onclick="location. href = 'getOrderLib_admin.do?ordid=${order.ordid}'"
							style="cursor: pointer">
							<td>${order.cid}</td>
							<td>${order.orderdate}</td>
							<td>${order.ordmoney}원</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div>
				<h2>배송 전 📦</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>도서관</th>
						<th>주문일</th>
					</tr>
					<c:if test="${ship0 == '[]' }">
						<tr>
							<td colspan="3">해당 내역이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach items="${ship0}" var="order">
						<tr
							onclick="location. href = 'getOrderLib_admin.do?ordid=${order.ordid}'"
							style="cursor: pointer">
							<td>${order.cid}</td>
							<td>${order.lname}</td>
							<td>${order.orderdate}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div>
				<h2>배송 중 🚛</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>도서관</th>
						<th>주문일</th>
					</tr>
					<c:if test="${ship1 == '[]' }">
						<tr>
							<td colspan="3">해당 내역이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach items="${ship1}" var="order">
						<tr
							onclick="location. href = 'getOrderLib_admin.do?ordid=${order.ordid}'"
							style="cursor: pointer">
							<td>${order.cid}</td>
							<td>${order.lname}</td>
							<td>${order.orderdate}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div>
				<h2>🌾🌾👩‍🌾👨‍🌾‍🌾</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>도서관</th>
						<th>반납예정일</th>
					</tr>
					<c:if test="${ship2 == '[]' }">
						<tr>
							<td colspan="3">해당 내역이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach items="${ship2}" var="order">
						<tr
							onclick="location. href = 'getOrderLib_admin.do?ordid=${order.ordid}'"
							style="cursor: pointer">
							<td>${order.cid}</td>
							<td>${order.lname}</td>
							<td>${order.returndate}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div>
				<h2>반납 요청 🍚</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>도서관</th>
						<th>반납예정일</th>
					</tr>
					<c:if test="${returnR == '[]' }">
						<tr>
							<td colspan="3">해당 내역이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach items="${returnR}" var="order">
						<tr
							onclick="location. href = 'getOrderLib_admin.do?ordid=${order.ordid}'"
							style="cursor: pointer">
							<td>${order.cid}</td>
							<td>${order.lname}</td>
							<td>${order.returndate}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div>
				<h2>반납 완료 📚</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>도서관</th>
						<th>반납일</th>
					</tr>
					<c:if test="${returnY == '[]' }">
						<tr>
							<td colspan="3">해당 내역이 없습니다</td>
						</tr>
					</c:if>
					<c:forEach items="${returnY}" var="order">
						<tr
							onclick="location. href = 'getOrderLib_admin.do?ordid=${order.ordid}'"
							style="cursor: pointer">
							<td>${order.cid}</td>
							<td>${order.lname}</td>
							<td>${order.returndate}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div style="float: right;">
			<a href="getDelivery_admin.do">more</a><br> <br> <br>
		</div>
	</div>


	<script type="text/javascript" src="slick/slick.js"></script>
	<script type="text/javascript" src="slick/slick.min.js"></script>
	<script>
		$(".multiple-items").slick({
			infinite : true,
			slidesToShow : 3,
			slidesToScroll : 2,
			arrows : true,
			dots : false
		});
	</script>
	<br><br>
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