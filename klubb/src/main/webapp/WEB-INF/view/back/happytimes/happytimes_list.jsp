<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：HappyTimes管理</div>
	<input id="pageNum" name="pageNum" type="hidden" value="1"/>
	<!--list-con S-->		
  	<div class="list-con list-condel" id="showLst">
  	</div>
</body>
	<script type="text/javascript" src="${ctx}/back-ui/local-ui/backHappytimes.js"></script>
</html>

<script type="text/javascript">
$(function(){
	//删除happytimes相片	
	
	$(".list-condel	ul li").live("mouseenter",function(){
		 $(this).append("<div class='list-del'><i class='delico'></i>删除相片</div>");
		
		});
	$(".list-condel	ul li").live("mouseleave ",function(){
		 $(this).find(".list-del").remove();
		
		});
	$(".list-condel	ul li").find(".list-del").live("click",function(){
		var picId = $(this).parents(".listbox").attr("id");
		
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/happytimes/delete",
			data: {"picId" : picId},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					qry(1);
				}
				alert(json.msg);
				return;
			},
			error : function(){
				pop.fail("系统异常，请稍后重试");
				return;
			}
		});
	});
});
</script>