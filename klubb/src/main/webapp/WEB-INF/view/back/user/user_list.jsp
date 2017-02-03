<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>后台管理系统</title>
<%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-location mgb-20">我的位置：用户管理</div>

	<div class="ued-tab js_tab">
		<div class="ued-tab-tit clearfix js_tab_tit">
			<div class="ued-pack fr" id="ued-pack">收起查询条件</div>
			<ul class="ued-tab-1 fl clearfix">
				<li class="liQuery on1"><a class="ued-see"
					href="javascript:void(0)">查询</a></li>
			</ul>
		</div>
		<div class="ued-tab-con">
			<div class="box-n on1">
				<div id="ued-packBox">
						<table width="100%" cellspacing="0" cellpadding="0"
							class="ued-table-nobor mgt-15">
							<colgroup>
								<col width="15%">
								<col width="35%">
								<col width="15%">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>搜索：</th>
									<td><input id="titleIn" type="text" name="title"
										class="ued-text-2" maxlength="30"
										placeholder="请输入用户姓名或昵称"  />
										&nbsp;&nbsp;&nbsp;&nbsp;<button class="ued-button-2 mgr-25" onclick="qryUser()">查询</button>
										<button class="ued-button-3" onclick="resetQry()">重置</button></td>
								</tr>
							</tbody>
						</table>
				</div>
				<div id="showLst">
	            </div>
			</div>
		</div>
	</div>
 <!--弹框  s-->
 <div data-role="ued-dialog" class="ued-dialog" id="btn-dialog">
    <div class="dialog-header">
        <h3>添加人员</h3>
        <span class="dialog-tool">
            <a title="关闭" class="dialog-close">X</a>
        </span>
    </div>
    <div>
        <p class="pd-20 dialog-tipInfo clearfix">姓名：
        	<input name="user_name" id="user_name" type="text"><font color="color-3">&nbsp;*</font>
       	</p>
        <div class="pd-10 tc">
            <button type="button" class="ued-button-2 mgr-25" id="submitUser">保存</button>
            <button type="button" class="ued-button-3 dialog-close">取消</button>
        </div>
    </div>
</div>
	
</body>
<script type="text/javascript" src="${ctx}/back-ui/pub-ui/js/plugin/dialog.js"></script>
<script type="text/javascript" src="${ctx}/back-ui/local-ui/backUser.js"></script>
</html>
