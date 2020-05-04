<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta charset="UTF-8">
<title>다른 도서관</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
a {
	text-decoration: none;
}

a:hover {
	padding: 5px;
	background-color: lightgray;
}

.list {
	position: relative;
	width: 15%;
	float: left;
	text-align: center;
	border: 3px solid #DAE3F3;
	border-radius: 5px;
	padding: 4px;
	text-decoration: none;
	margin-left: 100px;
}

.list_1 {
	background-color: #dae3f3;
	padding: 5px;
}

.list_2 {
	font-size: medium;
}

.info {
	position: relative;
	width: 70%;
	float: left;
	margin-left: 2px;
	margin-right: 34px;
}

.info_area {
	display: none;
}

button {
	background: none;
	border: 0;
	outline: 0;
	cursor: pointer;
}

.tab_menu_btn {
	color: #5d5d5d;
	height: 15px;
	transition: 0.3s all;
}

a:hover {
	padding: 5px;
	background-color: lightgray;
}
</style>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87fd002dfa2f762ea4d08ce2efdbd45b&libraries=services"></script>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/libraryHeader.jsp"%>
		</div>
	</header>
	<br>

	<h2>다른 도서관</h2>
	<div style="position: relative; margin: auto">
		<div class="list">
			<div class="list_1">All Library👀</div>
			<div class="list_2">
				<c:forEach items="${otherInfo }" var="other">
					<c:if test="${other.lid != lid}">
						<button class="tab_menu_btn" data-lid="${other.lid}"
							data-laddr="${other.laddr}" data-lname="${other.lname}"
							type="button">${other.lname}</button>
						<br>
					</c:if>
				</c:forEach>
			</div>
		</div>

		<div class="info">
			<c:forEach items="${otherInfo }" var="other">
				<c:if test="${other.lid != lid}">
					<div class="info_area">
						<table>
							<tr>
								<th width="100">도서관명</th>
								<td>${other.lname}</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>${other.ltel}</td>
							</tr>

							<tr>
								<th>공휴일</th>
								<td>${other.lholiday}</td>
							</tr>
							<tr>
								<th>운영시간</th>
								<td>${other.loperate}</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>${other.laddr}</td>
							</tr>

							<tr>
								<th>위치</th>
								<td>
									<div id="map_${other.lid}" style="width: 100%; height: 300px;"></div>
								</td>
							</tr>

						</table>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>

	<script>
		$('.tab_menu_btn').first().addClass("on");
		$('.info_area').first().show();
		var lid = $('.tab_menu_btn').first().attr("data-lid");
		var laddr = $('.tab_menu_btn').first().attr("data-laddr");
		var lname = $('.tab_menu_btn').first().attr("data-lname");
		createMap(lid, laddr, lname);
		$('.tab_menu_btn').on('click', function() {
			//버튼 색 제거,추가
			$('.tab_menu_btn').removeClass('on');
			$(this).addClass('on');
			var lid = $(this).attr("data-lid");
			var laddr = $(this).attr("data-laddr");
			var lname = $(this).attr("data-lname");

			//컨텐츠 제거 후 인덱스에 맞는 컨텐츠 노출
			var idx = $('.tab_menu_btn').index(this);

			$('.info_area').hide();
			$('.info_area').eq(idx).show();
			createMap(lid, laddr, lname);
		});

		function createMap(lid, laddr, lname) {
			var myAddress = [ laddr ];
			var mapContainer = document.getElementById('map_' + lid), // 지도를 표시할 div
			mapOption = {
				center : new daum.maps.LatLng(36.633535, 127.425882), // 지도의 중심좌표
				level : 4
			// 지도의 확대 레벨
			};

			// 지도를 생성합니다    
			var map = new daum.maps.Map(mapContainer, mapOption);

			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			function myMarker(number, address) {// 주소로 좌표를 검색합니다
				geocoder
						.addressSearch(
								address, //'주소',
								function(result, status) {
									if (status === daum.maps.services.Status.OK) { // 정상적으로 검색이 완료됐으면 
										var coords = new daum.maps.LatLng(
												result[0].y, result[0].x);

										var marker = new daum.maps.Marker({ // 결과값으로 받은 위치를 마커로 표시합니다
											map : map,
											position : coords
										});

										var infowindow = new daum.maps.InfoWindow(
												// 인포윈도우로 장소에 대한 설명을 표시합니다
												{
													content : '<div style="color:navy; text-align:center;">'
															+ lname + '</div>'
												});
										infowindow.open(map, marker);
										map.setCenter(coords); // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									}
								});
			}
			for (i = 0; i < myAddress.length; i++) {
				myMarker(i + 1, myAddress[i]);
			}
		}
	</script>
	<footer id="footer" style="position: relative; width: 100%; float: left">
		<div id="footer_box">
			<c:choose>
				<c:when test="${cid != null}"><%@ include
						file="/footers/userFooter.jsp"%></c:when>
				<c:when test="${lid == 'admin'}"><%@ include
						file="/footers/adminFooter.jsp"%></c:when>
				<c:otherwise><%@ include
						file="/footers/libraryFooter.jsp"%></c:otherwise>
			</c:choose>
		</div>
	</footer>
</body>
</html>