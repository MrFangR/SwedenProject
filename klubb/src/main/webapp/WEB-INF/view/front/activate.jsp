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
<title><i18n:get key="portal.user.activate"></i18n:get></title>
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
			<div class="xmfb_title" style="width:200px;">
				<h2><i18n:get key="portal.user.activate"></i18n:get></h2>
			</div>
			<div class="xmfb_xx"></div>

			<div class="us-bd-base xmfb_con_text">

				<c:if test="${retInfo.retCode==0 }">
					<div class=" checkstand-result-con">
						<div class="icon-succeed icon-succeed-m"><i class="correct-icon"></i></div>
						<div class="float-right result-right pdt-10">
							<p class="succeed-title font-24 font-YaHei mgb-10">恭喜您，注册激活成功！</p>
							<p class="line-th25 pdt-10">点击 <a href="${ctx }/front/toLogin" class="font-blue">跳转到登录页面</a> </p>
						</div>
					</div>
				</c:if>
				<c:if test="${retInfo.retCode==1 }">
					<div class=" checkstand-result-con">
						<div class="icon-succeed icon-succeed-m"><i class="correct-icon"></i></div>
						<div class="float-right result-right pdt-10">
							<p class="succeed-title font-24 font-YaHei font-orange">对不起，注册激活失败！</p>
							<p class="font-14 font-YaHei pdt-10">请与<span class="font-ora2">：klubb管理员</span>联系</p>
						</div>
					</div>
				</c:if>
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
		$("#loginname_notice").html("请输入邮箱！");
		return false;
	}
	if (password.trim().length == 0) {
		$("#loginpwd_notice").html("请输入密码！");
		return false;
	}
	var randval = $("#imgcode").val();
	if (randval.trim().length == 0) {
		$("#imgcode_notice").html('请输入验证码！');
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

