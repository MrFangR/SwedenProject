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
    <h1 class="happytitle">作者：${user.NICKNAME}</h1>
    <p class="confutitle">时间：${pic.createTime}</span></p>
       <p class="conline"></p>
       <div class="cont-text">
          ${pic.DESCRIPTION}
        <p><img src="${uploadUrl}${pic.URL}"></p>
       		 <div class="contentprevnextbox">
      			<div class="contentprev">上一篇:
      				<c:if test="${empty prevPic}">
						没有上一篇
					</c:if>
      				<c:if test="${not empty prevPic}">
						<a href="${ctx}/front/happytimes/showHTdetails?picID=${prevPic.ID}" rel="prev">${prevPic.DESCRIPTION}</a>
					</c:if>
      			</div>
      			<div class="contentnext">下一篇:
      				<c:if test="${empty nextPic}">
						没有下一篇
					</c:if>
      				<c:if test="${not empty nextPic}">
						<a href="${ctx}/front/happytimes/showHTdetails?picID=${nextPic.ID}" rel="next">${nextPic.DESCRIPTION}</a>
					</c:if>
      			</div>
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

