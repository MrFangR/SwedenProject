<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>精简开店后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
    
    <link type="text/css"  href="${ctx}/css/map.css" rel="stylesheet" />
    <link type="text/css"  href="${ctx}/front-ui/css/front-style.css" rel="stylesheet" />
    <script  type="text/javascript" src="${ctx }/js/ajaxfileupload.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCGc_7PkgL6eHUH6VL1NGs2Pkpr8gz6hiU&libraries=places&callback=initMap" async defer></script>
	<script type="text/javascript" src="${ctx }/back-ui/local-ui/map.js"></script>
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
		                            <th><font color="color-3">*&nbsp;</font>营业时间：</th>
		                            <td colspan="3">
		                                 <input type="text" name="config.businessTime"  class="ued-text-2" maxlength="30"  value="${config.businessTime }" style="width: 500px;">     
		                                 <p class="color-3 fs-14" id="config_business_time_msg"></p>  
		                            </td>
		                        </tr>         
		                    </tbody>
		                </table>
		            </div>
		            <h4 class="ued-title-3 mgt-10">地址信息</h4>
		            <div class="ued-pannel">
		            	<table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor">
		                    <colgroup><col width="135"><col><col width="135"><col></colgroup>
		                    <tbody>
		                        <tr>
		                            <th>详细地址：</th>
		                            <td colspan="3">
		                                 <input type="text"  id="address" name="config.ADDRESS"  class="ued-text-2" maxlength="30"  value="${config.ADDRESS }"  style="width: 500px">
		                            </td>
		                        </tr>
		                        </tbody>
		                </table>
		                <div style="width: 90%;margin: auto;border: 1px solid #ccc;margin-top: 10px;">
		                	<input id="pac-input" class="map-controls map-input" type="text" placeholder="输入台球厅名称">
			                <div id="allmap" style="width: 100%;height: 400px;"></div>
		                </div>
		                <input type="hidden" id="mapUrl" name="config.mapUrl" value="${config.mapUrl }">
		                <input type="hidden" id="placeId" name="config.placeId" value="${config.placeId }">
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
