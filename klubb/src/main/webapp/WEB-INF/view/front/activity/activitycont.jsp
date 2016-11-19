<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>活的内容</title>
    <%@include file="/ninclude/back/header.jsp"%>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header>
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header>
<!--cont-con S-->
  	<div class="cont-con">
    	<h1 class="contitle">${act.TITLE}</h1>
    	<p class="confutitle"><input name="addAct"  class="contbtn" type="button" value="+参加活动" onclick="addAct(${act.ID})"><span>时间：${act.actTime}</span><span class="mgl-200">地点：大南门**台球厅</span></p>
      	<p class="conline"></p>
      	<div class="cont-text">
      		${act.CONTENT}
       	</div>
	</div>
<!--cont-con E-->	
 
<!--评论 S-->
<%@ include file="/ninclude/frontMember/evaluation.jsp"%>
</div>
<form enctype="multipart/form-data" action="" id="evaForm">
  	<input type="hidden" value="${act.ID}" id="OBJ_ID" name="evaluation.OBJ_ID"/>
   	<input type="hidden" value="2" id="OBJ_TYPE" name="evaluation.OBJ_TYPE"/>
   	<input type="hidden" value="" id="CONTENT" name="evaluation.CONTENT"/>
   	<input type="hidden" value="" id="P_ID" name="evaluation.P_ID"/>
</form>
 <!--评论 E-->
 
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->

</body>
<script type="text/javascript">
function addAct(actID){
	location.href=ctx + "/front/activity/toJoinAct?actID=" + actID;
}
</script>
</html>

