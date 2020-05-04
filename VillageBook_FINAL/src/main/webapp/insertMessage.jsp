<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>알림쪽지 쓰기</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table {
	border: 0px;
	border-collapse: collapse;
	table-layout: fixed;
}

th, td {
	border-bottom: 1px solid gray;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
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

	<form action="insertMessage.do" method="post">
		<table>
			<tr>
				<th width="120">보낸사람</th>
				<td>${lname}</td>
				<th width="120">받는사람</th>
				<td>
				
 				<input type="hidden" name="targetid" value="하하" required>
				
					<span>
						<select onchange="getList()" id="selectBox" required>
							<option value="none">선택</option>
							<option value="biz">관리자</option>
							<option value="user">사용자</option>
						</select>
					</span>
						<span class="subSelect" id="subSelect_biz">
							<select name="tid1" id="tid1">
								<option value="none">선택</option>
								<c:forEach items="${conditionMap_biz}" var="option">
									<c:if test="${option.value != lname}"><option value="${option.value}">${option.key}</option></c:if>
								</c:forEach>
							</select>
						</span>
						<span class="subSelect" id="subSelect_user">
							<select name="tid2" id="tid2">
								<option value="none">선택</option>
								<c:forEach items="${conditionMap_user}" var="option">
									<option value="${option.value}">${option.key}</option>
								</c:forEach>
							</select>
						</span>
					<script>
						$(".subSelect").hide();
						function getList(){
							var option = $("#selectBox").val();
							$("#tid1").val("none");
							$("#tid2").val("none");
							$(".subSelect").hide();
							$("#subSelect_"+option).show();
						};
					</script>
				</td>
			</tr>
			<tr>
				<td colspan="4" height="180px"><textarea name="message"
						cols="100" rows="10" id="meg" required></textarea></td>
			</tr>
		</table>
		<br>

		<button id="sub" type="button">보내기</button>
		<script>
			$("#sub").click(function(){
				if($("#selectBox").val() == "none") alert("받을 사람을 선택해주세요.");
				else if($("#tid1").val() == "none" && $("#tid2").val() == "none") alert("받을 사람을 선택해주세요.");
				else if(!$("#meg").val()) alert("내용을 입력해주세요");
				else{
					if($("#tid1").val() != "none") $("input[name='targetid']").attr("value", $("#tid1").val());
					else $("input[name='targetid']").attr("value", $("#tid2").val());
					$("form").submit();
				}
			});
		</script>
		<button type="reset">다시쓰기</button>
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