<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>내 정보 수정</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table{
	width: 600px;
}
</style>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="/headers/userHeader.jsp" %>
		</div>
	</header><br>
<script>
	
	function inputPhoneNumber(obj) {

		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 4) {
			return number;
		} else if (number.length < 7) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3);
		} else if (number.length < 11) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 3);
			phone += "-";
			phone += number.substr(6);
		} else {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3, 4);
			phone += "-";
			phone += number.substr(7);
		}
		obj.value = phone;
	}

	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('cpostcode').value = data.zonecode;
						document.getElementById("caddr1").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("caddr2")
								.focus();
					}
				}).open();
	}
	
	$(function() {
		$(":checkbox[name=pw_change]").click(function() {
			if ($(this).is(":checked")) {
				$('input[name="new_cpw"]').removeAttr("disabled");
				$('input[name="new_cpw2"]').removeAttr("disabled");
				$(".sub").attr("disabled", "disabled");
			} else {
				$('input[name="new_cpw"]').attr("disabled", "disabled");
				$('input[name="new_cpw2"]').attr("disabled", "disabled");
				$('input[name="new_cpw"]').val(null);
				$('input[name="new_cpw2"]').val(null);
				$("#alert-success").hide();
				$("#alert-danger").hide();
				$(".sub").removeAttr("disabled");
			}
		});
	});
	
	$(function() {
		$("#alert-success").hide();
		$("#alert-danger").hide();
		$("input").keyup(function() {
			var new_cpw = $('input[name="new_cpw"]').val();
			var new_cpw2 = $('input[name="new_cpw2"]').val();
			if (new_cpw != "" || new_cpw2 != "") {
				if (new_cpw == new_cpw2) {
					$("#alert-success").show();
					$("#alert-danger").hide();
					$(".sub").removeAttr("disabled");
				} else {
					$("#alert-success").hide();
					$("#alert-danger").show();
					$(".sub").attr("disabled", "disabled");
				}
			} else{
				$("#alert-success").hide();
				$("#alert-danger").hide();
			}
		});
	});
</script>
	
	<h2>내 정보 수정</h2>
	<form action="" method="post" id="next">
		<table>
			<tr>
				<th width="30%">ID</th>
				<td>${cid }</td>
			</tr>
			<tr>
				<th>현재 비밀번호</th>
				<td><input type="password" name="cpw"/><input type="checkbox" name="pw_change"/>변경</td>
			</tr>
			<tr>
				<th>새 비밀번호</th>
				<td><input type="password" name="new_cpw" value="" disabled/></td>
			</tr>
			<tr>
				<th>새 비밀번호 확인</th>
				<td><input type="password" name="new_cpw2" disabled/>
				<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
				<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="cname" value="${cname }"/></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" onKeyup="inputPhoneNumber(this);" name="chp" value="${chp}"/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
				<input type="text" name="cpostcode" id="cpostcode" value="${cpostcode }" readonly>
				<input type="button" onclick="sample6_execDaumPostcode()"
					value="우편번호 찾기">
				<br>
				<input type="text" id="caddr1" name="caddr1" value="${caddr1 }" style="width:400px;" readonly>
				<br>
				<input type="text" id="caddr2" name="caddr2" value="${caddr2 }" style="width:200px" placeholder="${caddr2 }">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" class="sub" value="수정" />
				<script>
					$(".sub").click(function(){
						// 1. 빈칸 없게  / 2. 현재 비번 확인 / 3. PW변경하는경우 새비번일치확인
						var cpw = $('input[name="cpw"]').val();
						var cname = $('input[name="cname"]').val();
						var chp = $('input[name="chp"]').val();
						var caddr1 = $('input[name="caddr1"]').val();
						var caddr2 = $('input[name="caddr2"]').val();
						if(!(cpw && cname && chp && caddr1 && caddr2)) alert("모든 항목을 입력하셔야 합니다");
						else { $.ajax({
								url : "checkUpdate.do",
								type : "post",
								dataType : "text",
								async : false,
								data : {cpw : cpw},
								success : function(result){
									if(result == "true"){
										if ($(":checkbox[name='pw_change']").is(":checked")) {
											var new_cpw = $('input[name="new_cpw"]').val();
											var new_cpw2 = $('input[name="new_cpw2"]').val();
											if(!new_cpw || !new_cpw2) alert("모든 항목을 입력하셔야 합니다");
											else if(new_cpw != new_cpw2) alert("새 비밀번호가 일치하지 않습니다");
											else{
												alert("회원정보 수정이 완료되었습니다");
												$("form#next").attr("action","updateUser.do");
												$("form#next").submit();
											}
										} else{
											alert("회원정보 수정이 완료되었습니다");
											$("form#next").attr("action","updateUser.do");
											$("form#next").submit();
										}
									}
									else if(result == "false") alert("현재 비밀번호가 틀렸습니다.");
									else alert("확인 실패");
								}
							});
						}
					});
				</script>
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