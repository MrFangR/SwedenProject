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
	<div class="ued-location mgb-20">我的位置：活动添加</div>
	<!--面包屑  d-->
	<div class="ued-tab js_tab">
		<div class="ued-tab-tit clearfix js_tab_tit">
	        <ul class="ued-tab-1 ued-tab-2 fl clearfix">
	        	<li><a href="${ctx}/back/activity">活动查询</a></li>
	            <li class="on1"><a href="javascript:void(0)">介绍信息</a></li>
	        </ul>
	    </div>
		    <div class="ued-tab-con">	
		        <div class="box-n on1">
		            <h4 class="ued-title-3 mgt-10">基本信息</h4>
					<form enctype="multipart/form-data" id="activityForm">
		            
		            <h4 class="ued-title-3 mgt-10">主要内容</h4>
                    <p class="color-3 fs-14" id="content_msg"></p>
		            <div class="ued-pannel">
		            	<table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor">
		                    <colgroup><col width="135"><col><col width="135"><col></colgroup>
		                    <tbody>
				            	<tr>
		                            <th><font color="color-3">*&nbsp;</font>活动名称：</th>
		                            <td>
		                                <input type="text" name="activity.TITLE" value="" class="ued-text-2" maxlength="30">
		                                <p class="color-3 fs-14" id="title_msg"></p>            
		                            </td>
		                            <th><font color="color-3">*&nbsp;</font>活动时间：</th>
		                            <td>
		                            	<div class="ued-time fl mgl-10">
		                            		<input type="text" name="activity.ACT_TIME" class="Wdate ued-text-2" onClick="WdatePicker()" maxlength="30"/>
		                            		<p class="color-3 fs-14" id="act_time_msg"></p>  
		                            	</div>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>图片：</th>
		                            <td>
		                                 <input type="hidden" name="activity.IMG" id="imgPath" class="ued-text-2" maxlength="30" >
		                                 <input id="imgForUpload" name="imgForUpload" type="file" multiple="multiple">
		                                 <p class="color-3 fs-14" id="img_path_msg"></p>  
		                            </td>
		                            <th>图片预览：</th>
		                            <td><img id="showImg" alt="" src=""></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		            <div class="ued-pannel">
		            	<div style="margin-left: 10px">
    						<script id="editor" type="text/plain" style="width:98%;height:500px;"></script>
    					</div>
		            </div>
		            
		            <input type="hidden" name="activity.ID" value="${activity.ID }" />
					<input type="hidden" id="CONTENT" name="activity.CONTENT" value=""/>
   					<input type="hidden" id="type" name="type" value=""/>
   					</form>
					<div id="contentStr" style="visibility: hidden;">${activity.CONTENT }</div>
		            <div class="mgt-25 tc"><button class="ued-button-2 mgr-25"  onclick="update(3)">保存</button><button class="ued-button-2 mgr-25"  onclick="update(4)">发布</button><button class="ued-button-3" onclick="back()">返回</button></div>
		        </div>
		    </div>
	</div>
</body>
<script type="text/javascript">
var rootContext = '${ctx}';
$(function(){
	var ueditor = UE.getEditor('editor');
	ueditor.ready(function() {
		ueditor.setContent($("#contentStr").html());
	});

	initUpload();
});

//保存
function update(status){
	$("#type").val(status);
	//设置文章
	$("#CONTENT").val(UE.getEditor('editor').getContent());
	
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

//验证数据
function validData(){
	return true;
}

//返回
function back(){
	location.href = ctx+"/back/activity/init";
}

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
		    },
		    error: function (data, status, e) {
		        alert(e);
		    }
		});
	});
}
</script>
</html>
