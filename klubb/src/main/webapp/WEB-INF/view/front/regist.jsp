<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>注册</title>
    <script  src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx }/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx }/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
     <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >

  
<!--cont-con S-->		
  <div class="cont-con">
   		<!--内容 start-->
     <div class="main_body xmfb_con">
         <div class="xmfb_title">
           <h2>注册通行证</h2>
         </div>
         <div class="xmfb_xx"></div>
          
						<div class="us-bd-base xmfb_con_text">
						
							
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>用户名：</dt>
										<dd class="fl"><input  type="text" /></dd>
										<dd class="notice">提示信息位置</dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>请设置密码：</dt>
										<dd class="fl"><input  type="text" /></dd>
										<dd class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>请确认密码：</dt>
										<dd class="fl"><input  type="text" /></dd>
										<dd class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>手机号码：</dt>
										<dd class="fl"><input  type="text" /></dd>
										<dd class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>手机验证码：</dt>
										<dd class="fl"><input  type="text" /></dd>
										<dd class="notice"></dd>
									</dl>	
                                    <dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn">注册</div>
										</dd>
									</dl>
                                 <div class="clearfix"></div>
						</div>
     </div>
 
 <!--内容 end-->
  </div>
<!--cont-con E-->	
<!--bottom S-->
	<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
<!--回复内容 start-->
<!--回复内容 end-->
</body>
</html>

