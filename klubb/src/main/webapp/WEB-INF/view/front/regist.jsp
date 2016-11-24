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
           <h2>注册通行证</h2>
         </div>
         <div class="xmfb_xx"></div>
          
						<div class="us-bd-base xmfb_con_text">
						
							
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>姓名：</dt>
										<dd class="fl"><input  type="text" id="name" placeholder="请输入您的姓名"/></dd>
										<dd id="name_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>昵称：</dt>
										<dd class="fl"><input  type="text" id="nickName" placeholder="请输入您的昵称"/></dd>
										<dd id="nickName_notice" class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>人口号：</dt>
										<dd class="fl"><input  type="text" id="idNum" placeholder="请输入您的人口号"/></dd>
										<dd id="idNum_notice" class="notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>邮箱：</dt>
										<dd class="fl"><input  type="text" id="email" placeholder="请输入您的邮箱"/></dd>
										<dd id="email_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>密码：</dt>
										<dd class="fl"><input  type="password" id="pwd" placeholder="建议使用两种字符组合"/></dd>
										<dd id="pwd_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>确认密码：</dt>
										<dd class="fl"><input  type="password" id="repwd" placeholder="请再次输入密码"/></dd>
										<dd id="repwd_notice" class="notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl"><span class="rose">*</span>性别：</dt>
										<dd class="fl">
											<input name="sex" type="radio" value="1" style="width:30px;border: 0;">男   
											<input name="sex" type="radio" value="0" style="width:30px; margin-left:50px;border: 0;"> 女
										</dd>
										<dd id="sex_notice" class="notice"></dd>
									</dl>	
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl">手机号码：</dt>
										<dd class="fl"><input  type="text" id="phone" placeholder="请输入您的手机号"/></dd>
										<dd id="phone_notice" class="notice"></dd>
									</dl>
                                    <dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn" id="submitRegist">注册</div>
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

function userRegist(){
	$("#submitRegist").unbind("click");
	var name = $("#name").val();
	if(name.trim().length==0){
		$("#name_notice").html("姓名不能为空！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var niceName = $("#nickName").val();
	if(niceName.trim().length==0){
		$("#nickName_notice").html("昵称不能为空！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var idNum = $("#idNum").val();
	if(idNum.trim().length==0){
		$("#idNum_notice").html("人口号不能为空！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var email = $("#email").val();
	if(email.trim().length==0){
		$("#email_notice").html("邮箱不能为空！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}else if(!jST.isEmail(email)){
		$("#email_notice").html("请输入全法邮箱地址！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var pwd = $("#pwd").val();
	if(pwd.trim().length==0){
		$("#pwd_notice").html("密码不能为空！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}
	var repwd = $("#repwd").val();
	if(repwd.trim().length==0){
		$("#repwd_notice").html("确认密码不能为空！");
		$("#submitRegist").bind("click",userRegist);
		return false;
	}else if(pwd!=repwd){
		$("#repwd_notice").html("两次密码不一致，请重新输入！");
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
				alert(json.retMsg);
				window.location.href = '${ctx}/front/toLogin';
			} else {
				var tip = json.retMsg.split(":");
				$("#"+tip[0]+"_notice").html(tip[1]);
				$("#submitRegist").bind("click",userRegist);
			}
		},
		error : function() {
			alert("注册失败");
			$("#submitRegist").bind("click",userRegist);
		}
	});
}
$("#submitRegist").bind("click",userRegist);
</script>

