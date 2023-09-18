<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentFunction" value="${param.functionName}" />
<c:set var="menuValue" value="${param.menu}" />

<c:choose>
    <c:when test="${currentFunction == 'fncGetUserList'}">
        <c:set var="functionCall" value="fncGetUserList" />
    </c:when>
    <c:when test="${currentFunction == 'fncGetProductList'}">
        <c:set var="functionCall" value="fncGetProductList" />
    </c:when>
    <c:when test="${currentFunction == 'fncGetPurchaseList'}">
        <c:set var="functionCall" value="fncGetPurchaseList" />
    </c:when>
</c:choose>

<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">

</c:if>
<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
    <a href="javascript:${functionCall}('${ resultPage.currentPage-1}', '${menuValue}')">◀ 이전</a>
</c:if>

<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
    <a href="javascript:${functionCall}('${ i }', '${menuValue}');">${ i }</a>
</c:forEach>

<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">

</c:if>
<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
    <a href="javascript:${functionCall}('${resultPage.endUnitPage+1}', '${menuValue}')">이후 ▶</a>
</c:if>
