

<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%--
<%
	String menu = request.getParameter("menu");
    
    List<ProductVO> list= (List<ProductVO>)request.getAttribute("list");
    Page resultPage=(Page)request.getAttribute("resultPage");

    SearchVO search = (SearchVO)request.getAttribute("search");
    //==> null �� ""(nullString)���� ����
    String searchCondition = CommonUtil.null2str(search.getSearchCondition());
    String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());

%>
 --%>
<c:set var="menu" value="${param.menu}" />
<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function fncGetSaleList(currentPage, menuValue) {
		if (typeof currentPage === 'undefined' || currentPage === null || currentPage === '') {
			currentPage = 1;
		}

		document.getElementById("currentPage").value = currentPage;
		if (menuValue && menuValue != '') {
			document.getElementById("menu").value = menuValue;
		}
		$("form").attr("method" , "POST").attr("action" , "/purchase/listSale").submit();

	}
	
	$(function() {
		 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			 fncGetSaleList(1,${menu});
		});
</script>




</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">
		<input type="hidden" id="menu" name="menu" value="${menu}" />
		<form name="detailForm">



			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">��� ����</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
							<option value="2"
								${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>����</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : ''}"  
						class="ct_input_g" style="width: 200px; height: 20px">
					</td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetSaleList(1,'${menu}');">�˻�</a></td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">��ü ${resultPage.totalCount } �Ǽ�, ����
						${resultPage.currentPage} </td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�������</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<c:forEach var="item" items="${list}" varStatus="status">
					<c:set var="proTranCode" value="${item.tranCode.toString()}" />

					<tr class="ct_list_pop">
						<td align="center">${list.size() - status.index}</td>
						<td></td>
						<td align="left">
									<a href="/product/getProduct?prodNo=${item.purchaseProd.prodNo}">${item.purchaseProd.prodName}</a>
							</td>
						<td></td>
						<td align="left">${item.purchaseProd.price}</td>
						<td></td>
						<td align="left">${item.purchaseProd.manuDate}</td>
						<td></td>
						<td align="left">
						<c:choose>
	
                <c:when test="${proTranCode == '0'}">
                    �Ǹ���
                </c:when>
				<c:when test="${proTranCode == '1'}">
                    ���ſϷ� <a href="/purchase/updateTranCodeByProd?tranNo=${item.tranNo}&tranCode=2&role=admin">����ϱ�</a>
				</c:when>
				<c:when test="${proTranCode == '2'}">
                    �����
                </c:when>
				<c:when test="${proTranCode == '3'}">
                    ��ۿϷ�
                </c:when>
      </c:choose>
								
							</td>
					</tr>
				</c:forEach>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> <jsp:include
							page="../common/pageNavigator.jsp">
							<jsp:param name="functionName" value="fncGetSaleList" />
						</jsp:include></td>
				</tr>
			</table>

			<!--  ������ Navigator �� -->
		</form>
	</div>
</body>
</html>