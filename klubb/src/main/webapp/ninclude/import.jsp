<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
<%/* 引入css end */%>
<%/* 引入js start */%>
	<script type="text/javascript" src="${ctx}/front-ui/js/page.js"></script>
<%/* 引入js end */%>