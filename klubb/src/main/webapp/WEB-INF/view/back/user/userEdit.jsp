<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<!--面包屑  s-->
	<div class="ued-location mgb-20">我的位置：用户管理</div>
	<!--面包屑  d-->
	<div class="ued-tab js_tab">
		<div class="ued-tab-tit clearfix js_tab_tit">
	        <ul class="ued-tab-1 ued-tab-2 fl clearfix">
	        	<li><a href="${ctx}/back/user">用户信息</a></li>
	        </ul>
	    </div>
		    <div class="ued-tab-con">	
		        <div class="box-n on1">
		            <h4 class="ued-title-3 mgt-10">基本信息</h4>
					<form enctype="multipart/form-data"  id="userForm">
                    <p class="color-3 fs-14" id="content_msg"></p>
		            <div class="ued-pannel">
		            	<table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor">
		                    <colgroup><col width="135"><col><col width="135"><col></colgroup>
		                    <tbody>
				            	<tr>
		                            <th><font color="color-3">*&nbsp;</font>姓名：</th>
		                            <td>
		                                <input type="hidden" value="${user.ID }"  id="uid" name="user.ID" >
		                                <input type="text" value="${user.NAME }"  id="uName" name="user.NAME" class="ued-text-2" maxlength="30">
		                            </td>
		                            <th>昵称：</th>
		                            <td>
		                            	<input type="text" value="${user.NICKNAME }" id="nName" name="user.NICKNAME" class="ued-text-2" maxlength="30"/>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>人口号：</th>
		                            <td>
		                                <input type="text" value="${user.idNumber }" id="idNum" name="user.ID_NUMBER" class="ued-text-2" maxlength="30">
		                            </td>
		                            <th><font color="color-3">*&nbsp;</font>邮箱：</th>
		                            <td>
		                            	<input type="text" value="${user.EMAIL }" id="uEmail" name="user.EMAIL" class="ued-text-2" maxlength="30"/>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>性别：</th>
		                            <td>
		                                <c:if test="${user.GENDER==0 }">
		                                	<input name="user.GENDER" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" >男   
											<input name="user.GENDER" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" checked="checked" > 女
		                                </c:if>
		                                <c:if test="${user.GENDER==1 }">
		                                	<input name="user.GENDER" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" checked="checked" >男   
											<input name="user.GENDER" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" > 女
		                                </c:if>
		                                <c:if test="${empty user.GENDER }">
		                                	<input name="user.GENDER" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" checked="checked" >男   
											<input name="user.GENDER" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" > 女
		                                </c:if>
		                            </td>
		                            <th>手机号：</th>
		                            <td>
		                            	<input type="text" value="${user.PHONE }" id="uPhone" name="user.PHONE" class="ued-text-2" maxlength="30"/>
		                            </td>
		                        </tr>
		                        <tr>
		                        	<th><font color="color-3">*&nbsp;</font>状态：</th>
		                            <td>
		                                <c:if test="${user.STATUS==0 }">
		                                	<input name="user.STATUS" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" >不可用
											<input name="user.STATUS" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" checked="checked" > 可用
		                                </c:if>
		                                <c:if test="${user.STATUS==1 }">
		                                	<input name="user.STATUS" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" checked="checked" >不可用
											<input name="user.STATUS" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" > 可用
		                                </c:if>
		                                <c:if test="${ empty user.STATUS }">
		                                	<input name="user.STATUS" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" >不可用
											<input name="user.STATUS" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" checked="checked" > 可用
		                                </c:if>
		                            </td>
		                            <th>起始分：</th>
		                            <td>
		                            	<input type="text" value="${user.lastStartScore }" name="user.LAST_START_SCORE" id="uScore" class="ued-text-2" maxlength="30"/>
		                            </td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		            <div class="ued-pannel">
		            	<div style="margin-left: 10px">
    						<script id="editor" type="text/plain" style="width:98%;height:500px;"></script>
    					</div>
		            </div>
		            
   					</form>
		            <div class="mgt-25 tc">
		            	<button class="ued-button-3" onclick="submit()">提交</button>
		            	<button class="ued-button-3" onclick="back()">返回</button>
		            </div>
		        </div>
		    </div>
	</div>
</body>
<script type="text/javascript">
var rootContext = '${ctx}';

//返回
function back(){
	location.href = ctx+"/back/user";
}

function submit(){
	//非空校验
	var uName = $("#uName").val();
	if(uName.trim().length==0){
		ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
		   {type:2,
			info:'用户管理',
			text:'<div style=" font-size:18px; color:#ff0000;"> 姓名不能为空！ </div>',
			'ok':function(){return;},
			tag:'tx-ring'}
              );
	}
	var idNum = $("#idNum").val();
	if(idNum.trim().length==0){
		ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
		   {type:2,
			info:'用户管理',
			text:'<div style=" font-size:18px; color:#ff0000;"> 人口号不能为空！ </div>',
			'ok':function(){return;},
			tag:'tx-ring'}
              );
		return;
	}
	var uEmail = $("#uEmail").val();
	if(uEmail.trim().length==0){
		ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
		   {type:2,
			info:'用户管理',
			text:'<div style=" font-size:18px; color:#ff0000;"> 邮箱不能为空！ </div>',
			'ok':function(){return;},
			tag:'tx-ring'}
              );
		return;
	}
	//邮箱唯一性校验
	$.ajax({
		type:"post",
		cache : false,
		url : ctx + "/back/user/checkEmail",
		data: {
			uid: $("#uid").val(),
			email : uEmail
		},
		dataType : "json",
		success : function(data){
			var retCode = data.retCode;
			if(retCode!=0){
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'用户管理',
					text:'<div style=" font-size:18px; color:#ff0000;"> 此邮箱已注册，请更换其他邮箱！ </div>',
					'ok':function(){return;},
					tag:'tx-ring'}
		              );
			}
			//更新提交
			$.ajax({
				type:"post",
				cache : false,
				url : ctx + "/back/user/editUser",
				data: $("#userForm").serialize(),
				dataType : "json",
				success : function(data){
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示信息',
						text:'<div style=" font-size:18px; color:#ff0000;">'+data.retMsg+'</div>',
						'ok':function(){back();},
						tag:'zq-ring'}
		              );
				},
				error : function(json){
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'用户管理',
						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试！ </div>',
						'ok':function(){return;},
						tag:'cw-ring'}
			              );
				}
			});
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'用户管理',
				text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试！ </div>',
				'ok':function(){return;},
				tag:'cw-ring'}
	              );
		}
	});
	
}

</script>
</html>
