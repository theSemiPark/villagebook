<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<title>동네북 header</title>
<link rel="stylesheet" href="css/header.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
							    	  window.open('getMessageList.do', '메시지', 'width=450px,height=300px');
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
<c:if test="${cid == null}">
	<script>
		alert("자동 로그아웃되었습니다");
		location.href = "index.jsp";
	</script>
</c:if>
<div class="rightupper"><b>${cname}</b>님 환영합니다 / <a href="logout.do">로그아웃</a> / <a href="getCart.do">장바구니</a> / 
<a href="#" onclick="window.open('getMessageList.do', '메시지', 'width=450px,height=300px')"><img src="img/msg_blank.png" width="15px" id="msg"></a>
</div>
<a href="mainPage.do"><img src="img/logo.png" width="250px"></a>

<br><br>

	<div class="navbar">
		<div class="dropdown">
			<button class="dropbtn">대여하기</button>
			<div class="dropdown-content">
				<a href="getBookList.do">빠른 검색</a>
				<a href="getBookList_Lib.jsp">도서관별 검색</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn" id="lib" style="cursor: pointer">도서관 정보</button>
			<script>
				$("#lib").click(function() {
					location.href = "getLibList.jsp";
				});
			</script>
		</div>
		<div class="dropdown">
			<button class="dropbtn">커뮤니티</button>
			<div class="dropdown-content">
				<a href="getNoticeList.do">공지사항</a>
				<a href="getQnAList.do">문의하기</a>
				<a href="getNomiList.do">도서 추천하기</a>
			</div>
		</div>
		<div class="dropdown">
			<button class="dropbtn">내 서재</button>
			<div class="dropdown-content">
				<div class="group">대여 관리</div>
				<a href="deliveryList.do">대여 현황</a>
				<a href="deliveryHistoryList.do" title="반납/주문취소 확인">대여 히스토리</a>
				<a href="getReserveList.do">예약 관리</a>
				<div class="group">내 정보 관리</div>
				<a href="updateUser.jsp">내 정보 수정</a>
				<a href="getPoints.do">포인트 조회</a>
			</div>
		</div>
	</div>
</body>
</html>