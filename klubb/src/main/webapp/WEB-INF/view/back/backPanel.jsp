<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<!-- top menu -->
	<%@include file="/ninclude/back/top_menu.jsp"%>
	<!-- main content -->
	<div class="ued-control-con clearfix ued-navtab-2" data-role="navtab" id="navtab">
		<!-- tab -->
		<div class="navtab-title clearfix">
			<ul class="nav-tabs" style="margin-left: 0px; ">
				<li class="active"><a tabid="201" href="${ctx}/back/main/init">工作台</a></li>
			</ul>
		</div>
		<!-- left menu -->
		<%@include file="/ninclude/back/left_menu.jsp"%>
	    <!-- main  s -->
	    <div class="right-control navtab-content" id="right-control">
	        <div class="mask"></div>
	    	<iframe width="100%" height="auto" src="${ctx}/back/main/index" frameborder="0" tabid="201" style="display: inline;"></iframe>
	    </div>
	    <!-- main  D -->
	</div>
</body>

<script>
function reloadPanel(){
	self.location.reload();
}
$(function(){
	if (top.location.href != self.location.href) {
		top.location.href = self.location.href;
	}
});
</script>
</html>
