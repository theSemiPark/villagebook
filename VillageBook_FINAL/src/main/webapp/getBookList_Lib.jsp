<%@ page language="java" import="java.sql.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String sk = request.getParameter("sk");
	String sv = request.getParameter("sv");

	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	Connection conn = DriverManager.getConnection(url, "villagebook", "villagebook");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	if (sk == null & sv == null) {
%>
<c:choose>
	<c:when test="${cid != null}">
		<%
			pstmt = conn.prepareStatement(
								"SELECT LIBRARY.LNAME, RENTAL.ISBN, BOOK.BOOKNAME ,author, publisher, genre, pdate FROM RENTAL, LIBRARY, BOOK WHERE LIBRARY.LID = RENTAL.LID and BOOK.ISBN=RENTAL.ISBN order by lname");
		%>
	</c:when>
	<c:when test="${lid == 'admin'}">
		<%
			pstmt = conn.prepareStatement(
								"SELECT LIBRARY.LNAME, RENTAL.ISBN, BOOKNAME ,author, publisher, genre, pdate, rental.havecnt, rental.rcnt FROM RENTAL, LIBRARY, BOOK WHERE LIBRARY.LID = RENTAL.LID and BOOK.ISBN=RENTAL.ISBN "
										+  "order by lname");
		%>
	</c:when>
</c:choose>
<%
	} else if (sk != null & sv.equals("")) {
%>
<c:choose>
	<c:when test="${cid != null}">
		<%
 			pstmt = conn.prepareStatement(
 			"SELECT LIBRARY.LNAME, RENTAL.ISBN, BOOK.BOOKNAME ,author, publisher, genre, pdate FROM RENTAL, LIBRARY, BOOK WHERE LIBRARY.LID = RENTAL.LID and BOOK.ISBN=RENTAL.ISBN order by lname");
		%>
	</c:when>
	<c:when test="${lid == 'admin'}">
		<%
			pstmt = conn.prepareStatement(
			"SELECT LIBRARY.LNAME, RENTAL.ISBN, BOOKNAME ,author, publisher, genre, pdate, rental.havecnt,rental.rcnt FROM RENTAL, LIBRARY, BOOK WHERE LIBRARY.LID = RENTAL.LID and BOOK.ISBN=RENTAL.ISBN "
										+  "order by lname");
		%>
	</c:when>
</c:choose>
<%
	} else if (sk != null & sv != null) {
		System.out.println("검색어>>" + sv);
%>
<c:choose>
	<c:when test="${cid != null}">
		<%
			pstmt = conn.prepareStatement(
								"SELECT LIBRARY.LNAME, RENTAL.ISBN, BOOKNAME ,author, publisher, genre, pdate FROM RENTAL, LIBRARY, BOOK WHERE LIBRARY.LID = RENTAL.LID and BOOK.ISBN=RENTAL.ISBN and "
										+ sk + " like '%'||?||'%'" + "order by lname");
		%>
	</c:when>
	<c:when test="${lid == 'admin'}">
		<%
			pstmt = conn.prepareStatement(
								"SELECT LIBRARY.LNAME, RENTAL.ISBN, BOOKNAME ,author, publisher, genre, pdate, rental.havecnt,rental.rcnt FROM RENTAL, LIBRARY, BOOK WHERE LIBRARY.LID = RENTAL.LID and BOOK.ISBN=RENTAL.ISBN and "
										+ sk + " like '%'||?||'%'" + "order by lname");
		%>
	</c:when>
</c:choose>
<%
	pstmt.setString(1, sv);
	}
	
	rs = pstmt.executeQuery();
	String isbn = null;
	String bookname = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<c:if test="${cid != null }"><title>도서관별 검색</title></c:if>
<c:if test="${lid == 'admin'}"><title>도서보유현황</title></c:if>

<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	width: 100%;
}
</style>
</head>

<body bgcolor="white" text="black">


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
	<c:if test="${cid != null }"><h2>도서관별 검색</h2></c:if>
	<c:if test="${lid == 'admin'}"><h2>도서보유현황</h2></c:if>

	<form action="getBookList_Lib.jsp" method="post">
		<select name="sk">
			<option value="LIBRARY.LNAME">도서관</option>
			<option value="BOOK.ISBN">ISBN</option>
			<option value="BOOKNAME">책제목</option>
			<option value="AUTHOR">저자</option>
			<option value="PUBLISHER">출판사</option>
			<option value="GENRE">카테고리</option>
			<c:if test="${lid == 'admin'}">
				<option value="RENTAL.HAVECNT">보유권수</option>
				<option value="RENTAL.RCNT">대여권수</option>
			</c:if>
		</select> <input type="text" name="sv"> <input type="submit" value="검색">
	</form>
	<br>
	<table class="list">
		<c:choose>
			<c:when test="${lid == 'admin'}">
				<tr>
					<th width="200"><p align="center">
							<span style="font-size: 10pt;"><b>도서관</b></span>
						</p></th>
					<th width="150"><p align="center">
							<span style="font-size: 10pt;"><b>ISBN</b></span>
						</p></th>
					<th width="300"><p align="center">
							<span style="font-size: 10pt;"><b>책제목</b></span>
						</p></th>
					<th width="200"><p align="center">
							<span style="font-size: 10pt;"><b>저자</b></span>
						</p></th>
					<th width="100"><p align="center">
							<span style="font-size: 10pt;"><b>출판사</b></span>
						</p></th>
					<th width="100"><p align="center">
							<span style="font-size: 10pt;"><b>카테고리</b></span>
						</p></th>
					<th width="150"><p align="center">
							<span style="font-size: 10pt;"><b>출판일</b></span>
						</p></th>
					<th width="100"><p align="center">
							<span style="font-size: 10pt;"><b>보유권수</b></span>
						</p></th>
					<th width="100"><p align="center">
							<span style="font-size: 10pt;"><b>대여권수</b></span>
						</p></th>
				</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<th width="150"><p align="center">
							<span style="font-size: 10pt;"><b>도서관</b></span>
						</p></th>
					<th width="150"><p align="center">
							<span style="font-size: 10pt;"><b>ISBN</b></span>
						</p></th>
					<th width="400"><p align="center">
							<span style="font-size: 10pt;"><b>책제목</b></span>
						</p></th>
					<th width="200"><p align="center">
							<span style="font-size: 10pt;"><b>저자</b></span>
						</p></th>
					<th width="150"><p align="center">
							<span style="font-size: 10pt;"><b>출판사</b></span>
						</p></th>
					<th width="100"><p align="center">
							<span style="font-size: 10pt;"><b>카테고리</b></span>
						</p></th>
					<th width="150"><p align="center">
							<span style="font-size: 10pt;"><b>출판일</b></span>
						</p></th>
				</tr>
			</c:otherwise>
		</c:choose>

		<%
			int cnt = 0;
			while (rs.next()) { cnt++;
		%>
				<tr>
					<td><%=rs.getString("LNAME")%></td>
					<td><%=rs.getString("ISBN")%></td>
					<%
						isbn = rs.getString("ISBN");
						bookname = rs.getString("BOOKNAME");
					%>
					<td><a href="bookview.jsp?isbn=<%=isbn%>"><%=rs.getString("BOOKNAME")%></a></td>						
					<td><%=rs.getString("AUTHOR")%></td>
					<td><%=rs.getString("PUBLISHER")%></td>
					<td><%=rs.getString("GENRE")%></td>
					<td><%=rs.getDate("PDATE")%></td>
					<c:if test="${lid == 'admin'}">
					<td><%=rs.getInt("HAVECNT")%></td>
					<td><%=rs.getInt("RCNT")%></td>
					</c:if>
				</tr>
			
		<%
			}
			if(cnt == 0){
		%>
			<c:if test="${lid != 'admin'}">
			<tr><td colspan = "7">해당 내역이 없습니다</td></tr>
			</c:if>
			<c:if test="${lid == 'admin'}">
			<tr><td colspan = "9">해당 내역이 없습니다</td></tr>
			</c:if>
		<%
			}
		
			pstmt.close();
			conn.close();
		%>

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