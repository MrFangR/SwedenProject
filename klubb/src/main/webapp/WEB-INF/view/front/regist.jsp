<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.menu.regist"></i18n:get></title>
    <script  src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx }/front-ui/js/ui.js"></script>
    <script  src="${ctx }/js/jST.v0.1.4.min.js"></script>
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
           <h2><i18n:get key="portal.regist.title"></i18n:get></h2>
         </div>
         <div class="xmfb_xx"></div>
          
						<div class="us-bd-base xmfb_con_text">
						
							
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><span class="rose">*</span><i18n:get key="portal.contact.form.name"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="name" placeholder="Ange ditt namn"/></dd><!-- 请输入您的姓名 -->
										<dd id="name_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><span class="rose">*</span><i18n:get key="portal.regist.nickname"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="nickName" placeholder="Ange ditt smeknamn"/></dd><!-- 请输入您的昵称 -->
										<dd id="nickName_notice" class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><span class="rose">*</span><i18n:get key="portal.regist.number"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="idNum" placeholder="Ange ditt personnummer"/></dd><!-- 请输入您的人口号 -->
										<dd id="idNum_notice" class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><span class="rose">*</span><i18n:get key="portal.regist.email"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="email" placeholder="ange din e-postadress"/></dd><!-- 请输入您的邮箱 -->
										<dd id="email_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><span class="rose">*</span><i18n:get key="portal.regist.password"></i18n:get>：</dt>
										<dd class="fl"><input  type="password" id="pwd" placeholder=""/></dd><!-- 建议使用两种字符组合 -->
										<dd id="pwd_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><span class="rose">*</span><i18n:get key="portal.regist.repassword"></i18n:get>：</dt>
										<dd class="fl"><input  type="password" id="repwd" placeholder="bekräfta ditt nytt lösenord"/></dd><!-- 请再次输入密码 -->
										<dd id="repwd_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><span class="rose">*</span><i18n:get key="portal.regist.gender"></i18n:get>：</dt>
										<dd class="fl">
											<input name="sex" type="radio" value="1" style="width:30px;border: 0;">男   
											<input name="sex" type="radio" value="0" style="width:30px; margin-left:50px;border: 0;"> 女
										</dd>
										<dd id="sex_notice" class="notice"></dd>
									</dl>	
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl" style="width:175px"><i18n:get key="portal.regist.phone"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="phone" placeholder="Mobilnummer"/></dd><!-- 请输入您的手机号 -->
										<dd id="phone_notice" class="notice"></dd>
									</dl>
                                    <dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn" id="submitRegist"><i18n:get key="portal.menu.regist"></i18n:get></div>
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
<script type="text/javascript">

document.onkeydown=function(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		$("#submitRegist").trigger("click");
	}
}

function userRegist(){
	$("#submitRegist").unbind("click");
	var name = $("#name").val();
	if(name.trim().length==0){
		$("#name_notice").html("Ange ditt namn	！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var niceName = $("#nickName").val();
	if(niceName.trim().length==0){
		$("#nickName_notice").html("Ange ditt smeknamn！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var idNum = $("#idNum").val();
	if(idNum.trim().length==0){
		$("#idNum_notice").html("Ange ditt personnummer！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var email = $("#email").val();
	if(email.trim().length==0){
		$("#email_notice").html("ange din e-postadress！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}else if(!jST.isEmail(email)){
		$("#email_notice").html("E-postadressen är ogiltlig!");//请输入正确邮箱地址!	
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var pwd = $("#pwd").val();
	if(pwd.trim().length==0){
		$("#pwd_notice").html("ange ditt lösenord！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var repwd = $("#repwd").val();
	if(repwd.trim().length==0){
		$("#repwd_notice").html("Bekräfta ditt lösenord！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}else if(pwd!=repwd){
		$("#repwd_notice").html("Lösenorden stämmer inte!");//两次密码不一致,请重新输入!	
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	$.ajax({
		type: "post",
		cache: false,
		dataType : "json",
		url : "${ctx}/front/regist",
		data : {
			"name" : $("#name").val(),
			"nickName" : $("#nickName").val(),
			"idNum" : $("#idNum").val(),
			"email" : $("#email").val(),
			"sex" : $("input[name='sex']:checked").val(),
			"phone" : $("#phone").val(),
			"pwd" : $("#pwd").val(),
			"repwd" : $("#repwd").val()
		},
		success : function(json) {
			var mark = json.retCode;
			if (mark == 0) {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'registrera',//注册
					text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
					'ok':function(){window.location.href = '${ctx}/home';},
					tag:'zq-ring'}
	               );
			} else {
				var tip = json.retMsg.split(":");
				$("#"+tip[0]+"_notice").html(tip[1]);
				$("#submitRegist").bind("click",userRegist);
			}
		},
		error : function() {
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'jag har glömt mitt lösenord',
				text:'<div style=" font-size:18px; color:#ff0000;"> 注册失败 </div>',
				'ok':function(){$("#submitRegist").bind("click",userRegist);},
				tag:'cw-ring'}
               );
			
		}
	});
}
$(function(){
	$("#submitRegist").bind("click",userRegist);
	$("#name").focus(function(){
		$("#name_notice").html("");
	});
	$("#nickName").focus(function(){
		$("#nickName_notice").html("");
	});
	$("#idNum").focus(function(){
		$("#idNum_notice").html("");
	});
	$("#email").focus(function(){
		$("#email_notice").html("");
	});
	$("#pwd").focus(function(){
		$("#pwd_notice").html("");
	});
	$("#repwd").focus(function(){
		$("#repwd_notice").html("");
	});
});
</script>

