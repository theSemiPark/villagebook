<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>대여관리 상세</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	width: 800px;
}

button {
	color: #B4C7E7;
	background: none;
	border: 0px;
	cursor: pointer;
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
	
	<h2>대여관리 상세</h2>

	<table>
		<tr>
			<th colspan="3">주문번호</th><td colspan="3">${orderInfo.ordid}</td>
		</tr>
		<tr>
			<th>고객ID</th><td>${orderInfo.cid}</td>
			<th>주문일자</th><td>${orderInfo.orderdate}</td>
			<th>주문금액</th><td>${orderInfo.ordmoney}원</td>
		</tr>
	</table>
	<br>
	<table>
		<tr>
			<th width="160px">도서관</th>
			<th width="160px">대여일</th>
			<th width="160px">반납일</th>
			<th width="80px">배송현황</th>
			<th width="80px">연장여부</th>
			<th width="80px">반납여부</th>
			<th width="80px"></th>
			<c:forEach items="${deliveryList}" var="delivery">
				<tr>
					<td>${delivery.lname}</td>
					<td>${delivery.startdate}</td>
					<td>${delivery.returndate}</td>
					<td><c:if test="${delivery.shipping == 0 }">배송전</c:if> <c:if
							test="${delivery.shipping == 1 }">배송중</c:if> <c:if
							test="${delivery.shipping == 2 }">배송완료</c:if> <c:if
							test="${delivery.shipping == 5 }">주문취소</c:if></td>
					<td><c:if test="${delivery.renewtf == 'N'}">X</c:if> <c:if
							test="${delivery.renewtf == 'Y'}">O</c:if></td>
					<td><c:if test="${delivery.returnwer == 'N'}">X</c:if>
					<c:if test="${delivery.returnwer == 'R'}">요청</c:if><c:if
							test="${delivery.returnwer == 'Y'}">O</c:if></td>
					<td><button class="detail_${delivery.lid}">상세</button></td>
				</tr>
				<tbody id="detail_${delivery.lid}_view"></tbody>
				<script>
					$("#detail_${delivery.lid}_view").hide();
					$(".detail_${delivery.lid}")
							.click(
									function() {
										if ($(this).text() == "상세") {
											var ordid = "${delivery.ordid}";
											var lid = "${delivery.lid}";
											var html = "";
											$
													.ajax({
														url : "getOrderLibBook_admin.do",
														type : "post",
														data : {
															ordid : ordid,
															lid : lid
														},
														async : "false",
														dataType : "json",
														success : function(
																result) {
															if (result) {
																html += "<td colspan=7><table style='border:0px; background: #ddd; width: 750px'>";
																for (var i = 0; i < result.length; i++) {
																	html += "<tr>";
																	html += "<td width='450px'>";
																	html = html
																			+ result[i].bookname;
																	html += "</td>";
																	html += "<td>";
																	html += result[i].isbn;
																	html += "</td>";
																	html += "<td>";
																	html += result[i].ordercnt;
																	html += "권</td>";
																	html += "</tr>";
																}
																html += "</table></td>";
																document
																		.getElementById("detail_${delivery.lid}_view").innerHTML = html;
																$(
																		"#detail_${delivery.lid}_view")
																		.fadeIn();
															} else {
																alert("조회 실패");
															}
														}
													});
											$(this).text("닫기");
										} else {
											$("#detail_${delivery.lid}_view")
													.hide();
											$(this).text("상세");
										}
									});
				</script>
			</c:forEach>
	</table>
	<br>
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