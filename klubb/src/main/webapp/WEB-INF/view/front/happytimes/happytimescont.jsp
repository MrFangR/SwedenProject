<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.menu.happytimes"></i18n:get></title>
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
  	
    <h1 class="happytitle"><i18n:get key="portal.happytimes.author"></i18n:get>:${user.NICKNAME}</h1>
    <p class="confutitle"><i18n:get key="portal.activity.detail.date"></i18n:get>:<fmt:formatDate value="${pic.createTime}" pattern="dd/MM/yyyy HH:mm:ss"/></span></p>
       <p class="conline"></p>
       <div class="cont-text">
          ${pic.DESCRIPTION}
        <p><img src="${uploadUrl}${pic.URL}"></p>
       		 <div class="contentprevnextbox">
     			<c:if test="${not empty nextPic}">
					<div class="contentprev"><i18n:get key="portal.happytimes.prev"></i18n:get>:
						<a href="${ctx}/front/happytimes/showHTdetails?picID=${nextPic.ID}" rel="next">${nextPic.DESCRIPTION}</a>
					</div>
				</c:if>
     			<c:if test="${not empty prevPic}">
     				<div class="contentnext"><i18n:get key="portal.happytimes.next"></i18n:get>:
						<a href="${ctx}/front/happytimes/showHTdetails?picID=${prevPic.ID}" rel="prev">${prevPic.DESCRIPTION}</a>
					</div>
				</c:if>
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

