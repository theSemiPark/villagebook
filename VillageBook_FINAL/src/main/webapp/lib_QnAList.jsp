<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>답변하기</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/libraryHeader.jsp"%>
		</div>
	</header>
	<br>

	<h2>답변하기</h2>

		<form action="lib_QnAList.do" method="post">
			<table>
					<tr style="background-color:white;">
					<td align="right"><select name="searchCondition">
					<c:forEach items="${conditionMap }" var="option">
						<option value="${option.value }">${option.key }</option>
					</c:forEach>
					</select> 
					<input name="searchKeyword" type="text" /> 
					<input type="submit" 	value="검색" /></td>
				</tr>
			</table>
		</form>

		<table class="list">
			<tr>
				<th  width="50">번호</th>
				<th  width="400">제목</th>
				<th  width="100">작성자ID</th>
				<th  width="100">등록일</th>
				<th  width="50">조회수</th>
			</tr>
			<c:if test="${qnaList == '[]' }"><tr><td colspan=5>등록 된 질문이 없습니다</td></tr></c:if>
			<c:forEach items="${qnaList}" var="qna">
				<tr>
					<td>${qna.seq }</td>
					<td align="left"><a href="lib_QnA.do?seq=${qna.seq }">
							${qna.title }</a>(${qna.replycnt}) <font color="red" size="1">${qna.replytf}</font></td>
					<td>${qna.writer }</td>
					<td>${qna.regDate }</td>
					<td>${qna.cnt }</td>
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