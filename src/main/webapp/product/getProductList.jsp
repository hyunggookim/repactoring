
<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
<%
	String menu = request.getParameter("menu");
    
    List<ProductVO> list= (List<ProductVO>)request.getAttribute("list");
    Page resultPage=(Page)request.getAttribute("resultPage");

    SearchVO search = (SearchVO)request.getAttribute("search");
    //==> null 을 ""(nullString)으로 변경
    String searchCondition = CommonUtil.null2str(search.getSearchCondition());
    String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());

%>
 --%>
<c:set var="menu" value="${param.menu}" />
<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	

	
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<script type="text/javascript">
	function fncGetProductList(currentPage, menuValue) {
		if (typeof currentPage === 'undefined' || currentPage === null || currentPage === '') {
			currentPage = 1;
		}

		document.getElementById("currentPage").value = currentPage;
		if (menuValue && menuValue != '') {
			document.getElementById("menu").value = menuValue;
		}
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();

	}
	
	$(function() {
		 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			 fncGetProductList(1,'${menu}');
		});
	});
	
	$(function() {
	    $("input[name='searchKeyword']").autocomplete({
	        source: function(request, response) {
	            $.ajax({
	                url: "/product/json/search",
	                type: "POST",
	                dataType: "json",
	                data: {
	                    searchCondition: $("select[name='searchCondition']").val(),
	                    searchKeyword: request.term
	                },
	                success: function(data) {
	                    response(data);
	                }
	            });
	        },
	        minLength: 1,
	        select: function(event, ui) {
	            console.log(ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
	        },
	        response: function(event, ui) {
	            if (ui.content.length === 0) {
	                var noResult = { value:"", label:"검색 결과가 없습니다" };
	                ui.content.push(noResult);
	            }
	        }
	    });
	});





</script>




</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">
		<!-- 
		<form name="detailForm" action="/listProduct" method="post">
  -->
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
								<td width="93%" class="ct_ttl01">상품 관리</td>
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
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
							<option value="2"
								${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>가격</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : ''}"
						class="ct_input_g" style="width: 200px; height: 20px"></td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;">검색</td>
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
					<td colspan="11">전체 ${resultPage.totalCount } 건수, 현재
						${resultPage.currentPage} 페이지 ${menu }</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">image</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<c:choose>
						<c:when test="${menu == 'manage'}">
							<td class="ct_list_b">남은 물품 수</td>
						</c:when>
					</c:choose>

					<td class="ct_list_b">현재상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<c:forEach var="item" items="${list}" varStatus="status">
					<c:set var="proTranCode" value="${item.proTranCode}" />

					<tr class="ct_list_pop"
						style="${status.index % 2 == 0 ? 'background-color: rgb(234,234,234);' : ''}">
						<td align="center" style="padding: 10px;">
						
						<img
							src="/images/uploadFiles/${item.fileName}" alt="Product Image"
							style="width: 300px; height: auto;" /></td>
						<td></td>
						<td align="center" style="padding-right: 50px;"><c:choose>
								<c:when test="${menu == 'manage'}">
									<a href="/product/updateProduct?prodNo=${item.prodNo}">${item.prodName}</a>
								</c:when>
								<c:otherwise>
									<a href="/product/getProduct?prodNo=${item.prodNo}">${item.prodName}</a>
								</c:otherwise>
							</c:choose></td>
						<td></td>
						<td align="center">${item.price}</td>
						<td></td>
						<td align="center">${item.manuDate}</td>
						<td></td>
						<c:choose>
							<c:when test="${menu == 'manage'}">
								<td align="center">${item.count}</td>
							</c:when>
						</c:choose>
						<td align="center">${item.count == 0 ? '재고없음' : '판매중'}</td>
					</tr>
				</c:forEach>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /><input type="hidden" id="menu"
						name="menu" value="${menu}" /> <jsp:include
							page="../common/pageNavigator.jsp">
							<jsp:param name="functionName" value="fncGetProductList" />
						</jsp:include></td>
				</tr>
			</table>

			<!--  페이지 Navigator 끝 -->
		</form>
	</div>
</body>
</html>