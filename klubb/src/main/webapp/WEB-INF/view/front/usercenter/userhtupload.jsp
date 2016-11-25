<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no,email=no">
<title>用户中心-happytimes上传</title>
<script src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
<script src="${ctx}/front-ui/js/ui.js"></script>
<script type="text/javascript" src="${ctx}/front-ui/js/ands-popAlert.js"></script>
<script type="text/javascript" src="${ctx }/js/ajaxfileupload.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/ands-popAlert.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header>
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header>
	<!--内容 start-->
	<div class="main_body" style="margin-top:110px;">
		<div class="us-set mgt-30 clearfix">
			<!--us-set-lf start-->
			<div class="us-set-lf fl">
				<div class="us-set-top">
					<dl class="info clearfix">
						<dd>
							<h3 class="nic">
								用户名 ： <a href="">成成成</a>
							</h3>
						</dd>
						<dd>
							<h3 class="num">绑定手机号：13700012130</h3>
						</dd>
					</dl>
				</div>
				<ul class="us-menu mgt-25">
					<li><a href="#none" class="link  clearfix"> <i
							class="icon fl diyi"></i>
							<h5 class="name fl">信息管理</h5> </a></li>
					<li><a href="#none" class="link  clearfix"> <i
							class="icon fl diliu"></i>
							<h5 class="name fl">活动管理</h5> </a></li>
					<li><a href="#none" class="link curr clearfix"> <i
							class="icon fl disan"></i>
							<h5 class="name fl">happytimes</h5> </a></li>
					<li><a href="#none" class="link clearfix"> <i
							class="icon fl disi"></i>
							<h5 class="name fl">参赛管理</h5> </a></li>
				</ul>
			</div>
			<!--us-set-lf end-->
			<!--us-set-rt start-->
			<div class="us-set-rt fl"
				style="padding-left:10px; position:relative">
				<input name="" class="contbtn" value="<返回列表" type="button"
					style=" position:absolute; right:40px; top:40px">
				<div class="xmfb_title"
					style="width:200px;margin:10px auto 30px auto">
					<h2>HappyTimes</h2>
				</div>

				<div class="xmfb_xx"></div>

				<!--上传图片 start-->
				<div class="us-bd-base xmfb_con_text">
					<form enctype="multipart/form-data" id="pictureFrom">
					<dl class="us-info-dl clearfix" style="width:auto">
						<dt class="fl">上传图片：</dt>
						<dd class="fl upload_wrap">
							<div class="localUpload_wrap" id="uploadPic">
								<div class="localTitle">上传电脑中图片</div>
								<div class="localUpload">
									<input type="hidden" name="picture.URL" id="imgPath" class="ued-text-2" maxlength="30" >
									<input id="imgForUpload" name="imgForUpload" multiple="multiple" type="file">
								</div>
							</div>
							<div class="localUpload_wrap imgsc" id="showPic" style="display: none">
								<img id="showImg" src="">
							</div>
						</dd>
					</dl>
					<dl class="us-info-dl clearfix" style="width:auto">
						<dt class="fl">
							<span class="rose">*</span>图片描述：
						</dt>
						<dd class="fl">
							<textarea name="picture.DESCRIPTION" cols="" rows="3" style="width:540px"></textarea>
						</dd>
						<dd class="notice"></dd>
					</dl>
					<dl class="us-info-dl clearfix" style="width:auto">
						<dt class="fl">&nbsp;</dt>
						<dd class="fl">
							<div class="us-btn" style=" margin-left:160px">确定</div>
						</dd>
					</dl>
					</form>
				</div>
				<!--上传图片 end-->

			</div>
			<!--us-set-rt end-->

		</div>
		<div class="clearfix"></div>
	</div>

	<!--内容 end-->

	<!--bottom S-->
	<%@ include file="/ninclude/frontMember/footer.jsp"%>
	<!--bottom E-->
</body>
<script type="text/javascript">
$(function(){
	initUpload();
});

//图片相关
function initUpload(){
	//图片上传
	$("#imgForUpload").live("change", function(){
		$.ajaxFileUpload({
		    url : '${ctx}/upload/imgUpload',
		    secureuri:false,
		    fileElementId:'imgForUpload',//file标签的id
		    dataType: 'json',//返回数据的类型
		    data:{},//一同上传的数据
		    success: function (data) {
		    	var obj = jQuery.parseJSON(data);
		    	$("#imgPath").val(obj.fileName);
		    	$("#showImg").attr("src", "${uploadUrl}" + obj.fileName);
		    	$("#showPic").show();
		    	$("#uploadPic").hide();
		    },
		    error: function (data, status, e) {
		        alert(e);
		    }
		});
	});
}
//验证数据
function validData(){
	return true;
}
//保存
function update(status){
	if(validData()){
		$.ajax({
			type : "POST",
			url : "${ctx}/back/activity/saveOrUpdate",
			dataType : "json",
			data : $("#activityForm").serialize(),
			success: function(data){
				if(data.rsFlag){
					pop.success(data.rsMsg, function(){
						back();
					});
				}else{
					showNotice(data);
				}
			}
		});
	}
}
//显示提示信息
function showNotice(data){
	$(".color-3").each(function(){
		var tip = eval("data." + this.id);
		if(tip != null && tip != "" && tip != undefined && tip != "undefined"){
			$(this).html(tip);
		}else{
			$(this).html("");
		}
	});
}
</script>
</html>

