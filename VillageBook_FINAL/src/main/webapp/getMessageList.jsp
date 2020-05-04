<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>알림쪽지</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	width: 400px;
	border: 0px;
	border-collapse: collapse;
	table-layout: fixed;
}
td{
	border-bottom: 1px solid gray;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>
</head>
<body>
	<br>
	<img src="img/msg_y0.png" width="100px"><br><br>
	<table>
		<tr>
			<th width="100px">보낸사람</th>
			<th width="110px">보낸날짜</th>
			<th>메시지</th>
		</tr>
		<c:if test="${messageList ==  '[]'}"><tr><td colspan="3">메시지가 없습니다</td></tr></c:if>
		<c:forEach items="${messageList}" var="message">
			<tr>
				<td>${message.sender}</td>
				<td>${message.senddate}</td>
				<td>
					<a href="getMessage.do?mid=${message.mid}"><c:if test="${message.opendate == null}"><b>${message.message}</b></c:if>
					<c:if test="${message.opendate != null}">${message.message}</c:if></a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<br>
</body>
</html>