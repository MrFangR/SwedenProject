<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no,email=no">
<title>HappyTimes</title>
<script src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
<script src="${ctx}/front-ui/js/ui.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header>
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header>

	<div class="search">
		<p class="w1000">
			<input name="" type="text" class="inputfont" value="">
			<input name="" type="button" class="inputbut" value="搜索">
			<input id="pageSizeIn" name="pageSize" type="hidden" value="12"/>
		</p>
	</div>
	<!--ist-con S-->
	<div class="list-con">
		<div class="list-contitle">HappyTimes</div>
		<ul id="showHTDiv">
		</ul>
		<!--分页 start-->
		<div class="paging clearfix" id="pageDiv"></div>
		<!--分页 end-->
		<div class="clearfix"></div>

	</div>
	<!--ist-con E-->


	<!--bottom S-->
	<%@ include file="/ninclude/frontMember/footer.jsp"%>
	<!--bottom E-->
</body>
<script type="text/javascript">
$(function(){
	showHappyTimes(1);
	
});
function showHappyTimes(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/front/happytimes/showHappy",
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
				htmlStr += "<li class='listbox mr20'>"
						+ "		<div class='listboximg'>"
						+ "			<a href='"+ctx+"/front/happytimes/showHTdetails?picID="+pic.ID+"' target='_blank'><img src='"+uploadUrl+pic.url+"' class='attachment-thumbnail wp-post-image'></a>"
						+ "		</div>"
						+ "		<div class='listinfo'>"
						+ "			<div class='listtitle'>"
						+ "			</div>"
						+ "			<div class='listdate'>"+dateStrNext+"</div>"
						+ "		</div>"
						+ "</li>"
			});
			$("#showHTDiv").html(htmlStr);
				
			//设置分页
			setPageInfo("pageDiv", data.page, showHappyTimes);
		},
	});

}
</script>
</html>

