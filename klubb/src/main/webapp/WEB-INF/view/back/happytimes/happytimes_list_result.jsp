<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	/* happytimes查询结果 */
%>
<c:set var="uploadUrl" value="${UPLOAD_SERVER_URL}"/>

<ul>
	<c:forEach items="${paginate.list}" var="pic">
		<li class="listbox" id="${pic.ID }" desc="${pic.DESCRIPTION }">
			<div class="listboximg"><a href="javascript:;"  target="_blank"><img  src="${uploadUrl}${pic.URL}" class="attachment-thumbnail wp-post-image" ></a></div>
				<div class="listinfo">
	          	<div class="listtitle"><a href="#none"  target="_blank">${pic.DESCRIPTION }</a></div>
	          	<div class="listdate">
					<span style="width: 60%; white-space: nowrap; overflow:hidden; text-overflow:ellipsis; display: inline-block;" title="${pic.NICKNAME }">作者：${pic.NICKNAME }  </span> <span class="riq"><fmt:formatDate value="${pic.createTime}" type="date"/></span></div>
					<div class="xs"><input name="" type="checkbox" value="" onclick="updateRecommend(this, '${pic.ID }');" <c:if test="${pic.isRecommend == 1}">checked="checked"</c:if>> 设为首页展示</div>
	         </div>
	  	</li>
	
	</c:forEach>
</ul>

<div class="clearfix"></div>
<div class="tc">
	<%@include file="/ninclude/back/page.jsp"%>
</div>
