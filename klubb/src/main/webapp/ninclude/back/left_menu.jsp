<%@page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/* 后台管理系统 页面统一引用 - 左侧菜单 */
%>
<div class="left-control" id="left-control">
	<div class="side-fold js_side_fold"></div>
	<h4 class="ued-side-tit">台球厅管理</h4>
	<ul class="list-c1 js_list_active">
		<li>
			<a tabid="1-1" url="${ctx}/back/introduce">
				<b class="b-t6"></b><span>介绍管理</span>
			</a>
		</li>
	</ul>
	
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