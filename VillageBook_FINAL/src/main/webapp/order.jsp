<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>주문정보 확인</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
.ex{
	text-align: right;
}
#fin_user{
	width: 100px;
}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp" %>
		</div>
	</header><br>

	<h2>주문정보 확인</h2>
	<c:if test="${user.crank == 3}">
		<c:set var="per" value="0.05"/>
	</c:if>
	<c:if test="${user.crank == 2}">
		<c:set var="per" value="0.03"/>
	</c:if>
	<c:if test="${user.crank == 1}">
		<c:set var="per" value="0.02"/>
	</c:if>
	<form action="payment.jsp" method="post" id="next">
		<table>
		<tr><th colspan="6"><a href="updateUser.jsp">내 위치 확인</a></th></tr>
			<tr>
			<td colspan="6">
				<div id="map" style="width: 100%; height: 300px;"></div> 
				<script type="text/javascript"  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=87fd002dfa2f762ea4d08ce2efdbd45b&libraries=services"></script>
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
			 
			        var myAddress = ["${user.caddr1}" ];
			 
			        function myMarker(number, address) {// 주소로 좌표를 검색합니다
			            geocoder.addressSearch(address,  //'주소',
			                            function(result, status) {            
			                                if (status === daum.maps.services.Status.OK) {  // 정상적으로 검색이 완료됐으면 
			                                    var coords = new daum.maps.LatLng(
			                                            result[0].y, result[0].x);
			 
			                                    var marker = new daum.maps.Marker({    // 결과값으로 받은 위치를 마커로 표시합니다
			                                        map : map,
			                                        position : coords
			                                    });
			      
			                                    var infowindow = new daum.maps.InfoWindow(        // 인포윈도우로 장소에 대한 설명을 표시합니다
			                                            {	
			                                                content : '<div id="fin_user" style="color:navy; text-align:center;" >'+'${user.cname}'+'</div>'
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
			<tr>
				<th colspan="4" width="400">주소</th><th width="200" colspan="2">연락처</th>
			</tr>
			<tr>
				<td colspan="4">${user.caddr1} ${user.caddr2} / 우편번호 : <fmt:formatNumber value="${user.cpostcode }" pattern="00000"/></td><td colspan="2">${user.chp }</td>
			</tr>
			<tr>
				<th width="200" colspan="2">등급</th><th width="200" colspan="2">총 결제금액</th><th width="200" colspan="2">적립예상마일리지</th>
			<tr>
			<tr>
				<td colspan="2">${user.crank }</td><td colspan="2">${sum}</td><td colspan="2"><fmt:formatNumber value="${sum*per}" pattern="###"/></td>
			</tr>
			<tr>
				<th width="300" colspan="3">보유 포인트</th><th colspan="3" width="300">사용할 포인트</th>
			</tr>
			<tr>
				<td colspan="3">${user.cpoint }</td>
				<td colspan="3"><input type="text" name="usepoint" value="${usepoint }">
					<button type="button" class="usepoint_btn" data-sum="${sum }" data-point="${user.cpoint }">사용</button>
					<script>
					$(".usepoint_btn").click(function(){
						var usepoint = $('input[name="usepoint"]').val();
						var sum = $(this).attr("data-sum");
						var point = $(this).attr("data-point");
						if(usepoint - point > 0) alert("보유한 포인트만큼만 사용할 수 있습니다");
						else if(usepoint - sum > 0) alert("사용포인트는 결제금액을 초과할 수 없습니다");
						else if(sum - usepoint > 0 && sum - usepoint < 10) alert("결제 최소단위는 10원 단위입니다."); 
						else{
							$.ajax({
								url : "usePoint.do",
								type : "post",
								data : {usepoint : usepoint},
								success : function(result){													
									if(result) {
										location.href = "order.jsp";
									} else {
										alert("포인트 사용 실패");
									}
								}
							});
						}
					});
					</script>
				</td>
			</tr>
			<tr bgcolor="#dae3f3">
				<td class = "ex" colspan="6">카드결제금액 : <b>${fi }원</b>	
				<input type="button" class="sub" value="결제">
				<script>
					$(".sub").click(function(){
						if("${fi}" == 0){
							$("#next").attr("action", "paid.do");
						}
						$("#next").submit();
					});
				</script>
				<input type="hidden" value="${fi }" >
				<input type="hidden" value="${user.caddr1}" >
				<input type="hidden" value="${user.caddr2} " >
				<input type="hidden" value="${user.cname }" >
				<input type="hidden" value="${user.chp }" >
				<input type="hidden" value="${user.cpostcode}" >
				</td>
			</tr>			
		</table>
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