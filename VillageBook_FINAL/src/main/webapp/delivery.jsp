<%@page import="com.spring.biz.delivery.DeliveryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>대여 현황 상세</title>
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
	<h2>대여 현황 상세</h2>
	<c:set var="lname" value="0"/>
	
	<c:forEach items="${boardList }" var="board">
		<c:if test="${board.lname != lname }">
			<table><tr><td colspan="2">${board.lname }</td><td>
			<c:if test="${board.renewtf == 'N' && board.returnwer == 'N'}">
			<input type="button" value="연장" class="renewtf_${board.lid}" data-lid="${board.lid}" data-ordid="${board.ordid}" data-redate="${board.returndate}">
			<script>
				$(".renewtf_${board.lid}").click(function(){
					var date = new Date();
					if(date.getHours() == 23 && date.getMinutes() == 59) alert("지금은 시스템 점검시간입니다(23:59~24:00)");
					else{
						var lid = $(this).attr("data-lid");
						var ordid = $(this).attr("data-ordid");
						var returndate = $(this).attr("data-redate");
						returndate = new Date(returndate);
						returndate.setHours(23);
						returndate.setMinutes(59);
						if(date > returndate) alert("연장은 반납예정일까지만 가능합니다");
						else{
							$.ajax({
								url : "renewtf.do",
								type : "post",
								data : {lid : lid, ordid : ordid},
								success : function(result){
									if(result) {
										location.href = "delivery.do?ordid="+ordid;
									} else {
										alert("연장 실패");
									}
								}
							});
						}
					}
				});
			</script>
			</c:if>
			<c:if test="${board.renewtf != 'N' && board.returnwer == 'N'}">연장 불가</c:if>
			<c:if test="${board.shipping == '2' && board.returnwer == 'N' }">
				<input type="button" value="반납요청" class="returnwer_${board.lid}" data-lid="${board.lid}" data-ordid="${board.ordid}" data-redate="${board.returndate}">
				<script>
					$(".returnwer_${board.lid}").click(function(){
						var date = new Date();
						if(date.getHours() == 23 && date.getMinutes() == 59) alert("지금은 시스템 점검시간입니다(23:59~24:00)");
						else{
							var lid = $(this).attr("data-lid");
							var ordid = $(this).attr("data-ordid");
							var returndate = $(this).attr("data-redate");
							var today = new Date();
							var returndate = new Date(returndate);
							returndate.setHours(23);
							returndate.setMinutes(59);
							var late = 0;
							if (today > returndate){
								late = (today-returndate)/(24*60*60*1000);
								late = parseInt(late)+1;
								alert(late+"일 연체되셨습니다. " + late*100 +"원의 포인트가 차감 될 예정입니다.");
							}
							$.ajax({
								url : "returnwer.do",
								type : "post",
								data : {lid : lid, ordid : ordid, late : late},
								success : function(result){
									if(result) {
										location.href = "delivery.do?ordid="+ordid;
									} else {
										alert("반납 실패");
									}
								}
							});
						}
					});
				</script>
			</c:if>
			<c:if test="${board.returnwer == 'R' }">
			반납 요청
			</c:if>
			</td></tr></table>
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
	<a href="deliveryList.do">주문조회 전체 목록</a>
	
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