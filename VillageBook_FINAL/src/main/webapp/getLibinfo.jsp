<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" charset="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서관 정보</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
.upper {
	border: 0px;
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
	<h2>${libinfo.lname}</h2>
	<table>

		<tr>
			<th>도서관명</th>
			<td>${libinfo.lname}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${libinfo.ltel}</td>
		</tr>

		<tr>
			<th>공휴일</th>
			<td>${libinfo.lholiday}</td>
		</tr>
		<tr>
			<th>운영시간</th>
			<td>${libinfo.loperate}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${libinfo.laddr}</td>
		</tr>
		<tr>
			<th>위치</th>
			<td>
				<div id="map" style="width: 100%; height: 300px;"></div> <script
					type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87fd002dfa2f762ea4d08ce2efdbd45b&libraries=services"></script>
				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new daum.maps.LatLng(36.633535, 127.425882), // 지도의 중심좌표
						level : 4
					// 지도의 확대 레벨
					};

					// 지도를 생성합니다    
					var map = new daum.maps.Map(mapContainer, mapOption);

					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new daum.maps.services.Geocoder();

					var myAddress = [ "${libinfo.laddr}" ];

					function myMarker(number, address) {// 주소로 좌표를 검색합니다
						geocoder
								.addressSearch(
										address, //'주소',
										function(result, status) {
											if (status === daum.maps.services.Status.OK) { // 정상적으로 검색이 완료됐으면 
												var coords = new daum.maps.LatLng(
														result[0].y,
														result[0].x);

												var marker = new daum.maps.Marker(
														{ // 결과값으로 받은 위치를 마커로 표시합니다
															map : map,
															position : coords
														});

												var infowindow = new daum.maps.InfoWindow(
														// 인포윈도우로 장소에 대한 설명을 표시합니다
														{
															content : '<div style="color:navy; text-align:center;" >'
																	+ '${libinfo.lname}'
																	+ '</div>'
														});
												infowindow.open(map, marker);
												map.setCenter(coords); // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
											}
										});
					}
					for (i = 0; i < myAddress.length; i++) {
						myMarker(i + 1, myAddress[i]);
					}
				</script>
			</td>
		</tr>
	</table>
	<footer id="footer">
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