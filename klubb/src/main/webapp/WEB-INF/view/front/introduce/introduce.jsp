<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>contact us</title>
    <script  src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx }/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
    <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >
  <!--ist-con S-->		
  <div class="list-con">
       <div class="list-tab"> 
       		<div class="list-title curr">人员简介</div>
            <div class="list-title">公司简介</div>
            <div class=" clearfix"></div>
       
       </div>
       <div class="tabsub1">
            ${poolIntro.CONTENT }
       </div>
       
       <div class="tabsub2 cont-con"   style="display:none; margin:0px;">
       		 ${personIntro.CONTENT }
       </div>
      
      
       
      <div class="clearfix"></div>
      
  </div>
<!--ist-con E-->	
 <!--bottom S-->           
	<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
<script type="text/javascript">

</script>
</html>

