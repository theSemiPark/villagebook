<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta charset="UTF-8">
<title>도서관 이미지맵</title>
</head>

<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp"%>
		</div>
	</header>
	<br>
	<h2>도서관 이미지맵</h2>
	<br>
	<div>
		<img id="seoul" src="img/seoul3.png" border="0" width="619" height="520"
			orgWidth="619" orgHeight="520" usemap="#seoul-maps" alt="도서관 한눈에 보기" />
		<map name="seoul-maps" id="seoul-maps">
			<area alt="" title="노원구 도서관 이용 안내" href="getLibinfo.do?lid=104"
				shape="rect" coords="432,67,486,125" style="outline: none;"
				target="_self" />
			<area alt="" title="도봉구 도서관 이용 안내" href="getLibinfo.do?lid=101"
				shape="rect" coords="368,39,422,97" style="outline: none;"
				target="_self" />
			<area alt="" title="강북구 도서관 이용 안내"
				href="getLibinfo.do?lid=102" shape="rect"
				coords="332,98,387,136" style="outline: none;" target="_self" />
			<area alt="" title="성북구 도서관 이용 안내"
				href="getLibinfo.do?lid=103" shape="rect"
				coords="333,170,397,206" style="outline: none;" target="_self" />
			<area alt="" title="중랑구 도서관 이용 안내"
				href="getLibinfo.do?lid=202" shape="rect"
				coords="455,167,519,216" style="outline: none;" target="_self" />
			<area alt="" title="동대문구 도서관 이용 안내"
				href="getLibinfo.do?lid=201" shape="rect"
				coords="391,206,455,245" style="outline: none;" target="_self" />
			<area alt="" title="종로구 도서관 이용 안내"
				href="getLibinfo.do?lid=001" shape="rect"
				coords="287,206,351,245" style="outline: none;" target="_self" />
			<area alt="" title="은평구 도서관 이용 안내"
				href="getLibinfo.do?lid=701" shape="rect"
				coords="209,135,273,171" style="outline: none;" target="_self" />
			<area alt="" title="서대문 도서관 이용 안내"
				href="getLibinfo.do?lid=703" shape="rect"
				coords="227,217,280,252" style="outline: none;" target="_self" />
			<area alt="" title="마포구 도서관 이용 안내"
				href="getLibinfo.do?lid=702" shape="rect"
				coords="186,251,239,286" style="outline: none;" target="_self" />
			<area alt="" title="중구 도서관 이용 안내"
				href="getLibinfo.do?lid=002" shape="rect"
				coords="320,247,365,277" style="outline: none;" target="_self" />
			<area alt="" title="광진구 도서관 이용 안내"
				href="getLibinfo.do?lid=204" shape="rect"
				coords="456,264,501,304" style="outline: none;" target="_self" />
			<area alt="" title="성동구 도서관 이용 안내"
				href="getLibinfo.do?lid=203" shape="rect"
				coords="383,253,428,293" style="outline: none;" target="_self" />
			<area alt="" title="용산구 도서관 이용 안내"
				href="getLibinfo.do?lid=003" shape="rect"
				coords="292,292,337,332" style="outline: none;" target="_self" />
			<area alt="" title="강동구 도서관 이용 안내"
				href="getLibinfo.do?lid=301" shape="rect"
				coords="541,260,586,300" style="outline: none;" target="_self" />
			<area alt="" title="강서구 도서관 이용 안내"
				href="getLibinfo.do?lid=601" shape="rect"
				coords="67,240,112,280" style="outline: none;" target="_self" />
			<area alt="" title="양천구 도서관 이용 안내"
				href="getLibinfo.do?lid=602" shape="rect"
				coords="108,320,153,360" style="outline: none;" target="_self" />
			<area alt="" title="송파구 도서관 이용 안내"
				href="getLibinfo.do?lid=302" shape="rect"
				coords="499,347,544,387" style="outline: none;" target="_self" />
			<area alt="" title="강남구 도서관 이용 안내"
				href="getLibinfo.do?lid=402" shape="rect"
				coords="419,370,464,416" style="outline: none;" target="_self" />
			<area alt="" title="서초구 도서관 이용 안내"
				href="getLibinfo.do?lid=401" shape="rect"
				coords="341.66998291015625,386.3300018310547,386.66998291015625,432.3300018310547"
				style="outline: none;" target="_self" />
			<area alt="" title="관악구 도서관 이용 안내"
				href="getLibinfo.do?lid=502" shape="rect"
				coords="251,413,296,459" style="outline: none;" target="_self" />
			<area alt="" title="동작구 도서관 이용 안내"
				href="getLibinfo.do?lid=501" shape="rect"
				coords="254,354,299,384" style="outline: none;" target="_self" />
			<area alt="" title="금천구 도서관 이용 안내"
				href="getLibinfo.do?lid=503" shape="rect"
				coords="189,451,234,481" style="outline: none;" target="_self" />
			<area alt="" title="영등포구 도서관 이용 안내"
				href="getLibinfo.do?lid=603" shape="rect"
				coords="186,321,236,355" style="outline: none;" target="_self" />
			<area alt="" title="구로구 도서관 이용 안내"
				href="getLibinfo.do?lid=604" shape="rect"
				coords="96,368,146,402" style="outline: none;" target="_self" />
		</map>
		<p>각 행정구를 클릭하면 도서관 이용 안내 페이지로 연결해드립니다</p>
	</div>


	<div>
		<img alt="권역 안내도" src="img/area.png" width="750" />
		<p>권역 안내도입니다. 같은 권역 이용시 배송료가 보다 저렴합니다!</p>
	</div>
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
