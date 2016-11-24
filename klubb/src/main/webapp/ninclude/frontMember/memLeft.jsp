<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<div class="us-set-lf fl">
	<div class="us-set-top">
		<dl class="info clearfix">
			<dd>
				<h3 class="nic">用户名 ： ${user.NAME }</h3>
			</dd>
			<dd>
				<h3>绑定手机号：${user.PHONE }</h3>
			</dd>
		</dl>



	</div>
	<ul class="us-menu mgt-25">
		<li id="infoMgr"><a href="javascript:myLoadLeft('infoMgr','${ctx }/userCenter');" class="link curr clearfix"> <i
				class="icon fl diyi"></i>
				<h5 class="name fl">信息管理</h5>
		</a></li>
		<li id="activityMgr"><a href="javascript:myLoadLeft('activityMgr','${ctx}/userCenter/toActMan');" class="link clearfix"> <i
				class="icon fl diliu"></i>
				<h5 class="name fl">活动管理</h5>
		</a></li>
		<li id="happyMgr"><a href="#none" class="link clearfix"> <i
				class="icon fl disan"></i>
				<h5 class="name fl">happytimes</h5>
		</a></li>
		<li><a href="#none" class="link clearfix"> <i
				class="icon fl disi"></i>
				<h5 class="name fl">参赛管理</h5>
		</a></li>
	</ul>
</div>
<script type="text/javascript">
	function myLoadLeft(obj, url) {
		$("#" + obj + " a").addClass("curr").parent().siblings()
				.children().removeClass("curr");
		window.location.href = url;
	}
</script>