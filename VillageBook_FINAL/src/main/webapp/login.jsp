<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>LOGIN PAGE</title>
<link rel="stylesheet" href="css/login.css" type="text/css">
</head>
<body>
	<form action="login.do" method="post">
		<h1>도서관 책 받아보기의 시작,</h1>
		<h2>동네BOOK</h2>
		<table>
			<tr>
				<td><input type="text" class="use" name="cid"
					value="${user.cid }" placeholder="아이디를 입력하세요" /> <input
					type="reset" id="reset" value="x"></td>
			</tr>
			<tr>
				<td><input type="password" class="use" name="cpw"
					value="${user.cpw }" placeholder="비밀번호를 입력하세요" /> <input
					type="reset" id="reset" value="x"></td>
			</tr>
			<tr>
				<td align="center"><br> <input id="submit" type="submit"	value="로그인" /></td>
			</tr>
			<tr><td><br><br>
			   <div class="index"><a href="/biz/index.jsp">시작화면으로</a></div>
			</td></tr>
		</table>
	</form>
</body>
</html>