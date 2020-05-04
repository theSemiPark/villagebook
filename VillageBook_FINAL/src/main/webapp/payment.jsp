<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>결제 하기</title>
</head>

<body>
	<h2>결제 하기</h2>
	<button id="check_module" type="button">결제</button>
	<script>
	    $("#check_module").click(function () {
	        var IMP = window.IMP;
	        IMP.init('imp86252380');
	        IMP.request_pay({
	            pg: 'inicis',
	            pay_method: 'card',
	            merchant_uid: 'merchant_' + new Date().getTime(),
	         
	            name: '동네북 배송료 결제', 
	            amount: '${fi}', 
	            buyer_email: 'iamport@siot.do',
	            buyer_name: '${user.cname }',
	            buyer_tel: '${user.chp }',
	            buyer_addr: '${user.caddr1} ${user.caddr2}',
	            buyer_postcode: '${user.cpostcode}',
	            m_redirect_url: 'http://localhost:8080/biz/insertPoint.do'
	        }, function (rsp) {
	            console.log(rsp);
	            if (rsp.success) {
	                var msg = '결제가 완료되었습니다.';
	                msg += '고유ID : ' + rsp.imp_uid;
	                msg += '상점 거래ID : ' + rsp.merchant_uid;
	                msg += '결제 금액 : ' + rsp.paid_amount;
	                msg += '카드 승인번호 : ' + rsp.apply_num;
	                var result = confirm(msg);
	                if(result){
	                	console.log(msg);
		            	document.write("<center><form action='paid.do' method='post'><input type='submit' value='결제완료'></form></center>");
		            }else {
		            	console.log(msg);
		            	location.href = "payfail.jsp";
		            }
	            } else {
	                var msg = '결제에 실패하였습니다.';
	                msg += '에러내용 : ' + rsp.error_msg;
	                location.href = "payfail.jsp";
	            }
	         	
	        });
	    });
	</script>
	
</body>

</html>