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
  <header >
     <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >
<!--cont-con S-->		
  <div class="cont-con">
   		<!--内容 start-->
     <div class="main_body xmfb_con">
         <div class="xmfb_title">
           <h2>请填写参加活动信息</h2>
         </div>
         <div class="xmfb_xx"></div>
         <form enctype="multipart/form-data" action="" id="userFrom">
         <input type="hidden" value="${actID}" id="ACT_ID" name="actUser.ACT_ID"/>
						<div class="us-bd-base xmfb_con_text">
							
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl">姓名：</dt>
										<dd class="fl"><input  type="text" name="actUser.NAME" /></dd>
										<dd class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl">手机号码：</dt>
										<dd class="fl"><input  type="text" name="actUser.phone" /></dd>
										<dd class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl">邮箱地址：</dt>
										<dd class="fl"><input  type="text" name="actUser.EMAIL" /></dd>
										<dd class="notice"></dd>
									</dl>
                                    
                                 
                                    <dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn">提交</div>
										</dd>
									</dl>
                                  
                                 <div class="clearfix"></div>
                                          
								
						</div>
		</form>
     </div>
 
 <!--内容 end-->
  </div>
<!--cont-con E-->	
<!--bottom S-->
		<div class="bottombg">
           <p>Copyright © you name 2016 公司信息</p>
           <p>使用本网站即构成接受本网站的条款和条件以及隐私政策</p>
           
        </div>
<!--bottom E-->
</body>
<script type="text/javascript">
$(function(){
	$(".us-btn").live("click",function(){
		joinAct();
	});
});
function joinAct(){
	$.ajax({
		type : "POST",
		url : ctx + "/front/activity/addAct",
		dataType : "json",
		data : $("#userFrom").serialize(),
		success: function(data){
			alert(data.rsMsg);
			showEvaluation(1);
		}
	});

}
</script>
</html>

