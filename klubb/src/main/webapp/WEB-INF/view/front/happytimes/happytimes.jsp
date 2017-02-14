<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no,email=no">
<title><i18n:get key="portal.menu.happytimes"></i18n:get></title>
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
			<input name="title" id="title" type="text" class="inputfont" value="">
			<input name="" type="button" onclick="showHappyTimes(1)" class="inputbut" value="<i18n:get key='portal.activity.search.button'></i18n:get>">
			<input id="pageSizeIn" name="pageSize" type="hidden" value="12"/>
		</p>
	</div>
	<!--ist-con S-->
	<div class="list-con">
		<div class="list-contitle"><i18n:get key="portal.menu.happytimes"></i18n:get></div>
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
	document.onkeydown = function(e){
        if(!e) e = window.event;
        if((e.keyCode || e.which) == 13){
        	$(".inputbut").click();
        }
    }
});
function showHappyTimes(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/front/happytimes/showHappy",
		data: {
			title : $('#title').val(),
			pageNum : pageNum,
			pageSize : $('#pageSizeIn').val()
		},
		dataType : "json",
		success : function(data){
			var htmlStr = "";
			var dateStrPre = "";
			var dateStrNext = "";
			$.each(data.page.list, function(i, pic){
				var date = new Date(pic.CREATE_TIME);
				var month = date.getMonth()+1;
				dateStrNext = FormatDate(pic.CREATE_TIME);
				if(dateStrPre != dateStrNext){
				dateStrPre = FormatDate(pic.CREATE_TIME);
				htmlStr += "<div class='clearfix'></div>"
						+ "<div class='riqi'>"
						+ "<p class='date'>"+date.getDate()+"</p>"
						+ "<p class='month'>"+month+"月</p>"
						+ "<p class='Category'><i18n:get key='portal.menu.happytimes'></i18n:get></p>"
						+ "</div>"
				}
				htmlStr += "<li class='listbox mr20'>"
						+ "		<div class='listboximg'>"
						+ "			<a href='"+ctx+"/front/happytimes/showHTdetails?picID="+pic.ID+"' target='_blank'><img src='"+uploadUrl+pic.URL+"' class='attachment-thumbnail wp-post-image'></a>"
						+ "		</div>"
						+ "		<div class='listinfo'>"
						+ "			<div class='listtitle'>"
						+ "				<a href=''#none'  target='_blank'>"+pic.DESCRIPTION+"</a>"	
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
function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getDate()+"/"+(date.getMonth()+1)+"/"+date.getFullYear();
}
</script>
</html>

