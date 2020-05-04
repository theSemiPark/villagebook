<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>동네book 회원 가입창</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
body{
	background-color: #fff7e1;
}

table{
	width: 600px;
	padding: 10px;
	margin: auto;
	border: 0px solid black;
}
td{
	width:500px;
	text-align: left;
}

form{
	position: relative;
	top: 50%;
	margin-top: -280px;
}
input:not(.overCheck) {
	height: 40px;
	padding: 10px;
	padding-top: 20px;
	background-color: transparent;
	border: 0px;
	font-size: 15px;
}

input:focus {
	outline: none;
	border-bottom: 3px solid #ffffff;
}

.overCheck, .sub, #reset, #pcode{
	width: 100px;
	padding: 10px;
	border: 0px solid;
	background-color: #fff7e1;
	cursor: pointer;
}

.overCheck:hover, #pcode:hover , .sub:hover, #reset:hover{
	outline: none;
	background-color: #fad778;
}

.index{
	display:inline-block;
	width:100px;
	height: 20px;
	padding: 10px;
	border: 0px solid lightgray;
}
.index:hover{
	outline: none;
	background-color: #fad778;
	cursor: pointer;
}
a{
	text-decoration:none;
	color: black;
}
a:visited{
	text-decoration:none;
	color: black;
}

</style>
</head>
<body>
	<script>
		$(function() {
			$("#alert-success").hide();
			$("#alert-danger").hide();
			$("#alert-none").hide();
			$("input").keyup(function() {
				var cpw = $("#cpw").val();
				var pwchk = $("#pwchk").val();
				if (cpw != "" || pwchk != "") {
					if (cpw == pwchk) {
						$("#alert-success").show();
						$("#alert-danger").hide();
						$("#alert-none").hide();
						$(".sub").removeAttr("disabled");
					} else {
						$("#alert-success").hide();
						$("#alert-danger").show();
						$("#alert-none").hide();
						$(".sub").attr("disabled", "disabled");
					}
				} else{
					$("#alert-success").hide();
					$("#alert-danger").hide();
					$("#alert-none").show();
				}
			});
		});

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
											+ data.buildingName
											: data.buildingName);
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
							document.getElementById("caddr2").focus();
						}
					}).open();
		}
		
		function form_reset(){
			$('form').each(function(){
				this.reset();
			});
			$("#alert-success").hide();
			$("#alert-danger").hide();
			$("#alert-none").hide();
		}
		
		$(function(){
			$('input[name="cid"]').change(function(){
				$('input[name="checkDone"]').val("f");
			});
		});
	</script>

	<form action="" method="post" id="next">
		<h1>회원가입</h1>
		<table>
			<tr>
				<th width="30%">ID</th>
				<td><input type="text" name="cid" maxlength="20"/>
				<input type="hidden" value="f" name="checkDone"/>
				<div style="float:right"><input type="button" value="중복확인" class="overCheck"></div>
				<script>
					$(".overCheck").click(function() {
						var cid = $('input[name="cid"]').val();
						if (!cid)
							alert("아이디를 입력해주세요");
						else {
							$.ajax({
								url : "overCheck.do",
								type : "post",
								data : {
									cid : cid
								},
								success : function(result) {
									if (result == "false") {
										alert("이미 사용중인 아이디입니다.");
									} else if (result == "true") {
										alert("사용 가능한 아이디입니다.");
										$('input[name="checkDone"]').val("t");
									} else {
										alert("중복 체크 실패");
									}
								}
							});
						}
					});
				</script></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="cpw" id="cpw"/></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="pwchk" id="pwchk"
					maxlength="20">
					<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
					<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
					<div class="alert alert-none" id="alert-none">비밀번호를 입력해주세요.</div>
					</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="cname" placeholder="김동네"/></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" onKeyup="inputPhoneNumber(this);"
					name="chp" placeholder="숫자만 입력"/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="cpostcode" id="cpostcode"
					 placeholder="우편번호" readonly><div style="float:right"><input
					type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="pcode" style="font-size:13px;">
					</div><br> <input type="text" id="caddr1" name="caddr1"
					style="width: 400px;" placeholder="주소"
					readonly> <br> <input type="text" id="caddr2"
					name="caddr2" style="width: 200px"
					placeholder="상세주소"> <input type="text"
					id="sample6_extraAddress" placeholder="참고항목"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center">
					<input type="button" value="가입" class="sub"  style="height:40px; padding: 10px;"/>
					<script>
						$(".sub").click(function(){
							var cid = $('input[name="cid"]').val();
							var cpw = $('input[name="cpw"]').val();
							var cname = $('input[name="cname"]').val();
							var chp = $('input[name="chp"]').val();
							var caddr1 = $('input[name="caddr1"]').val();
							var caddr2 = $('input[name="caddr2"]').val();
							if(!(cid && cpw && cname && chp && caddr1 && caddr2)){
								alert("모든 항목을 입력하셔야 합니다");
							}
							else{
								if($('input[name="checkDone"]').val() != "t") alert("아이디 중복확인을 해주세요");
								else{
									$("form#next").attr("action","join.do");
									$("form#next").submit();
								}
							}
						});
					
					</script>
					<input type="button" value="초기화" onclick="form_reset()" id="reset"/>
				</td>
			</tr>
			<tr><td>
			   <div class="index"><a href="index.jsp">시작화면으로</a></div>
			</td></tr>
		</table>
	</form>
</body>
</html>