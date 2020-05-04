<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>반납요청 처리</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/libraryHeader.jsp" %>
		</div>
	</header><br>
	<h2>반납요청 처리</h2>
	<table>
		<tr>
			<th width=300px>주문번호</th><th width=150px>주문인ID</th><th>반납예정일</th><th></th><th></th>
		</tr>
		<c:if test="${returnList ==  '[]'}"><tr><td colspan="5">해당 내역이 없습니다</td></tr></c:if>
		<c:forEach items="${returnList}" var="ret">
			<tr>
				<td>${ret.ordid}</td>
				<td>${ret.cid}</td>
				<td>${ret.returndate}</td>
				<td><button type="button" class="detail_${ret.ordid}" style="border: 0px; cursor: pointer; background: none; color: #DAE3F3">상세</button>
				<td>
					<button type="button" class="btn_${ret.ordid}">승인</button>
					<script>
						$(".btn_${ret.ordid}").click(function(){
							var ordid = "${ret.ordid}";
							var cid = "${ret.cid}";
							var returndate = "${ret.returndate}";
							$.ajax({
								url : "returnwer2.do",
								type : "post",
								data : {ordid : ordid, cid : cid},
								success : function(result){
									if(result) {
										location.href = "lib_getReturnList.do";
									} else {
										alert("반납 실패");
									}
								}
							});
						});
					</script>
			</tr>
			<tbody id="user_${ret.ordid}" ></tbody>
			<script>
			$("#user_${ret.ordid}").hide();
				$(".detail_${ret.ordid}").click(function(){
					if($(this).text() == "상세"){
						var ordid = "${ret.ordid}";
						var html = "";
						$.ajax({
							url : "lib_getReturn_detail.do",
							type: "post",
							data : {ordid : ordid},
							async: "false",
							dataType: "json",
							success : function(result){
								if(result) {
									html += "<td colspan=5><table style='border:0px; background: #ddd; width: 650px'>";
									for(var i = 0 ; i < result.length; i++){
										html += "<tr>";
										html += "<td width='300px'>";
										html = html + result[i].bookname;
										html += "</td>";
										html += "<td>";
										html += result[i].isbn;
										html += "</td>";
										html += "<td>";
										html += result[i].ordercnt;
										html += "권</td>";
										html += "</tr>";
									}
									html += "</table></td>";
									document.getElementById("user_${ret.ordid}").innerHTML = html;
									$("#user_${ret.ordid}").fadeIn();
								} else {
									alert("반납 실패");
								}
							}
						});
						$(this).text("닫기");
					} else {
						$("#user_${ret.ordid}").hide();
						$(this).text("상세");
					}
				});
			</script>
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