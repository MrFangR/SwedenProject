<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/ninclude/import.jsp"%> 

<%
// 如下参数需要在 include 该页面的地方被赋值才能使用，以下是示例
/*  
	<c:set var="currentPage" value="${blogPage.pageNumber}" />
	<c:set var="totalPage" value="${blogPage.totalPage}" />
	<c:set var="actionUrl" value="/blog/" />
	<c:set var="urlParas" value="" />
*/
%>

<c:if test="${urlParas == null}">
	<c:set var="urlParas" value="" />
</c:if>
<c:if test="${(totalPage > 0) && (currentPage <= totalPage)}">
	<c:set var="startPage" value="${currentPage - 4}" />
	<c:if test="${startPage < 1}" >
		<c:set var="startPage" value="1" />
	</c:if>
	<c:set var="endPage" value="${currentPage + 4}" />
	<c:if test="${endPage > totalPage}" >
		<c:set var="endPage" value="totalPage" />
	</c:if>
	
	<div class="paging mgtb-15 clearfix">
		<c:if test="${currentPage <= 8}">
			<c:set var="startPage" value="1" />
		</c:if>
		
		<c:if test="${(totalPage - currentPage) < 8}">
			<c:set var="endPage" value="${totalPage}" />
		</c:if>
		
		<c:choose>
			<c:when test="${currentPage == 1}">
				<span class="prev-on">上页</span>
			</c:when>
			<c:otherwise>
				<a href="${actionUrl}${urlParas}${currentPage - 1}" class="prev">上页</a>
			</c:otherwise>
		</c:choose>
		
		<c:if test="${currentPage > 8}">
			<a href="${actionUrl}${urlParas}${1}">${1}</a>
			<a href="${actionUrl}${urlParas}${2}">${2}</a>
			<span class="gap"><em>...</em></span>
		</c:if>
		
		<c:forEach begin="${startPage}" end="${endPage}" var="i">
			<c:choose>
				<c:when test="${currentPage == i}">
					<span class="on">${i}</span>
				</c:when>
				<c:otherwise>
					<a href="${actionUrl}${urlParas}${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${(totalPage - currentPage) >= 8}">
			<span class="gap"><em>...</em></span>
			<a href="${actionUrl}${urlParas}${totalPage - 1}">${totalPage - 1}</a>
			<a href="${actionUrl}${urlParas}${totalPage}" class="on">${totalPage}</a>
		</c:if>
		
		<c:choose>
			<c:when test="${currentPage == totalPage}">
				<span class="next-on">下页</span>
			</c:when>
			<c:otherwise>
				<a href="${actionUrl}${urlParas}${currentPage + 1}" class="next" rel="next">下页</a>
			</c:otherwise>
		</c:choose>
	</div>
</c:if>
