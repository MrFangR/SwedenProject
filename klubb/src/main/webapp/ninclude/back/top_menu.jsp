<%@page import="com.partner.common.util.BackSessionUtil"%>
<%@page pageEncoding="UTF-8"%>
<%
	/* 后台管理系统 页面统一引用 - 顶部菜单 */
%>
<div class="ued-head clearfix">
	<div class="ued-logo fl">后台管理系统</div>
	<div class="ued-nav fr">
		<ul class="root_ul">
			<li id="topMenu_1">
				<a class="home" href="${ctx}/back/main/init">首页</a>
			</li>
			<li class="relative js_pass">
				<a class="pdl-10 user" href="javascript:void(0)" id="showUserNo"><%=BackSessionUtil.getUserName(request)%></a>
				<div class="ued-password">
					<h4>修改密码</h4>
					<div class="ued-inp">
						<div class="ued-p">
							<input type="password" id="oldPwd" placeholder="请输入原密码" maxlength="16"/>
						</div>
						<div class="ued-p">
							<input type="password" id="newPwd" placeholder="请输入新密码" maxlength="16"/>
						</div>
						<div class="ued-p noborder">
							<input type="password" id="cfmPwd" placeholder="请输入确认密码" maxlength="16"/>
						</div>
					</div>
					<p class="color-3" id="pwdChgTip"></p>
					<div class="tc">
						<button class="ued-button-2 ued-btn-small mgr-25" onclick="pwdChg()">保存</button>
						<button class="ued-button-3 ued-btn-small" onclick="pwdChgReset()">重置</button>
					</div>
				</div>
			</li>
			<li>
				<a class="end" href="${ctx}/back/logout">退出</a>
			</li>
		</ul>
	</div>
</div>

<script>
function pwdChg(){
	var oldPwd = $("#oldPwd").val();
	var newPwd = $("#newPwd").val();
	var cfmPwd = $("#cfmPwd").val();
	if (!valid_pwd(oldPwd)) {
		$("#pwdChgTip").text("原密码输入错误");$("#oldPwd").focus();return;
	} else if (!valid_pwd(newPwd)) {
		$("#pwdChgTip").text("新密码输入错误");$("#newPwd").focus();return;
	} else if (newPwd != cfmPwd) {
		$("#pwdChgTip").text("确认密码与新密码不一致");$("#cfmPwd").focus();return;
	}
	$("#pwdChgTip").text("正在提交，请稍后....");
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/user/chgPwd",
		data: {
			oldPwd : oldPwd,
			newPwd : newPwd
		},
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				$("#pwdChgTip").text("密码修改成功");
				setTimeout(function(){
					if ($("#showUserNo").hasClass("on")) {
						$("#showUserNo").click();
					}
				}, 2000);
			} else {
				$("#pwdChgTip").text(json.msg);
			}
			return;
		},
		error : function(json){
			$('#tip').text("系统异常，请稍后重试");
			return;
		}
	});
}
</script>