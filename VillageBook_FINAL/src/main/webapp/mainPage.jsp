<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	Connection conn = DriverManager.getConnection(url, "villagebook", "villagebook");
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(
			"select * from (select bookname, author, publisher, genre, pdate from book order by dbms_random.value) where rownum <= 1");
	if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>동네북 Main Page</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
.input {
	width: 350px;
	border: 0px;
	outline: none;
}

#search {
	align: center;
	border: 3px solid #DAE3F3;
	width: 600px;
	border-collapse: collapse;
}

.butt {
	background: #DAE3F3;
}

.but {
	color: white;
	font-weight: bold;
	background: none;
	border: 0px;
	cursor: pointer;
}

/*the container must be positioned relative:*/
.custom-select {
	margin: -1px;
	margin-left: -3.5px;
	position: relative;
	font-family: Arial;
	color: white;
}

.custom-select select {
	display: none; /*hide original SELECT element:*/
}

.select-selected {
 	background-color: #DAE3F3;
}

/*style the arrow inside the select element:*/
.select-selected:after {
	position: absolute;
	content: "";
	top: 14px;
	right: 10px;
	width: 0;
	height: 0;
	border: 6px solid transparent;
	border-color: #fff transparent transparent transparent;
}

/*point the arrow upwards when the select box is open (active):*/
.select-selected.select-arrow-active:after {
	border-color: transparent transparent #fff transparent;
	top: 7px;
}

/*style the items (options), including the selected item:*/
.select-items div, .select-selected {
	padding: 8px;
	cursor: pointer;
	user-select: none;
}

/*style items (options):*/
.select-items {
	position: absolute;
	background-color: #B4C7E7;
	top: 100%;
	left: 0;
	right: 0;
}

/*hide the items when the select box is closed:*/
.select-hide {
	display: none;
}

.select-items div:hover{
	background-color: rgba(0, 0, 0, 0.1);
}
</style>
</head>

<body>

	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp"%>
		</div>
	</header>
	<br>
	<br>
	<br>
	<br>
	<br>
	<section>
		<form action="getBookList.do" method="post">
			<table id="search">
				<tr>
					<td width="150px" height="30px">
						<div class="custom-select" style="width: 150px;">
							<select name="searchCondition">
								<c:forEach items="${conditionMapMain }" var="option">
									<option value="${option.value }">${option.key }
								</c:forEach>
							</select>
						</div>
						<script>
							var x, i, j, selElmnt, a, b, c;
							/*look for any elements with the class "custom-select":*/
							x = document.getElementsByClassName("custom-select");
							for (i = 0; i < x.length; i++) {
								selElmnt = x[i].getElementsByTagName("select")[0];
								/*for each element, create a new DIV that will act as the selected item:*/
								a = document.createElement("DIV");
								a.setAttribute("class", "select-selected");
								a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
								x[i].appendChild(a);
								/*for each element, create a new DIV that will contain the option list:*/
								b = document.createElement("DIV");
								b.setAttribute("class",
										"select-items select-hide");
								for (j = 0; j < selElmnt.length; j++) {
									/*for each option in the original select element,
									create a new DIV that will act as an option item:*/
									c = document.createElement("DIV");
									c.innerHTML = selElmnt.options[j].innerHTML;
									c.addEventListener(
													"click",
													function(e) {
														/*when an item is clicked, update the original select box,
														and the selected item:*/
														var y, i, k, s, h;
														s = this.parentNode.parentNode
																.getElementsByTagName("select")[0];
														h = this.parentNode.previousSibling;
														for (i = 0; i < s.length; i++) {
															if (s.options[i].innerHTML == this.innerHTML) {
																s.selectedIndex = i;
																h.innerHTML = this.innerHTML;
																y = this.parentNode
																		.getElementsByClassName("same-as-selected");
																for (k = 0; k < y.length; k++) {
																	y[k]
																			.removeAttribute("class");
																}
																this
																		.setAttribute(
																				"class",
																				"same-as-selected");
																break;
															}
														}
														h.click();
													});
									b.appendChild(c);
								}
								x[i].appendChild(b);
								a.addEventListener("click", function(e) {
									/*when the select box is clicked, close any other select boxes,
									and open/close the current select box:*/
									e.stopPropagation();
									closeAllSelect(this);
									this.nextSibling.classList
											.toggle("select-hide");
									this.classList
											.toggle("select-arrow-active");
								});
							}
							function closeAllSelect(elmnt) {
								/*a function that will close all select boxes in the document,
								except the current select box:*/
								var x, y, i, arrNo = [];
								x = document
										.getElementsByClassName("select-items");
								y = document
										.getElementsByClassName("select-selected");
								for (i = 0; i < y.length; i++) {
									if (elmnt == y[i]) {
										arrNo.push(i)
									} else {
										y[i].classList
												.remove("select-arrow-active");
									}
								}
								for (i = 0; i < x.length; i++) {
									if (arrNo.indexOf(i)) {
										x[i].classList.add("select-hide");
									}
								}
							}
							/*if the user clicks anywhere outside the select box,
							then close all select boxes:*/
							document.addEventListener("click", closeAllSelect);
						</script>
					</td>
					<td width="400px"><input name="searchKeyword" type="text"
						class="input" /></td>
					<td width="50px" class="butt"><button type="submit"
							class="but">
							<img src="img/bookchae.png" height="30px">
						</button></td>
				</tr>
			</table>
		</form>
		<br> <br>

		<table>
			<tr>
				<th><p align="center">
						<span style="font-size: 9pt;">책제목</span>
					</p></th>
				<th><p align="center">
						<span style="font-size: 9pt;">저자명</span>
					</p></th>
				<th><p align="center">
						<span style="font-size: 9pt;">출판사</span>
					</p></th>
				<th><p align="center">
						<span style="font-size: 9pt;">카테고리</span>
					</p></th>
				<th><p align="center">
						<span style="font-size: 9pt;">출판일</span>
					</p></th>
			</tr>

			<tr>
				<td><p>
						<span style="font-size: 9pt;"><%=rs.getString("BOOKNAME")%></span>
					</p></td>
				<td><p>
						<span style="font-size: 9pt;"><%=rs.getString("AUTHOR")%></span>
					</p></td>
				<td><p>
						<span style="font-size: 9pt;"><%=rs.getString("PUBLISHER")%></span>
					</p></td>
				<td><p>
						<span style="font-size: 9pt;"> <%=rs.getString("GENRE")%>
						</span>
					</p></td>
				<td><p>
						<span style="font-size: 9pt;"> <%=rs.getDate("PDATE")%></span>
					</p></td>
			</tr>
		</table>

		<%
			}
			stmt.close();
			conn.close();
		%>
	</section>
	
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