<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
    
    <link type="text/css"  href="${ctx}/css/map.css" rel="stylesheet" />
    <link type="text/css"  href="${ctx}/front-ui/css/front-style.css" rel="stylesheet" />
</head>

<body>
	<!--面包屑  s-->
	<div class="ued-location mgb-20">我的位置：通告配置</div>
	<!--面包屑  d-->
	<div class="ued-tab js_tab">
		<div class="ued-tab-tit clearfix js_tab_tit">
	        <ul class="ued-tab-1 fl clearfix">
	        	<li class="on1"><a class="ued-see" href="${ctx}/back/notice">详情</a></li>
	        </ul>
	    </div>
		    <div class="ued-tab-con">	
		        <div class="box-n on1">
		        <div id="ued-packBox">
				<form enctype="multipart/form-data" >
		            <div class="ued-pannel">
		                <table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor">
		                    <colgroup><col width="135"><col><col width="135"><col></colgroup>
		                    <tbody>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>通告内容：</th>
		                            <td colspan="3">
		                            	<textarea rows="5" cols="80" class="bord-3" id="noticeText" style="color: #535356;padding-left: 10px;font-family: 'microsoft yahei';">${notice.CONTENT }</textarea>
		                            	<p class="color-3 fs-14" id="notice_msg"></p>  
		                            </td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
   				</form>
				<div class="mgt-25 tc">
	            	<button class="ued-button-3" onclick="save()">发布</button>
	            </div>
	            </div>
	        </div>
	    </div>
	</div>

</body>
<script type="text/javascript">
var rootContext = '${ctx}';

//保存
function save(){
	var noticeText = $("#noticeText").val();
	if(noticeText.trim().length==0){
		$("#notice_msg").html("通知内容不可为空！");
		return false;
	}else{
		$.ajax({
			type : "POST",
			url : "${ctx}/back/notice/saveOrUpdate",
			data : {
				"notice_text":$("#noticeText").val()
			},
			dataType:"json",
			success: function(json){
				var retCode = json.retCode;
				if(retCode==0){
                    ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                        {type:2,
                            info:'通告配置',
                            text:'<div style=" font-size:18px; color:#ff0000;"> 发布成功 </div>',
                            'ok':function(){
                                location.href=ctx + "/back/notice";
							},
                            tag:'zq-ring'}
                    );

				}else{
                    ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                        {type:2,
                            info:'通告配置',
                            text:'<div style=" font-size:18px; color:#ff0000;"> 发布失败 </div>',
                            'ok':function(){},
                            tag:'cw-ring'}
                    );
                    return;
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
