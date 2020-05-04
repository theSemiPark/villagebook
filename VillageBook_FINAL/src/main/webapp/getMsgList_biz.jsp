<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>알림쪽지</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	border: 0px;
	border-collapse: collapse;
	table-layout: fixed;
}

th {
	padding: 5px;
}

td {
	border-bottom: 1px solid gray;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

button {
	background: none;
	border: 0;
	outline: 0;
	cursor: pointer;
}

.tab_menu_container {
	text-align: center;
}

.tab_menu_btn {
	width: 100px;
	height: 30px;
	transition: 0.3s all;
}

.tab_menu_btn.on {
	border-bottom: 2px solid #B4C7E7;
	font-weight: 700;
	color: #B4C7E7;
}

.tab_menu_btn:hover {
	color: #B4C7E7;
}

.tab_box {
	display: none;
	padding: 20px;
}

.tab_box.on {
	display: block;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${lid == 'admin'}"><%@ include
						file="/headers/adminHeader.jsp"%></c:when>
				<c:otherwise><%@ include
						file="/headers/libraryHeader.jsp"%></c:otherwise>
			</c:choose>
		</div>
	</header>
	<br>
	<img src="img/msg_y0.png" width="100px">
	<br>
	<br>

	<div class="tab_wrap">
		<div class="tab_menu_container">
			<button class="tab_menu_btn on" type="button">보낸 메세지</button>
			<button class="tab_menu_btn" type="button">받은 메세지</button>
		</div>

		<div class="tab_box_container">
			<div class="tab_box on">
				<table>
					<tr>
						<th width="110px">보낸날짜</th>
						<th width="100px">받는사람</th>
						<th width="110px">확인날짜</th>
						<th>내용</th>
					</tr>
					<c:if test="${messageList ==  '[]'}"><tr><td colspan="4">해당 내역이 없습니다</td></tr></c:if>
					<c:forEach items="${messageList}" var="message">
						<tr>
							<td>${message.senddate}</td>
							<td>${message.targetid}</td>
							<td>${message.opendate}</td>
							<td><a href="getMsg_biz.do?mid=${message.mid}">${message.message}</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="tab_box">
				<table>
					<tr>
						<th width="110px">보낸날짜</th>
						<th width="100px">보낸사람</th>
						<th width="110px">확인날짜</th>
						<th>내용</th>
					</tr>
					<c:if test="${receiveList ==  '[]'}"><tr><td colspan="4">해당 내역이 없습니다</td></tr></c:if>
					<c:forEach items="${receiveList}" var="receive">
						<tr>
							<td>${receive.senddate}</td>
							<td>${receive.sender}</td>
							<td>${receive.opendate}</td>
							<td><a href="getRecMsg_biz.do?mid=${receive.mid}">${receive.message}</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<script>
		$('.tab_menu_btn').on('click', function() {
			//버튼 색 제거,추가
			$('.tab_menu_btn').removeClass('on');
			$(this).addClass('on')

			//컨텐츠 제거 후 인덱스에 맞는 컨텐츠 노출
			var idx = $('.tab_menu_btn').index(this);

			$('.tab_box').hide();
			$('.tab_box').eq(idx).show();
		});
	</script>


	<br>
	<a href="insertMessage.do">메시지 보내기</a>
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