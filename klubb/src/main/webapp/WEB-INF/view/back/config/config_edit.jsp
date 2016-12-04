<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
    
    <link type="text/css"  href="${ctx}/css/map.css" rel="stylesheet" />
    <link type="text/css"  href="${ctx}/front-ui/css/front-style.css" rel="stylesheet" />
</head>

<body>
	<!--面包屑  s-->
	<div class="ued-location mgb-20">我的位置：台球厅配置</div>
	<!--面包屑  d-->
	<div class="ued-tab js_tab">
		<div class="ued-tab-tit clearfix js_tab_tit">
	        <ul class="ued-tab-1 fl clearfix">
	        	<li class="on1"><a class="ued-see" href="${ctx}/back/config">详情</a></li>
	        </ul>
	    </div>
		    <div class="ued-tab-con">	
		        <div class="box-n on1">
		        <div id="ued-packBox">
				<form enctype="multipart/form-data" id="configForm">
		            <h4 class="ued-title-3 mgt-10">基本信息</h4>
		            <div class="ued-pannel">
		                <table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor">
		                    <colgroup><col width="135"><col><col width="135"><col></colgroup>
		                    <tbody>
		                    	<tr>
		                            <th><font color="color-3">*&nbsp;</font>联系电话：</th>
		                            <td colspan="3">
		                                 <input type="text"  id="address" name="config.PHONE"  class="ued-text-2" maxlength="100"  value="${config.PHONE }"  style="width: 560px">
		                            </td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>详细地址：</th>
		                            <td colspan="3">
		                                 <input type="text"  id="address" name="config.ADDRESS"  class="ued-text-2" maxlength="100"  value="${config.ADDRESS }"  style="width: 560px">
		                            </td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>营业时间：</th>
		                            <td colspan="3">
		                            	<textarea rows="5" cols="80" class="bord-3" name="config.BUSINESS_TIME" style="color: #535356;padding-left: 10px;font-family: 'microsoft yahei';">${config.businessTime }</textarea>  
		                                 <p class="color-3 fs-14" id="business_time_msg"></p>  
		                            </td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
   				</form>
				<div class="mgt-25 tc">
	            	<button class="ued-button-3" onclick="save()">保存</button>
	            </div>
	            </div>
	        </div>
	    </div>
	</div>

</body>
<script type="text/javascript">
var rootContext = '${ctx}';
$(function(){
});

//保存
function save(){
	if(validData()){
		$.ajax({
			type : "POST",
			url : "${ctx}/back/config/saveOrUpdate",
			dataType : "json",
			data : $("#configForm").serialize(),
			success: function(data){
				if(data.rsFlag){
					pop.success(data.rsMsg, function(){});
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

</script>
</html>
