<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>공지사항 상세</title>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
.replies{
	text-align: left;
}
input{
	width: 600px;
}
#del{
	border: 0px;
}
</style>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include file="/headers/userHeader.jsp" %></c:when>
				<c:when test="${lid == 'admin'}"><%@ include file="/headers/adminHeader.jsp" %></c:when>
				<c:otherwise><%@ include file="/headers/libraryHeader.jsp" %></c:otherwise>
			</c:choose>
		</div>
	</header><br>
	
	
		<h2>공지사항 상세</h2>

		<form action="insertNotice.do" method="post">
		<input name="seq" type="hidden" value="${notice.seq }" class="seq"/>
			<table>
				<tr>
					<th width="70">제목</th>
					<td align="left">${notice.title }</td>
				</tr>
				<tr>
					<th width="70">작성자</th>
					<td align="left">${notice.writer}</td>
				</tr>
				<tr>
					<th >내용</th>
					<td align="left" width="600">${notice.content }</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td align="left">${notice.regDate }</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td align="left">${notice.cnt }</td>
				</tr>
			</table>
		</form>
		
		<br>
		<table class="replies">
			<tr>
				<th colspan="4" align="left">댓글(${notice.replycnt})</th>
			</tr>
			<c:forEach items="${replyList}" var="reply">
				<tr>
					<td width="200px">
						<c:choose>
							<c:when test="${reply.writer == '중앙관리자'}">🔧<b>중앙관리자</b></c:when>
							<c:when test="${reply.writer.contains('도서관') }">📚<b>${reply.writer}</b></c:when>
							<c:when test="${reply.writer == cid }">✨<b>${reply.writer}</b></c:when>
							<c:when test="${reply.writer == qna.writer}">🖋글쓴이</c:when>
							<c:otherwise>✨${reply.writer}</c:otherwise>
						</c:choose>
					</td>
					<td width="120px">${reply.regdate}</td>
					<td style="word-break:break-all">${reply.rcontent}</td>
					<td width="20px">
						<c:if test="${(cid != null && reply.writer == cid) || lid != null}">
							<button type="button" class="delete_${reply.qreplyid}" id="del" data-rid="${reply.qreplyid}">x</button>
							<script>
								$(".delete_${reply.qreplyid}").click(function(){
									var qreplyid = $(this).attr("data-rid");
									var seq = $(".seq").val();
									$.ajax({
										url : "deleteReply_notice.do",
										type : "post",
										data : {qreplyid : qreplyid, seq : seq},
										success : function(result){
											if(result){
												location.href = "getNotice.do?seq=" + seq;
											} else alert("삭제 실패");
										}
									});
								});
							</script>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<tr>
			<td colspan="4" align="center">
				<input type="text" class="new_reply" width="800px">
				<button type="button" class="register">등록</button>
				<script>
					$(".register").click(function(){
						var rcontent = $(".new_reply").val();
						var seq = $(".seq").val();
						if(rcontent != "" && rcontent != null){
							$.ajax({
								url : "insertReply_notice.do",
								type : "post",
								data : {rcontent : rcontent, seq : seq},
								success : function(result){
									if(result){
										location.href = "getNotice.do?seq=" + seq;
									} else alert("댓글 입력 실패");
								}
							});
						} else alert("댓글을 입력해주세요.");
					});
				</script>
			</td></tr>
		</table>

		<br>
		<c:if test="${lname eq notice.writer ||  lid eq 'admin' }">
			<a href="deleteNotice.do?seq=${notice.seq }">글삭제</a> 
		</c:if>		
		
		&nbsp;&nbsp;&nbsp;
		<a href="getNoticeList.do">글목록</a>
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