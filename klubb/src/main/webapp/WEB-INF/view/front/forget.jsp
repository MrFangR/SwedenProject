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
<title>忘记密码</title>
<script src="${ctx }/front-ui/js/jquery1.9.0.min.js"></script>
<script src="${ctx }/front-ui/js/ui.js"></script>
<script src="${ctx }/js/jST.v0.1.4.min.js"></script>
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
			<div class="xmfb_title">
				<h2 style="margin-left:60px;">邮箱验证</h2>
			</div>
			<div class="xmfb_xx"></div>
			<div class="us-bd-base xmfb_con_text">

				<dl class="us-info-dl clearfix">
					<dt class="fl">
						<span class="rose">*</span>邮箱地址：
					</dt>
					<dd class="fl">
						<input type="text" id="email"/>
					</dd>
					<dd class="notice" id="email_notice"></dd>
				</dl>
				<dl class="us-info-dl clearfix">
					<dt class="fl">
						<span class="rose">*</span>验证码：
					</dt>
					<dd class="fl">
						<input type="text" id="imgcode" name="imgcode" maxlength="4"
							class="ued-input fl" style="width:100px;" /> <img
							id="randCodeImage" class="mgl-10" style="height: 40px;"
							src="${ctx}/front/randCodeImage" />
					</dd>
					<dd class="notice" id="imgcode_notice"></dd>
				</dl>

				<dl class="us-info-dl clearfix">
					<dt class="fl">&nbsp;</dt>
					<dd class="fl">
						<div class="us-btn" id="nextStep">下一步</div>
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
</body>
</html>
<script type="text/javascript">
	getRandImg();
	function getRandImg() {
		$('#randCodeImage').attr('src',
				"${ctx}/sys/randCodeImage?" + Math.random());
	}
	function stepNext() {
		var email = $("#email").val();
		if (email.trim().length == 0) {
			$("#email_notice").html("邮箱不能为空！");
			return false;
		} else if (!jST.isEmail(email)) {
			$("#email_notice").html("请输入全法邮箱地址！");
			return false;
		}
		$.ajax({
			type : "post",
			cache : false,
			dataType : "json",
			url : "${ctx}/front/sendEmail",
			data : {
				"email" : $("#email").val(),
				"imgcode" : $("#imgcode").val()
			},
			success : function(json) {
				var mark = json.retCode;
				if (mark == 0) {
					//alert(json.retMsg);
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'忘记密码',
						text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
						'ok':function(){},
						tag:'zq-ring'}
		               );
				} else {
					//alert(json.retMsg);
					
					var tip = json.retMsg.split(":");
					if(tip.length>1){
						$("#"+tip[0]+"_notice").html(tip[1]);
					}else{
						ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
						   {type:2,
							info:'忘记密码',
							text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
							'ok':function(){window.location.href = '${ctx}/front/toRegist';},
							tag:'cw-ring'}
			               );
					}
				}
			},
			error : function() {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'忘记密码',
					text:'<div style=" font-size:18px; color:#ff0000;"> 修改失败 </div>',
					'ok':function(){window.location.href = '${ctx}/front/toForget';},
					tag:'cw-ring'}
	               );
				
			}
		});
	}
	$("#randCodeImage").click(getRandImg);
	$("#nextStep").click(stepNext);
</script>

