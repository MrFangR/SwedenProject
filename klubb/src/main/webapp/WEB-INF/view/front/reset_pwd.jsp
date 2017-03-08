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
<title><i18n:get key="portal.user.forget"></i18n:get></title>
<script src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
<script src="${ctx }/front-ui/js/ui.js"></script>
<script src="${ctx }/js/jST.v0.1.4.min.js"></script>
<script type="text/javascript">

document.onkeydown=function(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		subPwd();
	}
}

$(function(){
	var retCode = '${retInfo.retCode}';
	if(retCode != 0){
		ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
		   {type:2,
			info:'忘记密码',
			text:'<div style=" font-size:18px; color:#ff0000;"> ${retInfo.retMsg}</div>',
			'ok':function(){window.location.href = '${ctx}/front/toForget';},
			tag:'cw-ring'}
              );
		
	}else{
		$("#subPwd").click(subPwd);
	}
	
	$("#new_pwd").focus(function(){
		$("#new_pwd_notice").html("");
		$("#new_pwd").removeClass("btn-error");
	});
	$("#re_new_pwd").focus(function(){
		$("#renew_notice").html("");
		$("#re_new_pwd").removeClass("btn-error");
	});
});

function subPwd() {
	var pwd = $("#new_pwd").val();
	if(pwd.trim().length==0){
		$("#new_pwd_notice").html("密码不能为空！");
		$("#new_pwd").addClass("btn-error");
		$("#subPwd").bind("click",subPwd);
		return false;
	}
	var repwd = $("#re_new_pwd").val();
	if(repwd.trim().length==0){
		$("#renew_notice").html("确认密码不能为空！");
		$("#re_new_pwd").addClass("btn-error");
		$("#subPwd").bind("click",subPwd);
		return false;
	}else if(pwd!=repwd){
		$("#repwd_notice").html("Lösenorden stämmer inte!");//两次密码不一致,请重新输入!	
		$("#re_new_pwd").addClass("btn-error");
		$("#subPwd").bind("click",subPwd);
		return false;
	}
	$.ajax({
		type : "post",
		cache : false,
		dataType : "json",
		url : "${ctx}/front/modifyPwd",
		data : {
			"pwd" : $("#new_pwd").val(),
			"email" : $("#hiddenEmail").val()
		},
		success : function(json) {
			var mark = json.retCode;
			if (mark == 0) {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'忘记密码',
					text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
					'ok':function(){window.location.href = '${ctx}/front/toLogin';},
					tag:'zq-ring'}
	               );
			} else {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'忘记密码',
					text:'<div style=" font-size:18px; color:#ff0000;">Det gick inte att ändra lösenordet.</div>',//修改失败 
					'ok':function(){window.location.href = '${ctx}/front/toForget';},
					tag:'cw-ring'}
	               );
			}
		},
		error : function() {
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'忘记密码',
				text:'<div style=" font-size:18px; color:#ff0000;">Det gick inte att ändra lösenordet.</div>',//修改失败 
				'ok':function(){window.location.href = '${ctx}/front/toForget';},
				tag:'cw-ring'}
               );
			return;
		}
	});
}

</script>
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
	<div class="cont-con" >
		<!--内容 start-->
		<div class="main_body xmfb_con" >
			<div class="xmfb_title">
				<h2 style="margin-left:60px;"><i18n:get key="portal.user.forget.reset"></i18n:get></h2>
			</div>
			<div class="xmfb_xx"></div>
			
			<div class="us-bd-base xmfb_con_text">
			<c:if test="${retInfo.retCode==0 }">
				<input type="hidden" value="${email }" id="hiddenEmail"/>
				<dl class="us-info-dl clearfix">
					<dt class="fl">
						<span class="rose">*</span><i18n:get key="portal.user.forget.newpwd"></i18n:get>：
					</dt>
					<dd class="fl">
						<input type="password" id="new_pwd"/>
					</dd>
					<dd class="notice" id="new_notice"></dd>
				</dl>
				<dl class="us-info-dl clearfix">
					<dt class="fl">
						<span class="rose">*</span><i18n:get key="portal.regist.repassword"></i18n:get>：
					</dt>
					<dd class="fl">
						<input type="password" id="re_new_pwd"/>
					</dd>
					<dd class="notice" id="renew_notice"></dd>
				</dl>

				<dl class="us-info-dl clearfix">
					<dt class="fl">&nbsp;</dt>
					<dd class="fl">
						<div class="us-btn" id="subPwd"><i18n:get key="portal.contact.form.submit"></i18n:get></div>
					</dd>
				</dl>

				<div class="clearfix"></div>
			</c:if>
			</div>
		</div>
		<!--内容 end-->
	</div>
	<!--cont-con E-->
	<!--bottom S-->
	<%@ include file="/ninclude/frontMember/footer.jsp"%>
	<!--bottom E-->
</body>
</html>

