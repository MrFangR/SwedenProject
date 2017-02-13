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
	<div class="ued-location mgb-20">我的位置：介绍编辑</div>
	<!--面包屑  d-->
	<div class="ued-tab js_tab">
		<div class="ued-tab-tit clearfix js_tab_tit">
	        <ul class="ued-tab-1 ued-tab-2 fl clearfix">
	        	<li><a href="${ctx}/back/introduce">介绍查询</a></li>
	            <li class="on1"><a href="javascript:void(0)">介绍信息</a></li>
	        </ul>
	    </div>
		    <div class="ued-tab-con">	
		        <div class="box-n on1">
		            <h4 class="ued-title-3 mgt-10">基本信息</h4>
		<form enctype="multipart/form-data" id="introduceForm">
		            
		            <h4 class="ued-title-3 mgt-10">主要内容</h4>
		            <p class="color-3 fs-14" id="content_msg"></p>
		            <div class="ued-pannel">
		            	<div style="margin-left: 10px">
    						<script id="editor" type="text/plain" style="width:98%;height:500px;"></script>
    					</div>
		            </div>
		            
		            <input type="hidden" name="introduce.ID" value="${introduce.ID }" />
					<input type="hidden" id="CONTENT" name="introduce.CONTENT" value=""/>
					<input type="hidden" id="type" name="type" value=""/>
   		</form>
					<div id="contentStr" style="visibility: hidden;">${introduce.CONTENT }</div>
		            <div class="mgt-25 tc"><button class="ued-button-2 mgr-25"  onclick="update(1)">保存</button><button class="ued-button-2 mgr-25"  onclick="update(2)">发布</button><button class="ued-button-3" onclick="back()">返回</button></div>
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
			url : "${ctx}/back/introduce/saveOrUpdate",
			dataType : "json",
			data : $("#introduceForm").serialize(),
			success: function(data){
				if(data.rsFlag){
                    ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                        {type:2,
                            info:'介绍管理',
                            text:'<div style=" font-size:18px; color:#ff0000;"> '+data.rsMsg+' </div>',
                            'ok':function(){
                                back();
                            },
                            tag:'zq-ring'}
                    );
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
	location.href = ctx+"/back/introduce";
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
