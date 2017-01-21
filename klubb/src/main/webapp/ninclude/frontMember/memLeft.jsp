<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<div class="us-set-lf fl">
	<div class="us-set-top">
		<dl class="info clearfix">
			<dd>
				<h3 class="nic"><i18n:get key="portal.user.name"></i18n:get>: ${user.NAME }</h3>
			</dd>
			<dd>
				<h3><i18n:get key="portal.regist.phone"></i18n:get>:${user.PHONE }</h3>
			</dd>
		</dl>



	</div>
	<ul class="us-menu mgt-25">
		<li id="activityMgr"><a href="javascript:myLoadLeft('activityMgr','${ctx}/userCenter/toActMan');" class="link curr clearfix" url="toActMan"> <i
				class="icon fl diliu"></i>
				<h5 class="name fl">活动管理</h5>
		</a></li>
		<li id="happyMgr"><a href="javascript:myLoadLeft('happyMgr','${ctx}/userCenter/toHappytimes');" class="link clearfix" url="toHappytimes"> <i
				class="icon fl disan"></i>
				<h5 class="name fl">happytimes</h5>
		</a></li>
		<li id="matchMgr"><a href="javascript:myLoadLeft('matchMgr','${ctx}/userCenter/toMatMan');" class="link clearfix" url="toMatMan"> <i
				class="icon fl disan"></i>
				<h5 class="name fl">参赛管理</h5>
		</a></li>
		<li id="infoMgr"><a href="javascript:myLoadLeft('infoMgr','${ctx }/userCenter/toUserInfo');" class="link clearfix" url="toUserInfo"> <i
				class="icon fl diyi"></i>
				<h5 class="name fl">信息管理</h5>
		</a></li>
	</ul>
</div>
<script type="text/javascript">
	$(function(){
		var url = window.location.href;
		
		$(".us-menu a:gt(0)").each(function(){
			if(url.indexOf($(this).attr("url")) != -1){
				$(this).addClass("curr").parent().siblings().children().removeClass("curr");
				return;
			}
		});
	});
	function myLoadLeft(obj, url) {
		$("#" + obj + " a").addClass("curr").parent().siblings()
				.children().removeClass("curr");
		window.location.href = url;
	}
</script>