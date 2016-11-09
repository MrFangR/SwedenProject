<%@page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/* 后台管理系统 页面统一引用 - 左侧菜单 */
%>
<div class="left-control" id="left-control">
	<div class="side-fold js_side_fold"></div>
	
	<c:if test="${not empty menuLst}">
		<c:forEach items="${menuLst}" var="m0">
			<c:if test="${m0.PARENT_ID eq 0}">
				<h4 class="ued-side-tit">${m0.FUNC_NAME}</h4>
				<ul class="list-c1 js_list_active">
					<c:forEach items="${menuLst}" var="m1">
						<c:if test="${m1.PARENT_ID eq m0.ID}">
							<li>
								<a tabid="${m0.ID}-${m1.ID}" url="${ctx}${m1.FUNC_URL}">
									<b class="b-t6"></b><span>${m1.FUNC_NAME}</span>
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</c:if>
		</c:forEach>
	</c:if>
</div>



<script>
$(function(){
	// 绑定左侧菜单点击事件
	$(".list-c1 li a").click(function(){
        var url = $(this).attr("url");
        var txt = $(this).text();
        var tabid = $(this).attr("tabid");
        if(!url){
            return false;
        }
        $("#navtab").UED_navtab.open(tabid, txt, url);
    });
	// 100ms后重新加载拉动条效果
    setTimeout(function(){
    	$("#left-control").jScrollPane();
    }, 100);
});
</script>