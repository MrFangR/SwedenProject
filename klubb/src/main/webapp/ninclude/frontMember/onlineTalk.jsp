<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/ninclude/import.jsp"%> 


<%
// qq在线咨询，微信扫一扫，在线留言功能
%>

<div class="main-im">
	<div id="open_im" class="open-im">&nbsp;</div>  
	<div class="im_main" id="im_main">
		<div id="close_im" class="close-im"><a href="javascript:void(0);" title="点击关闭">&nbsp;</a></div>
			<a href="http://wpa.qq.com/msgrd?v=3&uin=80352004&site=qq&menu=yes" target="_blank" class="im-qq qq-a" title="在线QQ客服">
			<div class="qq-container"></div>
			<div class="qq-hover-c"><img class="img-qq" src="${ctx}/images/qq.png"></div>
			<span> QQ在线咨询</span>
			</a>
		<div class="im-tel">
			<div>咨询热线</div>
			<div class="tel-num">400-123-45678</div>
		</div>
		<div class="im-msg">
			<div>在线留言</div>
			<div><a href="javascript:popQuick();">快捷通道</a></div>
		</div>
		<div class="im-footer" style="position:relative">
			<div class="weixing-container">
				<div class="weixing-show">
					<div class="weixing-txt">微信扫一扫<br>打开精简开店</div>
					<img class="weixing-ma" src="${ctx}/images/footerewm.jpg">
					<div class="weixing-sanjiao"></div>
					<div class="weixing-sanjiao-big"></div>
				</div>
			</div>
			<div class="go-top"><a href="javascript:;" title="返回顶部"></a> </div>
			<div style="clear:both"></div>
		</div>
	</div>
</div>
<script  type="text/javascript" src="${ctx}/front-ui/js/quickRelease.js"></script>
<script type="text/javascript">
//qq在线咨询
$(function(){
	$('#close_im').bind('click',function(){
		$('#main-im').css("height","0");
		$('#im_main').hide();
		$('#open_im').show();
	});
	$('#open_im').bind('click',function(e){
		$('#main-im').css("height","272");
		$('#im_main').show();
		$(this).hide();
	});
	$('.go-top').bind('click',function(){
		$(window).scrollTop(0);
	});
	$(".weixing-container").bind('mouseenter',function(){
		$('.weixing-show').show();
	})
	$(".weixing-container").bind('mouseleave',function(){        
		$('.weixing-show').hide();
	});
});
</script>