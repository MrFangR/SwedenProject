<%@page pageEncoding="UTF-8"%>
<%
	/* 后台管理系统 页面统一引用 - 头部 */
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<%/* 设置公用java变量 start */%>

<%/* 设置公用java变量 end */%>
<%/* 引入 标签 start */%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%/* 引入 标签  end */%>

<%/* 设置公用js变量 start */%>
	<c:set var="ctx" value="${CONTEXT_PATH}"/>
	<c:set var="uploadUrl" value="${UPLOAD_SERVER_URL}"/>
	<script>
		var ctx = "${ctx}";
		var uploadUrl = "${uploadUrl}";
	</script>
<%/* 设置公用js变量 end */%>

<%/* 引入css start */%>
	<link rel="stylesheet" type="text/css" href="${ctx}/back-ui/pub-ui/css/skin1/all.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/back-ui/pub-ui/css/skin1/navtab.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/back-ui/pub-ui/css/skin1/contextMenu.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/back-ui/pub-ui/css/skin1/jquery.jscrollpane.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/back-ui/pub-ui/css/skin1/zTreeStyle.css" />
    <link rel="stylesheet" type="text/css"  href="${ctx}/css/ands-popAlert.css"></link>
    <link rel="stylesheet" type="text/css" href="${ctx}/back-ui/pub-ui/css/skin1/dragula.css" />
<%/* 引入css end */%>

<%/* 引入js start */%>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/lib/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/ui.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/local-ui/backCommon.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/navtab.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/contextMenu.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/jquery.mousewheel.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/mwheelIntent.js.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/jquery.jscrollpane.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/jquery.ztree.all-3.5.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/dialog.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/sysLayout.js"></script>
	<script type="text/javascript" src="${ctx}/js/ands-popAlert.js"></script>
	<script type="text/javascript" src="${ctx}/front-ui/js/page.js"></script>
	<script type="text/javascript" src="${ctx}/js/ajaxfileupload.js"></script>
<%/* 引入js end */%>

<%/* 设置面包屑 end */%>
<c:set var="nav_priv" value="系统配置&nbsp;&gt;&nbsp;功能权限管理"/>
<c:set var="nav_role" value="系统配置&nbsp;&gt;&nbsp;角色管理"/>
<c:set var="nav_user" value="系统配置&nbsp;&gt;&nbsp;账号管理"/>
<c:set var="nav_custmsg" value="系统管理&nbsp;&gt;&nbsp;客户留言管理"/>
<c:set var="nav_project" value="系统管理&nbsp;&gt;&nbsp;项目管理"/>
<c:set var="nav_shop" value="系统管理&nbsp;&gt;&nbsp;商铺管理"/>
<c:set var="nav_release" value="系统管理&nbsp;&gt;&nbsp;快速发布"/>
<c:set var="nav_evaluation" value="系统管理&nbsp;&gt;&nbsp;纠错举报管理"/>
<c:set var="nav_member" value="系统管理&nbsp;&gt;&nbsp;会员管理"/>
<c:set var="nav_news" value="系统管理&nbsp;&gt;&nbsp;开店资讯"/>
<c:set var="nav_chain" value="系统管理&nbsp;&gt;&nbsp;连锁公司"/>
<c:set var="nav_category" value="系统管理&nbsp;&gt;&nbsp;类型配置"/>
<c:set var="nav_xs" value="系统管理&nbsp;&gt;&nbsp;悬赏管理"/>
<%/* 设置面包屑 end */%>
