<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no,email=no">
<title>活动管理</title>
<script src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
<script src="${ctx}/front-ui/js/ui.js"></script>
<script type="text/javascript" src="${ctx}/front-ui/js/ands-popAlert.js"></script>
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
			<div class="us-set-rt fl" style="padding-left:10px; position:relative">
				<input name="uploadIMG" class="contbtn" value="+添加图片" type="button" style=" position:absolute; right:40px; top:40px">
				<div class="xmfb_title" style="width:200px;margin:10px auto 30px auto">
					<h2>HappyTimes</h2>
				</div>

				<div class="xmfb_xx"></div>

				<!--ist-con S-->
				<div class="list-con list-condel">
					<ul  id="showHTDiv">
					</ul>
					<!--happytimes 备注图片用li分割， 如果加日期要加日期分页符-->
					<!--分页 start-->
					<input id="pageSizeIn" name="pageSize" type="hidden" value="12"/>
					<div class="paging clearfix" id="pageDiv"></div>
					<!--分页 end-->
					<div class="clearfix"></div>

				</div>
				<!--ist-con E-->


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
	$(".contbtn").click(function(){
		location.href=ctx + "/userCenter/toHappytimesUpload";
	});

	showHappyTimes(1);
});
function showHappyTimes(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/userCenter/showUserHappy",
		data: {
			pageNum : pageNum,
			pageSize : $('#pageSizeIn').val()
		},
		dataType : "json",
		success : function(data){
			var htmlStr = "";
			var dateStrPre = "";
			var dateStrNext = "";
			$.each(data.page.list, function(i, pic){
				dateStrNext = pic.CREATE_TIME.substr(0,10);
				if(dateStrPre != dateStrNext){
				dateStrPre = pic.CREATE_TIME.substr(0,10);
				htmlStr += "<div class='clearfix'></div>"
						+ "<div class='riqi'>"
						+ "<p class='date'>"+dateStrNext.substr(8,2)+"</p>"
						+ "<p class='month'>"+dateStrNext.substr(5,2)+"月</p>"
						+ "<p class='Category'>happytimes</p>"
						+ "</div>"
				}
				htmlStr += "<li class='listbox'>"
						+ "		<div class='listboximg'>"
						+ "			<a href='"+ctx+"/front/happytimes/showHTdetails?picID="+pic.ID+"' target='_blank'><img src='"+uploadUrl+pic.URL+"' class='attachment-thumbnail wp-post-image'></a>"
						+ "		</div>"
						+ "		<div class='listinfo'>"
						+ "			<div class='listtitle'>"
						+ "				<a href='#none' target='_blank'>"+pic.DESCRIPTION+"</a>"
						+ "			</div>"
						+ "			<div class='listdate'>"+dateStrNext+"</div>"
						+ "		</div>"
						+ "</li>";
			});
			$("#showHTDiv").html(htmlStr);
				
			//设置分页
			setPageInfo("pageDiv", data.page, showHappyTimes);
		},
	});
}
</script>
</html>