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

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td> ${pccomvo.PurchaseProd.ProdNo}</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td> ${pccomvo.Buyer.UserId}</td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
		
			${pccomvo.PaymentOption}
		
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${pccomvo.Buyer.UserName}</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${pccomvo.Buyer.Phone}</td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${pccomvo.DivyAddr}</td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${pccomvo.DivyRequest}</td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${pccomvo.DivyDate}</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>