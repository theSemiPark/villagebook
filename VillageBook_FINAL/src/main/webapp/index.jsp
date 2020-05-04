<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<style>
body {
	background-color: #fff7e1;
}

.a {
	text-align: center;
}

.b {
	display: inline-block;
	width: 100px;
	height: 20px;
	padding: 10px;
	border: 0px solid lightgray;
}

.b:hover {
	outline: none;
	background-color: #fad778;
	cursor: pointer;
}

a {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
	color: black;
}
</style>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>동네Book 시작 Page</title>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat|Roboto:300&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Montserrat', sans-serif;
	text-align: center;
}

.floatdiv {
	position: fixed;
	/*    width: 175px; */
	display: inline-block;
	right: 15px; /* 창에서 오른쪽 길이 */
	bottom: 5%; /* 창에서 위에서 부터의 높이 */
	background-color: transparent;
	margin: 0;
	ul {list-style-type: none;
}

}
.main {
/* 	margin: 2%; */
	background: #dae3f3;
	position:relative;
	top:50%;
	margin: 0% 2%;
	margin-top:-290px;
}
</style>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
	<div class="main">
		<img id="image-maps" src="img/book.png" width="400px" alt="동네방네 북서비스"
			usemap="#biz_login_maps" />
		<map name="biz_login_maps" id="biz_login_maps">
			<area alt="" title="biz_login" href="biz_login.do" shape="rect"
				coords="302,282,350,336" target="_self" style="outline: none;" />
			<area shape="rect" coords="398,398,400,400" alt="logo"
				href="biz_login.do" />
		</map>

		<br> <img src="img/logo_font.png" width=300px
			" style="margin-top: -10px">

		<div class="a">
			<div class="b">
				<a href="login.do">로그인</a>
			</div>
			&nbsp;&nbsp;
			<div class="b">
				<a href="join.do">회원가입</a>
			</div>
			<br> <br>
		</div>
	</div>

	<div class="floatdiv">
		<br> <span id="plusfriend-addfriend-button"></span><br> <span
			id="kakao-talk-channel-chat-button"></span>
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
	</div>
</body>
</html>