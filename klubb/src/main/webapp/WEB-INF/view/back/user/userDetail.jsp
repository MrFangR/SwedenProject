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
					<form enctype="multipart/form-data" >
                    <p class="color-3 fs-14" id="content_msg"></p>
		            <div class="ued-pannel">
		            	<table width="100%" cellspacing="0" cellpadding="0" class="ued-table-nobor">
		                    <colgroup><col width="135"><col><col width="135"><col></colgroup>
		                    <tbody>
				            	<tr>
		                            <th><font color="color-3">*&nbsp;</font>姓名：</th>
		                            <td>
		                                <input type="text" value="${user.NAME }" class="ued-text-2" maxlength="30" readonly>
		                            </td>
		                            <th>昵称：</th>
		                            <td>
		                            	<input type="text" value="${user.NICKNAME }" class="ued-text-2" maxlength="30" readonly>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>人口号：</th>
		                            <td>
		                                <input type="text" value="${user.idNumber }" class="ued-text-2" maxlength="30" readonly>
		                            </td>
		                            <th><font color="color-3">*&nbsp;</font>邮箱：</th>
		                            <td>
		                            	<input type="text" value="${user.EMAIL }" class="ued-text-2" maxlength="30" readonly>
		                            </td>
		                        </tr>
		                        <tr>
		                            <th><font color="color-3">*&nbsp;</font>性别：</th>
		                            <td>
		                                <c:if test="${user.GENDER==0 }">
		                                	<input name="sex" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" disabled readonly>男   
											<input name="sex" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" checked="checked" disabled readonly> 女
		                                </c:if>
		                                <c:if test="${user.GENDER==1 }">
		                                	<input name="sex" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" checked="checked" disabled readonly>男   
											<input name="sex" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" disabled readonly> 女
		                                </c:if>
		                                
		                            </td>
		                            <th>手机号：</th>
		                            <td>
		                            	<input type="text" value="${user.PHONE }" class="ued-text-2" maxlength="30" readonly>
		                            </td>
		                        </tr>
		                        <tr>
		                        	<th><font color="color-3">*&nbsp;</font>状态：</th>
		                            <td>
		                                <c:if test="${user.STATUS==0 }">
		                                	<input name="status" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" disabled readonly>不可用
											<input name="status" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" checked="checked" disabled readonly> 可用
		                                </c:if>
		                                <c:if test="${user.STATUS==1 }">
		                                	<input name="status" type="radio" value="1" class="ued-text-2" style="width:30px;border: 0;" checked="checked" disabled readonly>不可用
											<input name="status" type="radio" value="0" class="ued-text-2" style="width:30px; margin-left:50px;border: 0;" disabled readonly> 可用
		                                </c:if>
		                                
		                            </td>
		                            <th>起始分：</th>
		                            <td>
		                            	<input type="text" value="${user.lastStartScore }" class="ued-text-2" maxlength="30" readonly>
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

</script>
</html>
