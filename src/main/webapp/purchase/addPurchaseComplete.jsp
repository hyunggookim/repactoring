<%@ page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
<%
  PurchaseVO vo = (PurchaseVO)request.getAttribute("pccomvo");
%>
 --%>
<html>
<head>
<title>Insert title here</title>
</head>

<body>

<form name="updatePurchase" action="/purchase/updatePurchaseView?tranNo=0" method="post">

다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td> ${pccomvo.PurchaseProd.ProdNo}</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td> ${pccomvo.Buyer.UserId}</td>
		<td></td>
	</tr>
	<tr>
		<td>구매방법</td>
		<td>
		
			${pccomvo.PaymentOption}
		
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자이름</td>
		<td>${pccomvo.Buyer.UserName}</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td>${pccomvo.Buyer.Phone}</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td>${pccomvo.DivyAddr}</td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td>${pccomvo.DivyRequest}</td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td>${pccomvo.DivyDate}</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>