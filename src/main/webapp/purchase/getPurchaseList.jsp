<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<%-- 
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.purchase.vo.*" %>
<%@ page import="com.model2.mvc.common.*" %>
<%@ page import="com.model2.mvc.service.user.vo.*" %>
<%@ page import="com.model2.mvc.common.util.*" %>
<%
	UserVO uvo = (UserVO)session.getAttribute("user");
	System.out.println("UserId:"+uvo.getUserId());
	
	List<PurchaseVO> list= (List<PurchaseVO>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");

	SearchVO search = (SearchVO)request.getAttribute("search");
	//==> null �� ""(nullString)���� ����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
--%>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
function fncGetPurchaseList(currentPage) {
    if (typeof currentPage === 'undefined' || currentPage === ''|| currentPage === null) {
        currentPage = 1;
    }
	document.getElementById("currentPage").value = currentPage;

	$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<c:set var="uvo" value="${sessionScope.user}" />
<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü ${resultPage.totalCount } �Ǽ�, ����   ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

<c:set var="no" value="${list.size()}" />

<c:forEach var="vo" items="${list}" varStatus="status">
<c:choose>
    <c:when test="${not empty vo.tranCode}">
        <c:set var="tranCode" value="${fn:replace(vo.tranCode, ' ', '')}" />
    </c:when>
    <c:otherwise>
        <c:set var="tranCode" value="1" />
    </c:otherwise>
</c:choose>
	
	<tr class="ct_list_pop">
		<td align="center">
			<a href="/purchase/getPurchase?tranNo=${vo.tranNo}">${no - status.index}</a>
		</td>
		<td></td>
		<td align="left">
		${vo.buyer.userId}
		</td>
		<td></td>
		<td align="left">${vo.receiverName}</td>
		<td></td>
		<td align="left">${vo.receiverPhone}</td>
		<td></td>
		<td align="left">
			<c:choose>
				<c:when test="${tranCode == '1'}">
					���� ���ſϷ� ���� �Դϴ�.
				</c:when>
				<c:when test="${tranCode == '2'}">
					���� ����� ���� �Դϴ�.
				</c:when>
				<c:when test="${tranCode == '3'}">
					���� ��ۿϷ� ���� �Դϴ�.
				</c:when>
				<c:otherwise>
					�� �ƹ� ������ �ȶ���? ����ġ�׿�
				</c:otherwise>
			</c:choose>
		</td>
		<td></td>
		<td align="left">
			<c:if test="${tranCode == '2'}">
				<a href="/purchase/updateTranCodeByProd?tranNo=${vo.tranNo}&tranCode=3&role=${uvo.role}">���ǵ���</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
</c:forEach>

	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value="0"/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="functionName" value="fncGetPurchaseList"/>
			</jsp:include>
		</td>
	</tr>
</table>


<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>