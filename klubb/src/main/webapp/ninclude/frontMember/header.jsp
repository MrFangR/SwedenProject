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
			<li class="jsli" width="15"><a href="${ctx }" ><i18n:get key="portal.menu.index"></i18n:get></a></li>
            <li class="jsli" width="134"><a href="#none"><i18n:get key="portal.menu.introduce"></i18n:get></a></li>
            <li class="jsli" width="254"><a href="${ctx}/front/happytimes"><i18n:get key="portal.menu.happytimes"></i18n:get></a></li>
            <li class="jsli" width="376"><a href="${ctx}/front/activity"><i18n:get key="portal.menu.activity"></i18n:get></a></li>
            <li class="jsli" width="500"><a href="#none"><i18n:get key="portal.menu.game"></i18n:get></a></li>
            <li class="jsli" width="614"><a href="#none"><i18n:get key="portal.menu.contact"></i18n:get></a></li>
            <li class="line"></li>
           </ul>
        </nav>
       
     </div>   
     
<script type="text/javascript">
function logout(){
	$.ajax({
		type : "post",
		cache : false,
		dataType : "json",
		url : "${ctx}/front/logout",
		success : function(json) {
			var mark = json.retCode;
			if (mark == 0) {
				alert("退出成功");
				window.location.href = '${ctx}';
			} else {
				alert("退出失败");
			}
		},
		error : function() {
			alert("退出失败");
		}

	});
}	
</script>
