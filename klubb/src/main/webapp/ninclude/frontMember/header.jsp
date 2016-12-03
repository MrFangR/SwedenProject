<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="i18n" uri="/i18n-taglib" %>
 
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <h1 class="herder-logo"><img src="${ctx }/front-ui/images/logo.png" width="136" height="161"></h1>
     <div class="header-con">
         <span class="fr">
         	<c:if test="${FRONT_SESSION_USER.EMAIL == null }">
         		<a href="${ctx }/front/toLogin"><i18n:get key="portal.menu.login"></i18n:get></a> | <a href="${ctx }/front/toRegist"><i18n:get key="portal.menu.regist"></i18n:get></a>
         	</c:if>
         	<c:if test="${FRONT_SESSION_USER.EMAIL != null }">
         		<a href="#none">${FRONT_SESSION_USER.NICKNAME }</a> | <a href="javascript:logout();"><i18n:get key="portal.menu.logout"></i18n:get></a>
         	</c:if>
         </span>
        <nav class="menu-body">
          <ul>
			<li class="jsli" width="15"><a href="${ctx }/home" ><i18n:get key="portal.menu.index"></i18n:get></a></li>
            <li class="jsli" width="134" url="introduce"><a href="${ctx}/introduce"><i18n:get key="portal.menu.introduce"></i18n:get></a></li>
            <li class="jsli" width="254" url="happytimes"><a href="${ctx}/front/happytimes"><i18n:get key="portal.menu.happytimes"></i18n:get></a></li>
            <li class="jsli" width="376" url="activity"><a href="${ctx}/front/activity"><i18n:get key="portal.menu.activity"></i18n:get></a></li>
            <li class="jsli" width="500"><a href="javascript:;" onclick="showAlert();"><i18n:get key="portal.menu.game"></i18n:get></a></li>
            <li class="jsli" width="614" url="contact"><a href="${ctx}/contact"><i18n:get key="portal.menu.contact"></i18n:get></a></li>
            <li class="jsli" width="738" url="userCenter"><a href="${ctx }/userCenter"><i18n:get key="portal.menu.center"></i18n:get></a></li>
            <li class="line"></li>
           </ul>
        </nav>
       
     </div>   
     
<script type="text/javascript">
$(function(){
	var url = window.location.href;
	var widthno = $(".menu-body li.jsli:first").attr("width");
	$(".menu-body li.jsli").each(function(){
		if(url.indexOf($(this).attr("url")) != -1){
			widthno = $(this).attr("width");
		}
	});
	$(".menu-body").find(".line").css({marginLeft:widthno+"px"});	
});

function showAlert(){
	ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
	   {type:2,
		info:'比赛',
		text:'<div style=" font-size:18px; color:#ff0000;"> 正在建设中，敬请期待...</div>',
		'ok':function(){},
		tag:'tx-ring'}
          );
}

function logout(){
	$.ajax({
		type : "post",
		cache : false,
		dataType : "json",
		url : "${ctx}/front/logout",
		success : function(json) {
			var mark = json.retCode;
			if (mark == 0) {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'',
					text:'<div style=" font-size:18px; color:#ff0000;"> 退出成功</div>',
					'ok':function(){window.location.href = '${ctx}/home';},
					tag:'zq-ring'}
	               );
				
			} else {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'',
					text:'<div style=" font-size:18px; color:#ff0000;"> 退出失败 </div>',
					'ok':function(){$("#submitRegist").bind("click",userRegist);},
					tag:'cw-ring'}
	               );
				return;
			}
		},
		error : function() {
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'',
				text:'<div style=" font-size:18px; color:#ff0000;"> 退出失败 </div>',
				'ok':function(){$("#submitRegist").bind("click",userRegist);},
				tag:'cw-ring'}
               );
			return;
		}

	});
}	
</script>
