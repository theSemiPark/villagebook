<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	Connection conn = DriverManager.getConnection(url, "villagebook", "villagebook");
	Statement stmt = conn.createStatement();
	String isbn = request.getParameter("isbn");
	ResultSet rs = stmt.executeQuery("SELECT * FROM BOOK WHERE isbn='"+ isbn +"'");
	String bookname = null;
	if (rs != null) {
		rs.next();
		bookname = rs.getString("bookname");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서 상세</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table{
	border: 2px solid #9AD2F7;
	width: 500px;
}
.lib{
	width: 500px;
	border: 1px solid black;
}
.libs{
	width: 500px;
	border: 0px;
	font-size: 9pt;
	color: black;
	text-align: right;
}
th{
	background: #B9E0FA;
}
tr:nth-child(2n) { background-color: #f2f4f5; }
</style>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple"
	alink="red">
	
	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include file="/headers/userHeader.jsp" %></c:when>
				<c:when test="${lid == 'admin'}"><%@ include file="/headers/adminHeader.jsp" %></c:when>
				<c:otherwise><%@ include file="/headers/libraryHeader.jsp" %></c:otherwise>
			</c:choose>
		</div>
	</header><br>
	
	<h2>도서 상세</h2>
	
	<form action="" method="post">
	<table>
		<tr>
			<td width="150" height="23">
				<p align="center">
					<span style="font-size: 9pt;">책제목</span>
				</p>
			</td>
			<td width="513">
				<p>
					<span style="font-size: 9pt;"> <%=rs.getString("BOOKNAME") %></span>
				</p>
			</td>
		</tr>

		<tr>
			<td width="150" height="23">
				<p align="center">
					<span style="font-size: 9pt;">저자명</span>
				</p>
			</td>
			<td width="513">
				<p>
					<span style="font-size: 9pt;"> <%=rs.getString("AUTHOR") %>
					</span>
				</p>
			</td>
		</tr>

		<tr>
			<td width="150" height="23">
				<p align="center">
					<span style="font-size: 9pt;">출판사</span>
				</p>
			</td>
			<td width="513">
				<p>
					<span style="font-size: 9pt;"> <%=rs.getString("PUBLISHER") %>
					</span>
				</p>
			</td>
		</tr>


		<tr>
			<td width="150" height="23">
				<p align="center">
					<span style="font-size: 9pt;">발행일</span>
				</p>
			</td>
			<td width="513">
				<p>
					<span style="font-size: 9pt;"> <%=rs.getDate("PDATE") %>
					</span>
				</p>
			</td>
		</tr>


		<tr>
			<td width="150" height="23">
				<p align="center">
					<span style="font-size: 9pt;">장르</span>
				</p>
			</td>
			<td width="513">
				<p>
					<span style="font-size: 9pt;"> <%=rs.getString("GENRE") %>
					</span>
				</p>
			</td>
		</tr>

	</table>

	
	
	<input type="hidden" name="bookname" value = "<%=bookname%>"/>
	<input type="hidden" name="isbn" value = "<%=isbn%>"/>
	<%
	}
	
	ResultSet rs2 = stmt.executeQuery("SELECT * FROM rental,library WHERE isbn="+isbn+" AND rental.lid = library.lid");
	if(rs2 != null){
		%>
		
		<c:choose>
				<c:when test="${cid != null}">
				<br><table class="lib"><tr><th>소장도서관</th><th>소장권수</th><th>대여가능권수</th><th></th></tr>
		<%
		while(rs2.next()){
			%> <tr style="background-color:white;"><td>
			<%=rs2.getString("lname") %></td><td><%=rs2.getInt("havecnt") %></td><td><%=rs2.getInt("havecnt")-rs2.getInt("rcnt") %></td><td>
			<div class="cart">
			<% if(rs2.getInt("havecnt")-rs2.getInt("rcnt") > 0) {%>
			<button type="button" class='cart_<%=rs2.getString("lid") %>_btn' data-lId='<%=rs2.getString("lid") %>' data-lname='<%=rs2.getString("lname")%>'>장바구니</button>
					<script>
						$('.cart_<%=rs2.getString("lid") %>_btn').click(function(){
							var bookname = $('input[name="bookname"]').val();
							var isbn = $('input[name="isbn"]').val();
							var lId = $(this).attr("data-lId");
							var lname = $(this).attr('data-lname');
							$.ajax({
								url : "insertCart.do",
								type : "post",
 								data : {bookname : bookname, isbn : isbn, lId : lId, lname : lname},
								success : function(result){
									if(result) {
										location.href = "getCart.do?";
									} else {
										alert("장바구니에 넣기 실패");
									}
								}
							});
						});
					</script>
				<% } else { %>
				<button type="button" class='reserve_<%=rs2.getString("lid") %>_btn' data-lId='<%=rs2.getString("lid") %>' data-lname='<%=rs2.getString("lname")%>'>예약</button>
				<script>
						$('.reserve_<%=rs2.getString("lid") %>_btn').click(function(){
							var isbn = $('input[name="isbn"]').val();
							var lId = $(this).attr("data-lId");
							$.ajax({
								url : "insertReserve.do",
								type : "post",
 								data : {isbn : isbn, lid : lId},
								success : function(result){
									if(result == "true") {
										alert("예약 성공");
									} else if(result == "already"){
										alert("이미 예약한 도서입니다.");
									} else if(result == "false"){
										alert("최대 예약 가능 인원은 2명입니다.");
									} else {
										alert("예약 실패");
									}
								}
							});
						});
					</script>
				<% }%>
				</div>			
			</td></tr>
	<%
		} %> </table>
				</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>	
		<%
	}
	stmt.close();
	conn.close();
	
	%>
	<table class="libs">
		<tr>
			<td width="150"><br>
				<span>
					<c:choose>
					<c:when test="${cid != null}">
					<a href="getBookList.do">빠른 검색</a>&nbsp;&nbsp;&nbsp;
					<a href="getBookList_Lib.jsp">도서관별 검색</a>
					</c:when>
					<c:otherwise>
					<a href="getBookList_Lib.jsp">도서보유현황</a>
					</c:otherwise>
					</c:choose>
				</span>
			</td>
		</tr>
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