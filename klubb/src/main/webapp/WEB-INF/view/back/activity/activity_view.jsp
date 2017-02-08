<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
    
    <script  type="text/javascript" src="${ctx }/js/ueditor/ueditor.config.js"></script>
    <script  type="text/javascript" src="${ctx }/js/ueditor/ueditor.all.min.js"></script>
    <script  type="text/javascript" src="${ctx }/js/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script  type="text/javascript" src="${ctx }/js/ajaxfileupload.js"></script>
</head>

<body>
	<!--面包屑  s-->
	<div class="ued-location mgb-20">我的位置：活动修改</div>
	<!--面包屑  d-->
	<div class="ued-tab js_tab">
		<div class="ued-tab-tit clearfix js_tab_tit">
	        <ul class="ued-tab-1 ued-tab-2 fl clearfix">
	        	<li><a href="${ctx}/back/activity">活动查询</a></li>
	            <li class="on1"><a href="javascript:void(0)">活动信息</a></li>
	        </ul>
	    </div>
		    <div class="ued-tab-con">	
		        <div class="box-n on1">
		            <h4 class="ued-title-3 mgt-10">基本信息</h4>
		            <div class="ued-pannel">
		            	<table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor">
		                    <colgroup><col width="135"><col><col width="135"><col></colgroup>
		                    <tbody>
				            	<tr>
		                            <th><font color="color-3">*&nbsp;</font>活动名称：</th>
		                            <td>
		                                ${act.TITLE}
		                                <p class="color-3 fs-14" id="title_msg"></p>            
		                            </td>
		                            <th><font color="color-3">*&nbsp;</font>活动时间：</th>
		                            <td>
		                            	<div class="ued-time fl mgl-10">
		                            		<fmt:formatDate value="${act.actTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
		                            	</div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th>图片预览：</th>
		                            <td>
		                            	<img id="showImg" src="${uploadUrl}${act.IMG}" path="${act.IMG}" style="width:130px; height:100px;"/>
		                            </td>
		                            <th></th>
		                            <td></td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>活动摘要：</th>
		                            <td colspan="4">
		                                ${act.ABSTRACT}          
		                            </td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		            <div class="ued-pannel">
		            	<div style="margin-left: 10px">
    						${act.CONTENT}
    					</div>
		            </div>
		            <div class="ued-tab js_tab">
					    <div class="ued-tab-tit clearfix js_tab_tit">
					        <div class="ued-pack fr" id="ued-pack">收起查询条件</div>
					        <ul class="ued-tab-1 fl clearfix">
					        	<li class="liQuery on1"><a class="ued-see" href="javascript:void(0)">报名人员查询</a></li>
					        </ul>
					    </div>
					    <div class="ued-tab-con">
					        <div class="box-n on1">
					        	<div id="ued-packBox">
					            	<form enctype="multipart/form-data" id="qryForm">
					                <table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor mgt-15">
					                    <colgroup>
					                    	<col width="15%"><col width="35%">
					                    	<col width="15%"><col>
					                    </colgroup>
					                    <tbody>
					                        <tr>
					                            <th>姓名：</th>
					                            <td>
					                            	<input id="titleIn" type="text" name="userName" class="ued-text-2" maxlength="30"/>
					                            </td>
					                        </tr>
					                    </tbody>
					                </table>
					                <input id="actID" name="actID" type="hidden" value="${act.ID}"/>
					                <input id="pageNumIn" name="pageNum" type="hidden" value="1"/>
					                <input id="pageSizeIn" name="pageSize" type="hidden" value="6"/>
					                </form>
					                <div class="mgt-25 tc">
					                	<button class="ued-button-2 mgr-25" onclick="qryUser(1)">查询</button>
					                	<button class="ued-button-3" onclick="reset()">重置</button>
					                </div>
					            </div>
					            <div id="showLst"></div>
					        </div>
					    </div>
					</div>
		            <div class="mgt-25 tc"><button class="ued-button-3" onclick="back()">返回</button></div>
		        </div>
		    </div>
	</div>
</body>
<script type="text/javascript">
var rootContext = '${ctx}';
//qryUser
function qryUser(pageNum){
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/activity/getActUser",
		data: $("#qryForm").serialize(),
		dataType : "html",
		success : function(data){
			$('#showLst').html(data);
			return;
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示信息',
						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
						'ok':function(){back();},
						tag:'zq-ring'}
		              );
			return;
		}
	});
}
//翻页
function qry4Page(pageNum){
	qryUser(pageNum);
}
//取消
function cancleUser(userID){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/activity/cancleUser",
		data: {
			userID : userID
		},
		dataType : "html",
		success : function(data){
			if(data.rsFlag){
				qryUser();
			}else{
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示信息',
						text:'<div style=" font-size:18px; color:#ff0000;">'+data.rsMsg+'</div>',
						'ok':function(){back();},
						tag:'zq-ring'}
		              );
			}
			return
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示信息',
						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
						'ok':function(){back();},
						tag:'zq-ring'}
		              );
			return;
		}
	});
}

//返回
function back(){
	location.href = ctx+"/back/activity";
}

</script>
</html>
