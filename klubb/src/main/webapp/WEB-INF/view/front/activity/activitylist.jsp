<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>活的列表页</title>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header >
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header >
	<div class="search">
		<p class="w1000">
          <input name="title" id="title" type="text"  class="inputfont" value=""><input name="" onclick="searchAct()" type="button" class="inputbut" value="搜索">
       </p>
  </div>
<!--ist-con S-->		
  <div class="list-con">
     <div class="list-contitle">活动列表</div>
     <!-- activity-list-statr -->
      <ul id="resultDIV">
      </ul>
      <!-- activity-list-end -->
      <!--分页 start-->
      <div class="paging clearfix" id="pageDiv">
      </div>
      <!--分页 end-->    
      <div class="clearfix"></div>
  </div>
<!--ist-con E-->	
<!--bottom S-->
		<div class="bottombg">
           <p>Copyright © you name 2016 公司信息</p>
           <p>使用本网站即构成接受本网站的条款和条件以及隐私政策</p>
           
        </div>
<!--bottom E-->
</body>
	<script type="text/javascript" src="${ctx}/front-ui/local-ui/activity.js"></script>
</html>

