<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>대여 취소/삭제</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<script>
function inputDate(obj) {

	var number = obj.value.replace(/[^0-9]/g, "");
	var date = "";

	if (number.length < 5) {
		return number;
	} else if (number.length < 7) {
		date += number.substr(0, 4);
		date += "-";
		date += number.substr(4);
	} else if (number.length < 9) {
		date += number.substr(0, 4);
		date += "-";
		date += number.substr(4, 2);
		date += "-";
		date += number.substr(6);
	} else {
		date += number.substr(0, 4);
		date += "-";
		date += number.substr(4, 2);
		date += "-";
		date += number.substr(6, 2);
	}
	obj.value = date;
}
</script>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/adminHeader.jsp" %>
		</div>
	</header><br>
	<h2>대여 취소/삭제</h2>
	<table><tr><td>
		삭제 기준일 : <input type="date" id="base" name="base" onKeyup="inputDate(this);" required>
		<button type="button" class="delete_past">삭제</button>
		<script>
			$(".delete_past").click(function(){
				var input1=$("#base").val();
				if(input1){
					var confirm_val = confirm("정말 삭제하시겠습니까?");
					if(confirm_val){
						var date = new Date();
						var input2 = new Date(input1)
						if (input2 - date >= 0) alert("오늘 이후의 날짜는 입력하실 수 없습니다.");
						else{
							$.ajax({
								url : "delete_delivery.do",
								type : "post",
								data : {input : input1},
								success : function(result){
									if(result) {
										location.href = "getOrder_admin.do";
									} else {
										alert("삭제 실패");
									}
								}
							});
						}
					}
				} else alert("날짜를 입력하세요");
			});
		</script>
	</td></tr></table>
	<br>
	<table>
		<tr>
			<th>주문번호</th>
			<th>주문일자</th>
			<th>주문금액</th>
			<th>배송상태</th>
			<th>반납상태</th>
			<th>주문자ID</th>
			<th></th>
		</tr>
		<c:if test="${deliveryList ==  '[]'}"><tr><td colspan="6">해당 내역이 없습니다</td></tr></c:if>
		<c:forEach items="${deliveryList}" var="delivery">
			<tr>
				<td>
					<a href="getOrderLib_admin.do?ordid=${delivery.ordid}">${delivery.ordid}</a>
				</td>
				<td>${delivery.orderdate}</td>
				<td>${delivery.ordmoney}</td>
				<td>
					<c:choose>
						<c:when test="${delivery.shipping == 0 }">배송전</c:when>
						<c:when test="${delivery.shipping == 1 }">배송중</c:when>
						<c:when test="${delivery.shipping == 2 }">배송완료</c:when>
						<c:when test="${delivery.shipping == 5 }">주문취소</c:when>
					</c:choose>
					<c:if test="${delivery.shipcnt > 1 }"> 외</c:if>
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
				<td>
					<c:if test="${delivery.shipping != 5 }">
						<button type="button" class="cancel_${delivery.ordid}"
							data-ordid="${delivery.ordid}" data-cid="${delivery.cid}">주문취소</button>
							<script>
								$(".cancel_${delivery.ordid}").click(function() {
									var ordid = $(this).attr("data-ordid");
									var cid = $(this).attr("data-cid");
									$.ajax({
										url : "delivery_cancel.do",
										type : "post",
										data : {ordid : ordid, cid : cid},
										success : function(result){
											if(result) {
												location.href = "getOrder_admin.do";
											} else {
												alert("주문취소 실패");
											}
										}
									});
								});
							</script>
						</c:if>
				</td>
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