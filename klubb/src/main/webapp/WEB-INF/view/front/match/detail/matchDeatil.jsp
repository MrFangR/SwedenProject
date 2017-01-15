<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.activity.detail"></i18n:get></title>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
	<header >
		<%@include file="/ninclude/frontMember/header.jsp"%>
	</header >

  <div class="search">
       <p class="w1000">
          <input name="" type="text"  class="inputfont" value=""><input name="" type="button" onclick="searchMat(1)" class="inputbut" value="<i18n:get key='portal.activity.search.button'></i18n:get>">
       </p>
  </div>
<!--ist-con S-->		
	<div class="list-con clearfix" style=" background:none;">
		<div class="list-tab">
			<div class="list-title curr">比赛简介</div>
            <div class="list-title">对阵</div>
            <div class="list-title">排行榜</div>
            <div class="list-title">评价</div>
            <div class=" clearfix"></div>
		</div>
		<div class="listtabcon">
			<!--比赛介绍 S-->	
			<div class="tabsub">
				<!--cont-con S-->
					<div class="cont-con" style="margin-top:0px;">
						<h1 class="contitle">${match.NAME }</h1>
						<input type="hidden" id="introMatchId" value="${match.ID }">
						<p class="confutitle">
						<c:choose>
							<c:when test="${applyFlag==0 }">
								<input id="addMatch" name="addMatch" class="contbtn" value="+参加比赛" type="button">
							</c:when>
							<c:when test="${applyFlag==1 }">
								<input name="addMatch" class="contbtn" value="+已报名" type="button" disabled="disabled" style="background: #C8C8C8">
							</c:when>
							<c:when test="${applyFlag==2 }">
								<input name="addMatch" class="contbtn" value="+报名人数已满" type="button" disabled="disabled">
							</c:when>
						</c:choose>
						<span>时间：${match.startDate }</span><span class="mgl-200"></span></p>
                                       <p class="conline"></p>
                                       <div class="cont-text">
                                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${match.DESCRIPTION }
                                        </div>
                                        
                                         <table class="table-con">
                                                  <tr class="table-tr-even">
                                                    <th>报名顺序</th>
                                                    <th>参赛人员姓名</th>
                                                    <th>起始分</th>
                                                  </tr>
                                                  <c:forEach var="user" items="${userLst }">
                                                  	<tr>
	                                                    <td>${user.SEQ }</td>
	                                                    <td>${user.NAME }</td>
	                                                    <td>${user.startScore }</td>
	                                                  </tr>
                                                  </c:forEach>
                                                </table>
					</div>
				<!--cont-con E-->
			</div>
			<!--对阵 S-->	
            <div class="tabsub"   style="display:none; margin:0px;">
            	<!--第一tab  一列是320px 目前展示5列宽为1600px  如果对阵图列数超过3需要代码判断列数给 box-n div 输入宽度 s-->
                <div class="box-n on1" style="width:1600px;">
                	<!--第一大类  s-->
                    <div class="clearfix">
                    	<!--比赛标题  s-->
                        <div class="matchtitle">
                           <li>第一轮</li>
                           <li>第二轮</li>
                           <li>第三轮</li>
                           <li>半决赛</li>
                           <li>决赛</li>
                           <div class="clear"></div>
                        </div>
                        <!--比赛标题  e-->
                    </div>
                </div>
            </div>
            <!--对阵 E-->
            <!--排行榜  S-->	
            <div class="tabsub"   style="display:none; margin:0px; background:#fff; padding-top:40px; padding-bottom:40px;">
           		<table class="table-con">
           			<tr>
                      <th>排名</th>
                      <th>参与者名字</th>
                      <th>比赛历史</th>
                    </tr>
                    <c:forEach var="rink" items="${rinkList }">
	                    <tr class="table-tr-even">
	                      <td>${rink.seq }</td>
	                      <td>${rink.userName }</td>
	                      <td>
	                      	<c:forEach var="flag" items="${rink.matchFlag }">
	                      		<c:if test="${flag=='win' }">
	                      			<i class="win" title="胜利">胜利</i>
	                      		</c:if>
	                      		<c:if test="${flag=='loser' }">
	                      			<i class="fail" title="失败">失败</i>
	                      		</c:if>
	                      	</c:forEach>
	                      </td>
	                    </tr>
                    
                    </c:forEach>
           		</table>
           	</div>
           	<!--排行榜 E-->
           	<!--评论S-->
           	<div class="tabsub"   style="display:none; margin:0px;background:#fff">
           	<%@ include file="/ninclude/frontMember/evaluation.jsp"%>
			</div>
			<form enctype="multipart/form-data" action="" id="evaForm">
			  	<input type="hidden" value="${match.ID}" id="OBJ_ID" name="evaluation.OBJ_ID"/>
			   	<input type="hidden" value="3" id="OBJ_TYPE" name="evaluation.OBJ_TYPE"/>
			   	<input type="hidden" value="" id="CONTENT" name="evaluation.CONTENT"/>
			   	<input type="hidden" value="" id="P_ID" name="evaluation.P_ID"/>
			</form>
           	<!--评论E-->
		</div>
		
		
	</div>
<!--list-con E-->	
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
<script type="text/javascript">
$(function(){
	$("#addMatch").bind("click",function(){
		$("#addMatch").unbind("click");
		$.ajax({
			type:"post",
			url:"${ctx}/front/matchdetail/addMatch",
			data:{
				"matchId" : $("#introMatchId").val()
			},
			dataType : "json",
			success : function(json){
				var mark = json.retCode;
				if(mark==0){
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'registrera',//注册
						text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
						'ok':function(){window.location.href = '${ctx}/front/matchdetail';},
						tag:'zq-ring'}
		               );
				}else{
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'报名比赛',
						text:'<div style=" font-size:18px; color:#ff0000;"> '+json.retMsg+' </div>',
						'ok':function(){$("#addMatch").bind("click");;},
						tag:'cw-ring'}
		               );
				}
			},
			error:function(){
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'报名比赛',
					text:'<div style=" font-size:18px; color:#ff0000;"> 报名失败 </div>',
					'ok':function(){$("#addMatch").bind("click");;},
					tag:'cw-ring'}
	               );
			}
		});
	});
});
</script>
</html>

