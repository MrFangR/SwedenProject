<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.menu.activity"></i18n:get></title>
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
           <h2><i18n:get key="portal.contact.form.title"></i18n:get></h2>
         </div>
         <div class="xmfb_xx"></div>
         <form enctype="multipart/form-data" action="" id="userFrom">
         <input type="hidden" value="${actID}" id="ACT_ID" name="actUser.ACT_ID"/>
			<div class="us-bd-base xmfb_con_text">
	            <dl  class="us-info-dl clearfix">
					<dt class="fl"><i18n:get key="portal.contact.form.name"></i18n:get>:</dt>
					<dd class="fl"><input  type="text" name="actUser.NAME" /></dd>
					<dd class="notice" id="name_notice"></dd>
				</dl>
	            <dl  class="us-info-dl clearfix">
					<dt class="fl"><i18n:get key="portal.contact.form.phone"></i18n:get>:</dt>
					<dd class="fl"><input  type="text" name="actUser.phone" /></dd>
					<dd class="notice" id="phone_notice"></dd>
				</dl>
	            <dl  class="us-info-dl clearfix">
					<dt class="fl"><i18n:get key="portal.contact.form.email"></i18n:get>:</dt>
					<dd class="fl"><input  type="text" name="actUser.EMAIL" /></dd>
					<dd class="notice" id="email_notice"></dd>
				</dl>
	            <dl class="us-info-dl clearfix">
					<dt class="fl">&nbsp;</dt>
					<dd class="fl">
					<div class="us-btn"><i18n:get key="portal.contact.form.submit"></i18n:get></div>
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
<%@ include file="/ninclude/frontMember/footer.jsp"%>
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
			if(data.rsFlag){
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'提示信息',
					text:'<div style=" font-size:18px; color:#ff0000;">Du är anmäld till aktiviteten.</div>',//参加活动成功
					'ok':function(){location.href=ctx + "/front/activity";},
					tag:'zq-ring'}
	               );
			}else{
				showNotice(data);
				enableBtn();
			}
		}
	});
}
//显示提示信息
function showNotice(data){
	if(data.rsFlag){
		ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'提示信息',
					text:'<div style=" font-size:18px; color:#ff0000;">Det gick inte att anmäla dig till aktiviteten.</div>',//参加活动失败
					'ok':function(){},
					tag:'zq-ring'}
	               );
	}else{
		$(".notice").each(function(){
			var tip = eval("data." + this.id);
			if(tip != null && tip != "" && tip != undefined && tip != "undefined"){
				$(this).html(tip);
			}else{
				$(this).html("");
			}
		});
	}
}
function enableBtn(){
	$(".us-btn").attr("disabled", "");
}
</script>
</html>

