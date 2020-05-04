<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<title>USER FOOTER</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet" href="css/footer.css" type="text/css">
</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<div class="footerbar">
		<br> <a href="wayUser.jsp">HowToUse</a> <br>
		<ul>
			<li></li>
			<li><font size="3"><b>고객센터 : 02-485-2781</b></font><br>
			<br></li>

			<li>MON - FRI 9:30 - 18:00</li>
			<li>BREAK 11:30 - PM 12:30 (SAT.SUN.HOLIDAY CLOSE)<br>
			<br></li>
			<li>※ 1:1 상담톡 응대 가능 시간</li>
			<li>MON - FRI 10:00 - 17:00</li>
			<li>BREAK 11:30 - PM 12:30 (SAT.SUN.HOLIDAY CLOSE)</li>
			<li><h5>ⓒ 2020.동네북 all rights reserved.</h5></li>
		</ul>
	</div>

	<div class="floatdiv">
		<br> <span id="plusfriend-addfriend-button"></span><br>
		<span id="kakao-talk-channel-chat-button"></span>
		<script type='text/javascript'>
			//<![CDATA[
			// 사용할 앱의 JavaScript 키를 설정해 주세요.
			Kakao.init('87fd002dfa2f762ea4d08ce2efdbd45b');
			// 플러스친구 친구추가 버튼을 생성합니다.
			Kakao.PlusFriend.createAddFriendButton({
				container : '#plusfriend-addfriend-button',
				plusFriendId : '_julBxb' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
			});

			Kakao.Channel.createChatButton({
				container : '#kakao-talk-channel-chat-button',
				channelPublicId : '_julBxb' // 카카오톡 채널 홈 URL에 명시된 id로 설정합니다.
			});

			//]]>
		</script>
		<br>
		<button type="button" class="scroll" id="top"
			onClick="javascript:window.scrollTo(0,0)">∧</button>
		<button type="button" class="scroll" id="down"
			onclick="$('body,html').animate({scrollTop:$('body').height()},150);">∨</button>
	</div>
</body>
</html>
