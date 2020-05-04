<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>장바구니</title>
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
	
	<h2>장바구니</h2>
	<c:set var="sum" value="0"/>
	<c:set var="lib" value="0"/>
	<c:set var="bookcnt" value="0"/>
	<c:set var="c" value="0"/>
	<form action="" method="post" id="next">
		<table>
			<tr>
				<th width="355">제목</th>
				<th width="95">수량</th>
				<th width="50"></th>
			</tr>
			<c:if test="${cartList == '[]'}">
				<tr><td colspan="3" width="500" align="center">장바구니에 담긴 도서가 없습니다.</td></tr>
			</c:if>
			<c:forEach items="${cartList }" var="cart">
			
			<input type="hidden" name="list[${c}].isbn" value="${cart.isbn }">
			<input type="hidden" name="list[${c}].cid" value="${cart.cId }">
			<input type="hidden" name="list[${c}].lid" value="${cart.lId }">
			<input type="hidden" name="list[${c}].ordercnt" value="${cart.cnt}">
			<input type="hidden" name="list[${c}].bookname" value="${cart.bookname}">

			<c:if test="${cart.lId/100 - user.careaid  < 1 && cart.lId/100 - user.careaid  >= 0}">
				<c:set var="deli" value="3000"/>
			</c:if>
			<c:if test="${cart.lId/100 - user.careaid  >= 1 || cart.lId/100 - user.careaid  < 0}">
				<c:set var="deli" value="5000"/>
			</c:if>

			<c:set var="bookcnt" value="${bookcnt+cart.cnt}"/>
			<c:if test="${lib != cart.lId}">
				<c:set var="sum" value="${sum+deli}"/>
				<tr><td colspan="4" align="right"><hr>
				<b><c:out value="${cart.lname} 배송비  : ${deli }"/></b>
				</td></tr>
				<c:set var="lib" value="${cart.lId }"/>
			</c:if>
			
				<tr>
					<td align="left"><a href="bookview.jsp?isbn=${cart.isbn}">${cart.bookname }</a></td>
					<td><input type="text" name="cnt_${cart.cartId }" id="cnt" value="${cart.cnt }" size="1">
					<button type="button" class="update_${cart.cartId}_btn" data-cartId="${cart.cartId}">수정</button>
					<script>
						$(".update_${cart.cartId}_btn").click(function(){
							var cartId = $(this).attr("data-cartId");
							var cnt = $('input[name="cnt_'+cartId+'"]').val();
							if(cnt > 5) alert("최대 가능 5권");
							else{
								$.ajax({
									url : "updateCart.do",
									type : "post",
									data : {cartId : cartId, cnt : cnt},
									success : function(result){
										if(result) {
											location.href = "getCart.do?";
										} else {
											alert("수정 실패");
										}
									}
								});
							}
						});
					</script>
				</td>
				<td>
					<div class="delete">
							<button type="button" class="delete_${cart.cartId}_btn" data-cartId="${cart.cartId}">삭제</button>
							<script>
								$(".delete_${cart.cartId}_btn").click(function(){
									var confirm_val = confirm("정말 삭제하시겠습니까?");
									if(confirm_val) {
										var cartId = $(this).attr("data-cartId");
										$.ajax({
											url : "deleteCart.do",
											type : "post",
											data : {cartId : cartId},
											success : function(result){
												if(result) {
													location.href = "getCart.do";
												} else {
													alert("삭제 실패");
												}
											}
										});
									}
								});
							</script>
						</div>
					</td>
				</tr>
				<c:set var="c" value="${c+1}"/>
			</c:forEach>
			<tr><td colspan="4" align="right"><hr>총 수량 : ${bookcnt}<br>총 배송비 : ${sum }<br>
			<input type="hidden" name="sum" value="${sum }">
			<input type="submit" value="주문정보확인" class="sub" id="sub" data-bookcnt="${bookcnt }">
			<script>
				window.onload = function() {
					if("${user.crank}" == 0 ){
						document.getElementById("sub").disabled = true;
						alert("레벨 0 북입니다. 중앙관리자에게 전화문의 주세요. ꃼ.̫ ꃼ");
					}
					else document.getElementById("sub").disabled = false;
				}
			
				$(".sub").click(function(){
					var bookcnt = $(this).attr("data-bookcnt");
					var ok = false;
					if(bookcnt < 1){
						alert("장바구니가 비었습니다");
					}
					else if(bookcnt > 5){
						alert("최대 가능 수량 5권");
					}
					else{
						$.ajax({
							url : "checkVali.do",
							type : "post",
							dataType : "text",
							async: false,
							success : function(result){
								if(result == '') ok = true;
								else if (result) alert(result);
								else alert("주문 실패");
							}
						});
						if(ok == true) $("form#next").attr("action","order.do");
						else $("form#next").attr("action","getCart.do");
					}
				});
			</script>
			</td></tr>
		</table>
	</form>
	
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