<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>배송정보</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
button{
	background: #fff7e1;
	border: 0px;
	cursor: pointer;
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
	<h2>배송정보</h2>
	<table class="list">
		<tr>
			<th>주문번호</th>
			<th>주문일자</th>
			<th>배송상태</th>
			<th>주문자ID</th>
		</tr>
		<c:if test="${deliList ==  '[]'}"><tr><td colspan="4">해당 내역이 없습니다</td></tr></c:if>
		<c:forEach items="${deliList}" var="deli">
			<tr>
				<td>
					<a href="lib_deli_detail.do?ordid=${deli.ordid}">${deli.ordid}</a>
				</td>
				<td>${deli.orderdate}</td>
				<td>
					<c:if test="${deli.shipping == 0 }">배송 전</c:if>
					<c:if test="${deli.shipping == 1 }">배송 중</c:if>
					<c:if test="${deli.shipping == 2 }">배송 완료</c:if>
					<button type="button" class="update_${deli.ordid}" data-ordid="${deli.ordid}">▲</button>
					<script>
						$(".update_${deli.ordid}").click(function(){
							var ordid = $(this).attr("data-ordid");
							$.ajax({
								url : "lib_shipping_update.do",
								type : "post",
								data : {ordid : ordid},
								success : function(result){
									if(result){
										location.href = "lib_delivery.do";
									} else alert("배송정보 업데이트 실패");
								}
							});
						});
					</script>
				</td>
				<td>${deli.cid}</td>
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