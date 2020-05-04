<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>공지사항</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>

	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include
						file="/headers/userHeader.jsp"%></c:when>
				<c:when test="${lid == 'admin'}"><%@ include
						file="/headers/adminHeader.jsp"%></c:when>
				<c:otherwise><%@ include
						file="/headers/libraryHeader.jsp"%></c:otherwise>
			</c:choose>
		</div>
	</header>
	<br>


	<h2>공지사항</h2>

	<form action="getNoticeList.do" method="post">
		<table>
			<tr style="background-color: white;">
				<td align="right"><select name="searchCondition">
						<c:forEach items="${conditionMap }" var="option">
							<option value="${option.value }">${option.key }</option>
						</c:forEach>
				</select> <input name="searchKeyword" type="text" /> <input type="submit"
					value="검색" /></td>
			</tr>
		</table>
	</form>

	<table class="list">
		<tr>
			<th width="70">번호</th>
			<th width="330">제목</th>
			<th width="150">작성자</th>
			<th width="100">등록일</th>
			<th width="50">조회수</th>
		</tr>
		<c:choose>
			<c:when test="${cid != null }">
				<tr>
					<td><font color="red" style="font-weight: bold">⚠필독⚠</font></td>
					<td align="left"><a href="wayUser.jsp"> 동네북 이용 방법 </a></td>
					<td>중앙관리자</td>
					<td>2020-03-30</td>
					<td></td>
				</tr>
			</c:when>
			<c:when test="${lid != 'admin' && lid != null}">
				<tr>
					<td><font color="red" style="font-weight: bold">⚠필독⚠</font></td>
					<td align="left"><a href="wayLib.jsp"> 동네북 이용 방법 </a></td>
					<td>중앙관리자</td>
					<td>2020-03-30</td>
					<td></td>
				</tr>
			</c:when>
		</c:choose>
		<c:forEach items="${noticeList}" var="notice">
			<tr>
				<td>${notice.seq }</td>
				<td align="left"><a href="getNotice.do?seq=${notice.seq }">
						${notice.title }</a>(${notice.replycnt})</td>
				<td>${notice.writer }</td>
				<td>${notice.regDate }</td>
				<td>${notice.cnt }</td>
			</tr>
		</c:forEach>
	</table>
	<br>
	<c:if test="${lid != null }">
		<a href="insertNotice.jsp">글 등록</a>
	</c:if>
	<footer id="footer">
		<div id="footer_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include
						file="/footers/userFooter.jsp"%></c:when>
				<c:when test="${lid == 'admin'}"><%@ include
						file="/footers/adminFooter.jsp"%></c:when>
				<c:otherwise><%@ include
						file="/footers/libraryFooter.jsp"%></c:otherwise>
			</c:choose>
		</div>
	</footer>
</body>
</html>