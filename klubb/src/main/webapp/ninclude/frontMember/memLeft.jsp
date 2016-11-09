<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <div class="us-set-lf fl">
 	<input id="funcLeft" type="hidden" value="${func}"/>
    <div class="us-set-top">
		<dl class="info clearfix">
			<dt class="fl">
				<img  id="profilePic_left" src="${uploadUrl}${member.PROFILE_PIC}" height="96" width="96" alt="pic" onerror="javascript:this.src='${ctx}/front-ui/images/img.jpg';"/>
			</dt>
			<dd class="fl">
			 	<h3 class="nic">${member.NICK_NAME } |  <a href="${ctx}/logout">退出</a></h3>
				<p class="text">可用积分：<span class="brown">${member.BALANCE }</span></p>
			</dd>
	        <dd class="fl">
				<h3 class="num">绑定手机号：${member.PHONE }</h3>
			</dd>
		</dl>
	</div>
	<ul class="us-menu mgt-25">
	    <li id="myMember_left">
			<a href="javascript:myLoadLeft('myMember','${ctx}/myAccount');" class="link curr clearfix">
				<i class="icon fl diyi"></i>
				<h5 class="name fl">个人资料</h5>
			</a>
		</li>
		<li id="myIntegral_left">
			<a href="javascript:myLoadLeft('myIntegral','${ctx}/myIntegral');" class="link clearfix">
				<i class="icon fl diliu"></i>
				<h5 class="name fl">我的积分</h5>
			</a>
		</li>
		<li id="myFavorite_left">
			<a href="javascript:myLoadLeft('myFavorite','${ctx}/myFavorite');" class="link clearfix">
				<i class="icon fl disan"></i>
				<h5 class="name fl">我的收藏</h5>
			</a>
		</li>
		<li id="myPost_left">
			<a href="javascript:myLoadLeft('myPost','${ctx}/myPost');" class="link clearfix">
				<i class="icon fl disi"></i>
				<h5 class="name fl">我的发布</h5>
			</a>
		</li>
		<li id="chainCorpor_left">
			<a href="javascript:myLoadLeft('chainCorpor','${ctx}/chainCorpor');" class="link clearfix">
				<i class="icon fl disi"></i>
				<h5 class="name fl">连锁公司</h5>
			</a>
		</li>
		<li id="myDescribe_left">
			<a href="javascript:myLoadLeft('myDescribe','${ctx}/myDescribe');" class="link clearfix">
				<i class="icon fl disi"></i>
				<h5 class="name fl">积分购买</h5>
			</a>
		</li>
		<li id="quickRelease_left">
			<a href="javascript:popQuick();" class="link clearfix">
				<i class="icon fl dier"></i>
				<h5 class="name fl">快捷通道</h5>
			</a>
		</li>
	</ul>
</div>

<script type="text/javascript">
	$(function(){
		var obj = $("#funcLeft").val();
		var ctx = "${ctx}";
		if(obj=="myMember" || obj == "myCentre" || obj == "" ){
			$("#myMember_left a").addClass("curr").parent().siblings().children().removeClass("curr");
		}else{
			$("#"+obj+"_left a").addClass("curr").parent().siblings().children().removeClass("curr");
		}
	});
	function myLoadLeft(obj, url){
		$("#"+obj+"_left a").addClass("curr").parent().siblings().children().removeClass("curr");
		window.location.href=url;
	}
</script>