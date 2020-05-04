<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>문의하기 등록</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp" %>
		</div>
	</header><br>
		<h2>문의하기 등록</h2>
		
		<hr>
		<form action="insertQnA.do" method="post">
			<table>
				<tr>
					<th width="70">답변자</th>
					<td align="left">
						<select name="horsehead">
							<option value=""></option>
							<option value="중앙관리자">중앙관리자</option>
							<option value="용산구립도서관">용산구립도서관</option>
							<option value="종로구립도서관">종로구립도서관</option>
							<option value="중구구립도서관">중구구립도서관</option>
							<option value="강북구립도서관">강북구립도서관</option>
							<option value="도봉구통합도서관">도봉구통합도서관</option>
							<option value="노원구립도서관">노원구립도서관</option>
							<option value="성북구립도서관">성북구립도서관</option>
							<option value="광진구립도서관">광진구립도서관</option>
							<option value="동대문구립도서관">동대문구립도서관</option>
							<option value="성동구립도서관">성동구립도서관</option>
							<option value="중랑구립도서관">중랑구립도서관</option>
							<option value="강동구립도서관">강동구립도서관</option>
							<option value="송파구립도서관">송파구립도서관</option>
							<option value="강남구립도서관">강남구립도서관</option>
							<option value="서초구립도서관">서초구립도서관</option>
							<option value="관악구립도서관">관악구립도서관</option>
							<option value="동작구립도서관">동작구립도서관</option>
							<option value="금천구립도서관">금천구립도서관</option>
							<option value="강서구립도서관">강서구립도서관</option>
							<option value="양천구립도서관">양천구립도서관</option>
							<option value="구로구립도서관">구로구립도서관</option>
							<option value="영등포구립도서관">영등포구립도서관</option>
							<option value="은평구립도서관">은평구립도서관</option>
							<option value="마포구립도서관">마포구립도서관</option>
							<option value="서대문구립도서관">서대문구립도서관</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td align="left"><input type="text" name="title" required/></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td align="left"><input type="text" name="writer" value="${cid }" readonly/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td align="left"><textarea name="content" cols="80" rows="10" required></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value=" 새 글 등록 " /></td>
				</tr>
			</table>
		</form>
		<hr>
		<a href="getQnAList.do">글 목록 가기</a>
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