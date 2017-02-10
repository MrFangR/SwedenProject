<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.activity.title"></i18n:get></title>
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
          <input name="title" id="title" type="text"  class="inputfont" value=""><input name="search" id="search" type="button" class="inputbut" value="<i18n:get key='portal.activity.search.button'></i18n:get>">
       </p>
  </div>
<!--ist-con S-->		
  <div class="list-con">
	<div class="list-tab"> 
   		<div class="list-title curr">当前比赛</div>
        <div class="list-title">即将比赛</div>
        <div class="list-title">往期比赛</div>
        <div class="list-title">报名用户</div>
        <div class=" clearfix"></div>
	</div>
	<!--内容 S-->	
	<div class="listtabcon">
	<!--第一 S-->	
	<div class="tabsub mgt-20">
		<ul></ul>
		<!--分页 start-->
      	<div class="paging clearfix" id="pageDiv0"></div>
      	<!--分页 end--> 
	   	<div class="clearfix"></div>
	</div>
    <!--第一 E-->	 
    <!--第二 S-->	
    <div class="tabsub" style="display:none;">
    	<ul></ul>
  		<!--分页 start-->
  		<div class="paging clearfix" id="pageDiv1"></div>
  		<!--分页 end-->  
	<div class="clearfix"></div>          
    </div>
    <!--第二 E-->	 
    <!--第三 S-->	
    <div class="tabsub" style="display:none;">
    	<ul></ul>
		<!--分页 start-->
        <div class="paging clearfix" id="pageDiv2"></div> 
        <!--分页 end-->  
		<div class="clearfix"></div>
    </div>
    <!--第三 E-->	 
    <!--第四 S-->	
    <div class="tabsub" style="display:none;">
    	<table class="table-con mgt-20">
    		<thead>
        	<tr>
        		<th>参赛人员姓名</th>
           		<th>起始分</th>
         	</tr>
         	</thead>
         	<tbody></tbody>
      	</table>
      	<!--分页 start-->
        <div class="paging clearfix" id="pageDiv3"></div> 
        <!--分页 end-->  
		<div class="clearfix"></div>
    </div>
    <!--第四 E-->	 
	 </div>
	 <!--内容 E-->
  </div>
<!--list-con E-->	
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
	<script type="text/javascript" src="${ctx}/front-ui/local-ui/match.js"></script>
</html>

