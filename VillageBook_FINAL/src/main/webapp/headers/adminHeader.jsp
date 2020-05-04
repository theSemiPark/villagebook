<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>ADMIN HEADER</title>
<link rel="stylesheet" href="css/header.css" type="text/css">
<script>
	$(function() {
		$.ajax({
			url : "checkMessage.do",
			type : "post",
			dataType : "text",
			success : function(result){
				if(result) {
					if(result == 'Y'){
						$("#msg").attr("src","img/msg_y.png");
						$("#msg").attr("width","17px");

						if(sessionStorage.getItem("allim") != "off"){
							$(function() {
							    // 브라우저 지원 여부 체크
							    if (!("Notification" in window)) {
							        alert("데스크톱 알림을 지원하지 않는 브라우저입니다.");
							    }
							    // 데스크탑 알림 권한 요청
							    Notification.requestPermission(function (result) {
							        // 권한 거절
							        if(result == 'denied') {
							            alert('알림을 차단하셨습니다.\n브라우저의 사이트 설정에서 변경하실 수 있습니다.');
							            return false;
							        }
							    });
							    var notification = new Notification("new Message", {body:'확인하지 않은 쪽지가 있습니다.', silent: true, icon: "img/icon.png"});
							    notification.onclick = function(event) {
							    	  event.preventDefault(); // prevent the browser from focusing the Notification's tab
							    	  location.href = "getMsgList_biz.do";
							    }
							});
						
						sessionStorage.setItem("allim", "off");
						}
					}
				} else {
					alert("메시지 체크 실패");
				}
			}
		})
	});
</script>
</head>
<body>
<c:if test="${lid == null || lid != 'admin'}">
	<script>
		alert("자동 로그아웃되었습니다");
		location.href = "index.jsp";
	</script>
</c:if>
	<div class="rightupper"><b>${lname}</b>님 환영합니다 / <a href="logout.do">로그아웃</a> / 
<a href="#" onclick="location.href='getMsgList_biz.do'"><img src="img/msg_blank.png" width="15px" id="msg"></a>
	</div>
	<a href="adminMainPage.do"><img src="img/logo.png" width="250px"></a><br><br>
	
	<div class="navbar">
		<div class="dropdown">
			<button class="dropbtn">자료관리</button>
			<div class="dropdown-content">
				<a href="getBookList_Lib.jsp">도서보유현황</a>
				<div class="group">대여관리</div>
				<a href="getDelivery_admin.do">대여상태조회</a>
				<a href="getOrder_admin.do">대여 취소/삭제</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn">커뮤니티</button>
			<div class="dropdown-content">
				<a href="getNoticeList.do">공지사항</a>
				<a href="admin_QnAList.do">답변하기</a>
				<a href="getNomiList.do">도서추천하기</a>
				<a href="getMsgList_biz.do">알림쪽지</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn">회원 관리</button>
			<div class="dropdown-content">
				<a href="getMileageList.do">회원 목록</a>
				<a href="getRanks.do">등급/포인트 조정</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn" onclick="location.href = 'getLibList_admin.do'" style="cursor: pointer">도서관 관리</button>
		</div>
	</div>
</body>
</html>