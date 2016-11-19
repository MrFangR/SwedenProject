<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>happytimescont</title>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
     <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >

  
<!--cont-con S-->		
  <div class="cont-con">
    <h1 class="happytitle">作者：眼镜侠马丁</h1>
    <p class="confutitle">时间：2016-11-08 13:14:28</span></p>
       <p class="conline"></p>
       <div class="cont-text">
          照片描述：北京时间11月7日晚，2016斯诺克冠中冠开赛，在小组赛中火箭奥沙利文4-2战胜罗宾-赫尔，眼镜侠马丁-古尔德4-3击败老将马克-戴维斯，之后的小组决赛中奥沙利文6-2轻取古尔德。奥沙利文两场比赛打出了6杆50+和两杆破百，个人职业生涯单杆破百总数已达惊人的830杆。
       
        <p><img src="${ctx}/front-ui/images/banner1.jpg"></p>
       		 <div class="contentprevnextbox">
      			<div class="contentprev">上一篇:<a href="#none" rel="prev">中式台球锦标赛落户顺义</a></div>
      			<div class="contentnext">下一篇:<a href="#none" rel="next">国际台球比赛精彩时刻</a></div>
   			 </div>
        </div>
</div>
<!--cont-con E-->	
 
<!--评论 S-->
<%@ include file="/ninclude/frontMember/evaluation.jsp"%>
<form enctype="multipart/form-data" action="" id="evaForm">
  	<input type="hidden" value="${pic.ID}" id="OBJ_ID" name="evaluation.OBJ_ID"/>
   	<input type="hidden" value="1" id="OBJ_TYPE" name="evaluation.OBJ_TYPE"/>
   	<input type="hidden" value="" id="CONTENT" name="evaluation.CONTENT"/>
   	<input type="hidden" value="" id="P_ID" name="evaluation.P_ID"/>
</form>
<!--评论 E-->
 
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->

</body>
</html>

