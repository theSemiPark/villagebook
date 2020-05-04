<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>알림쪽지 상세</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	width: 400px;
	border: 0px;
	border-collapse: collapse;
}
th, td{
	border-bottom: 1px solid black;
	padding: 5px;
}
</style>
</head>
<body>
	<table>
		<tr><th>보낸사람</th><td>${message.sender}</td><th>보낸날짜</th><td>${message.senddate}</td></tr>
		<tr><th>받는사람</th><td>${message.targetid}</td><th>읽은날짜</th><td>${message.opendate}</td></tr>
		<tr><td colspan="4" height="180px">${message.message}</td></tr>
	</table>
	<br>
	<a href="deleteMessage.do?mid=${message.mid}">삭제</a>
	<a href="getMessageList.do">목록</a>
</body>
</html>