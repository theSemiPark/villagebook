<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<title>동네북 Library Main Page</title>
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

p{
color:lightgray;
font-size: 13px;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/libraryHeader.jsp"%>
		</div>
	</header>
	<br>
	<div class="wrapper">
		<div class="multiple-items">

			<div>
				<h2>🔮인기가 높은 책 👍</h2>
				<p>선호도를 파악하고 신권등록에 참고하세요!</p>
				<table>
					<tr>
						<th>도서명</th>
						<th>ISBN</th>
						<th width="70px">누적대여</th>
					</tr>
					<c:if test="${BestBook == '[]' }"><tr><td colspan="3">해당 내역이 없습니다</td></tr></c:if>
					<c:forEach items="${BestBook }" var="best">
						<tr onclick="location.href='lib_modifyBook.do?isbn=${best.isbn}'">
							<td>${best.bookname }</td>
							<td>${best.isbn }</td>
							<td>${best.ordercnt }</td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<div>
				<h2>대여 현황 📖</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>주문번호</th>
						<th>반납예정일</th>
					</tr>
					<c:if test="${ship2 == '[]' }"><tr><td colspan="3">해당 내역이 없습니다</td></tr></c:if>
					<c:forEach items="${ship2}" var="order">
						<tr onclick="location.href='lib_rentalBook.do?ordid=${order.ordid}'">
							<td>${order.cid }</td>
							<td>${order.ordid }</td>
							<td>${order.returndate }</td>
						</tr>
					</c:forEach>
				</table>
			</div>

			<div>
				<h2>반납 요청🙏</h2>
				<table>
					<tr>
						<th>고객ID</th>
						<th>반납일</th>
					</tr>
					<c:if test="${returnY == '[]' }">
						<tr>
							<td colspan="2">해당 내역이 없습니다</td>
						</tr>
					</c:if>

					<c:forEach items="${returnY}" var="order">
						<tr onclick='location.href = "lib_getReturnList.do"'>
							<td>${order.cid }</td>
							<td>${order.returndate }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>




	<script type="text/javascript" src="slick/slick.js"></script>
	<script type="text/javascript" src="slick/slick.min.js"></script>
	<script>
		$(".multiple-items").slick({
			infinite : true,
			slidesToShow : 2,
			slidesToScroll : 1,
			arrows : true,
			dots : false
		});
	</script>

	<footer id="footer">
		<div id="footer_box">
			<%@ include file="/footers/libraryFooter.jsp"%>
		</div>
	</footer>
</body>
</html>