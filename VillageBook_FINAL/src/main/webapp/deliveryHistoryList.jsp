<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>대여 히스토리</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
.upper{
	border: 0px;
}
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
	<h2>대여 히스토리</h2>
	<form action="deliveryHistoryList.jsp" method="post">
		<table class="upper">
			<tr style="background-color:white;">
				<td width="700" align="right"><select name="searchCondition">
						<option value="ordid">주문번호
						<option value="bookname">책 제목
				</select> <input name="searchKeyword" type="text" />
				<input type="submit" value="검색" /></td>
			</tr>
		</table>
	</form>
	
	<table class="list">
		<tr>
			<th width="200">주문번호</th>
			<th width="100">주문일</th>
			<th width="100">대여일</th>
		</tr>
		<c:if test="${boardList == '[]' }"><tr><td colspan=5>반납 완료 된 내역이 없습니다</td></tr></c:if>
		<c:forEach items="${boardList }" var="board">
			<tr align="center">
				<td><a href="deliveryHistory.do?ordid=${board.ordid }">${board.ordid }</a></td>
				<td>${board.orderdate }</td>
				<td>${board.startdate }</td>
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