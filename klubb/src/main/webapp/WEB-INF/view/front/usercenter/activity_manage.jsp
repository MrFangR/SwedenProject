<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>活动管理</title>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <script  type="text/javascript" src="${ctx}/front-ui/js/ands-popAlert.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/ands-popAlert.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
     <%@include file="/ninclude/frontMember/header.jsp"%>
  </header >

  
<!--内容 start-->
     <div class="main_body" style="margin-top:110px;">
          <div class="us-set mgt-30 clearfix">
          		<!--us-set-lf start-->
          			<%@include file="/ninclude/frontMember/memLeft.jsp"%>
           	 	<!--us-set-lf end-->
                 <!--us-set-rt start-->
          		<div class="us-set-rt fl">
                	 <!--活动列表start-->
                	 <input id="pageSizeIn" name="pageSize" type="hidden" value="3"/>
                	<div class="shopslist_con houseList shopsc" id="actListDiv">
                  	</div>
                        <!--活动列表end-->
                    
                
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
	showUserAct(1);
});
function showUserAct(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/userCenter/findActByUserId",
		data: {
			pageNum : pageNum,
			pageSize : $('#pageSizeIn').val()
		},
		dataType : "json",
		success : function(data){
			var htmlStr = "";
			$.each(data.list, function(i, act){
				htmlStr +="<dl style='display: block;'  class='list hiddenMap position-rel'>"
						+ "	<dt class='img position-rel fl'><a target='_blank' href='#none'><img src='"+uploadUrl+act.IMG+"' width='340' height='310'></a></dt>"
						+ "	<dd class='info  position-rel fr'>"
						+ "		<p class='title'><a target='_blank' href='#none'>"+act.TITLE+"</a></p>"
						+ "		<p class='gray6 mgt-12'>"+act.ABSTRACT+"</p>"
						+ "		<div class='moreInfo'><input name='cancleAct' onclick='cancleAct("+act.ID+")' class='contbtn' value='—取消报名' type='button'></div>"
						+ "	</dd>"
						+ "</dl>";
			});
			htmlStr +="<div class='clear'></div>"
					+ "<div class='paging clearfix' id='pageDiv'></div>";
			
			$("#actListDiv").html(htmlStr);
				
			//设置分页
			setPageInfo("pageDiv", data, showUserAct);
		},
	});

}
function cancleAct(actId){
	$.ajax({
		type : 'POST',
		url : ctx + "/userCenter/cancleAct",
		data: {
			actId : actId
		},
		dataType : "json",
		success : function(data){
			if(data.rsFlag){
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
						   {type:2,
							info:'取消成功',
							text:'<div style=" font-size:18px; color:#ff0000;">取消活动成功</div>您好，您已取消参加活动',
							'ok':function(){location.href=ctx + "/userCenter/toActMan";},
							tag:'cw-ring'}
			               );
				
			}
		},
	});
		
}
</script>
</html>

