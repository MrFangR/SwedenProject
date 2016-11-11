<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：介绍管理</div>
	
	<div class="ued-tab js_tab">
	    <div class="ued-tab-tit clearfix js_tab_tit">
	        <div class="ued-pack fr" id="ued-pack">收起查询条件</div>
	        <ul class="ued-tab-1 fl clearfix">
	        	<li class="liQuery on1"><a class="ued-see" href="javascript:void(0)">查询</a></li>
	        </ul>
	    </div>
	    <div class="ued-tab-con">
	        <div class="box-n on1">
	            <div id="showLst"></div>
	        </div>
	    </div>
	</div>
</body>
	<script type="text/javascript" src="${ctx}/back-ui/local-ui/backIntroduce.js"></script>
</html>
