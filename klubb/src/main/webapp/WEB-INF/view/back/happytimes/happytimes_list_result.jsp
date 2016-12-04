<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	/* happytimes查询结果 */
%>


<ul>
	<c:forEach items="${paginate.list}" var="pic">
		<li class="listbox" id="${pic.ID }">
			<div class="listboximg"><a href="javascript:;"  target="_blank"><img  src="${uploadUrl}/${pic.URL}" class="attachment-thumbnail wp-post-image" ></a></div>
				<div class="listinfo">
	          	<div class="listtitle"><a href="#none"  target="_blank">${pic.DESCRIPTION }</a></div>
	          	<div class="listdate">作者：${pic.NICKNAME }   <span class="riq"><fmt:formatDate value="${pic.createTime}" type="date"/></span></div>
	         	<div class="xs"><input name="" type="checkbox" value="" onclick="updateRecommend(this, '${pic.ID }');"> 设为首页展示</div>
	         </div>
	  	</li>
	
	</c:forEach>
</ul>

<div class="clearfix"></div>
<div class="tc">
	<%@include file="/ninclude/back/page.jsp"%>
</div>
