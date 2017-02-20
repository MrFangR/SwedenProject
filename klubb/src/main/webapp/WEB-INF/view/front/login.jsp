<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no,email=no">
<title><i18n:get key="portal.menu.login"></i18n:get></title>
<script src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
<script src="${ctx }/front-ui/js/ui.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx }/front-ui/css/reset.css">
<link rel="stylesheet" type="text/css"
	href="${ctx }/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header>
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header>


	<!--cont-con S-->
	<div class="cont-con">
		<!--内容 start-->
		<div class="main_body xmfb_con">
			<div class="xmfb_title" style="width:380px;">
				<h2><i18n:get key="portal.user.login"></i18n:get></h2>
			</div>
			<div class="xmfb_xx"></div>

			<div class="us-bd-base xmfb_con_text">
				<dl class="us-info-dl clearfix">
					<dt class="fl">
						<span class="rose">*</span><i18n:get key="portal.user.name"></i18n:get>:
					</dt>
					<dd class="fl">
						<input type="text" name="loginname" id="loginname" placeholder=""/>
					</dd>
					<dd id="loginname_notice" class="notice"></dd>
				</dl>

				<dl class="us-info-dl clearfix">
					<dt class="fl">
						<span class="rose">*</span><i18n:get key="portal.user.password"></i18n:get>:
					</dt>
					<dd class="fl">
						<input type="password" id="loginpwd" name="loginpwd" placeholder=""/>
					</dd>
					<dd id="loginpwd_notice" class="notice"></dd>
				</dl>
				<dl class="us-info-dl clearfix">
					<dt class="fl">
						<span class="rose">*</span><i18n:get key="portal.contact.form.code"></i18n:get>:
					</dt>
					<dd class="fl">
						<input type="text" id="imgcode" name="imgcode" maxlength="4" class="ued-input fl" style="width:110px;" /> 
						<img id="randCodeImage" class="mgl-10" style="height: 40px;" src="${ctx}/sys/randCodeImage" /> 
						<!-- 
						<a href="javascript:getRandImg();" class="fr login-a mgt-10">看不清?换一张</a>
						 -->
					</dd>
					<dd id="imgcode_notice" class="notice"></dd>
				</dl>
				<dl class="us-info-dl clearfix">
					<dt class="fl">&nbsp;</dt>
					<dd class="fl">
						<div class="us-btn" id="submitLogin"><i18n:get key="portal.menu.login"></i18n:get></div>
					</dd>
					<dd class="notice" style="padding-top:8px">
						<a href="${ctx }/front/toForget" style="font-size:12px; color:#03F; margin-left:20px;"><i18n:get key="portal.user.forget"></i18n:get>?</a>
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
</body>
</html>
<script type="text/javascript">

$("#submitLogin").click(function(){
	var login_no = $("#loginname").val();
	var password = $("#loginpwd").val();
	if (login_no.trim().length == 0) {
		$("#loginname_notice").html("ange din e-postadress!");//请输入邮箱 
		return false;
	}
	if (password.trim().length == 0) {
		$("#loginpwd_notice").html("ange ditt lösenord!");//请输入密码	
		return false;
	}
	var randval = $("#imgcode").val();
	if (randval.trim().length == 0) {
		$("#imgcode_notice").html('ange verifieringskoden!');//请输入验证码
		return false;
	}
	$("#submitLogin").attr('disabled', true);
	$.ajax({
		type : "post",
		cache : false,
		dataType : "json",
		url : "${ctx}/front/login",
		data : {
			"loginname" : $("#loginname").val(),
			"loginpwd" : $("#loginpwd").val(),
			"imgcode" : $("#imgcode").val()
		},
		success : function(json) {
			var mark = json.retCode;
			if (mark == 0) {
				var url = window.location.href;
				if(url.indexOf("toLogin") != -1){
					window.location.href = '${ctx}/home';
				}else{
					window.location.reload();
				}
			} else {
				var tip = json.retMsg.split(":");
				if(tip.length>1){
					$("#"+tip[0]+"_notice").html(tip[1]);
				}else{
					$("#loginpwd_notice").html("用户登录密码错误，请重新输入！");
				}
				$("#submitLogin").attr('disabled', false);
				getRandImg();
			}
		},
		error : function() {
			$("#submitLogin").attr('disabled', false);
			getRandImg();
		}

	});
});
function getRandImg(){
	$('#randCodeImage').attr('src', "${ctx}/sys/randCodeImage?"+Math.random());
}
document.onkeydown=function(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		$("#submitLogin").trigger("click");
	}
}
$(function(){
	$("#randCodeImage").click(getRandImg);
	$("#loginname").focus(function(){
		$("#loginname_notice").html("");
	});
	$("#loginpwd").focus(function(){
		$("#loginpwd_notice").html("");
	});
	$("#imgcode").focus(function(){
		$("#imgcode_notice").html("");
	});
	
});
</script>

