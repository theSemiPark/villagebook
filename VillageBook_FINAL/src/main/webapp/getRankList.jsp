<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등급/포인트 조정</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	width: 700px;
 	border-collapse: collapse;
	border: 0px;
}

tr:nth-child(4n+1), tr:nth-child(4n+2){
	background-color: #f1f2f3;
}
th, td {
	padding: 5px
}

button {
	background: #dae3f3;
	border: 0.5px solid black;
	cursor: pointer;
	font-family: 'Montserrat', sans-serif;
}

button:hover {
	background: rgba(100, 100, 100, 0.1);
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/adminHeader.jsp"%>
		</div>
	</header>
	<br>

	<h2>등급/포인트 조정</h2>
	<table>
		<tr>
			<th>회원 ID</th>
			<th>이름</th>
			<th>최근 30일 주문금액</th>
			<th>등급</th>
			<th>포인트</th>
			<th>전화번호</th>
		</tr>
		<tr>
			<th>권역번호</th>
			<th colspan="4">주소</th>
			<th>우편번호</th>
		</tr>
		<c:if test="${rankList ==  '[]'}"><tr><td colspan="6">가입한 회원이 없습니다</td></tr></c:if>
		<c:forEach items="${rankList }" var="rank">
			<tr>
				<td>${rank.cid}</td>
				<td>${rank.cname }</td>
				<td>${rank.ordmoney30}원</td>
				<td><input type="number" id="newRank_${rank.cid}"
					value="${rank.crank}" min="0" max="3">
					<button type="button" class="setRank_${rank.cid}">✓</button> <script>
						$('.setRank_${rank.cid}').click(function() {
							var oldRank = "${rank.crank}";
							var newRank = $("#newRank_${rank.cid}").val();
							var cid = "${rank.cid}";
							if(!newRank) alert("새 등급을 입력해주세요.");
							else if(newRank < 0 || newRank > 3) alert("0에서 3 사이의 정수를 입력해주세요.");
							else if (oldRank - newRank == 0)
								alert("변경 전, 후 등급이 같습니다.");
							else {
								if(confirm(oldRank + "에서 " + newRank +"로 변경됩니다. 계속하시겠습니까?")){
									$.ajax({
										url : "rankUpdate.do",
										type : "post",
										data : {
											cid : cid,
											crank : newRank,
											oldRank : oldRank
										},
										success : function(result) {
											if (result) {
												location.href = "getRanks.do";
											} else {
												alert("등급 조정 실패");
											}
										}
									});
								}
							}
						});
					</script></td>
				<td><button class="pointevt_${rank.cid}" data-cid="${rank.cid}"
						data-cpoint="${rank.cpoint}" data-cname="${rank.cname }">${rank.cpoint }원</button>
					<script>
						$(".pointevt_${rank.cid}").click(function() {
							var cid = $(this).attr("data-cid");
							var cpoint = $(this).attr("data-cpoint");
							var cname = $(this).attr("data-cname");
							$.ajax({
								url : "pointUpdate.do",
								type : "post",
								data : {
									cid : cid,
									cpoint : cpoint,
									cname : cname
								},
								success : function(result) {
									if (result) {
										location.href = "pointUpdate.jsp";
									} else {
										alert("포인트 조정 실패");
									}
								}
							});
						});
					</script></td>
				<td>${rank.chp }</td>
			</tr>
			<tr>
				<td>${rank.careaid }</td>
				<td colspan="4">${rank.caddr1 }${rank.caddr2 }</td>
				<td>${rank.cpostcode }</td>
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