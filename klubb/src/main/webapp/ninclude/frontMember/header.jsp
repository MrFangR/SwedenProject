<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
 
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <div class="pubtop">
	<div class="main_body">
		<input id="func" type="hidden" value="${func}"/>
       <div class="m_logo fl" ><a href="${ctx }/"><img src="${ctx}/front-ui/images/logo_simple.png" alt="精简开店"></a></div>
       <div class="m_aavig fl">
       	       <ul id="navi">
                       <li class="active first position-rel">
                           <a title="精简开店" href="${ctx}/home/index" target="_self">首页</a>
                       </li>
                       <li class="position-rel" id="myCentre">
                           <b></b><a title="我的精简" href="javascript:myLoadHead('myCentre','${ctx}/myCentre');" target="_blank">我的精简</a>
                       </li>
                       <li  class="position-rel" id="myMember">
                          <a title="账户设置" href="javascript:myLoadHead('myMember','${ctx}/myAccount');" target="_blank" >账户设置</a>
                       </li>
                       <li  class="position-rel" id="myIntegral">
                           <a title="我的积分" href="javascript:myLoadHead('myIntegral','${ctx}/myIntegral')" target="_blank">我的积分</a>
                       </li>
                   </ul>
				</div>
              <div class="m_status fr">
                  <ul>
                     <li><a href="none"><i class="io1"></i>论坛</a></li>
                     <li><a href="${ctx }/shop"><i class="io3"></i>寻找商铺</a></li>
                     <li><a href="${ctx }/project"><i class="io4"></i>寻找项目</a></li>
                     <li><a href="${ctx }/shop/add"><i class="io5"></i>发布商铺</a></li>
                     <li><a href="${ctx }/project/add"><i class="io6"></i>发布项目</a></li>
                  </ul>
              </div>
      </div>
            
   </div>
   
<script type="text/javascript">
$(function(){
	var obj = $("#func").val();
	if(obj=="myCentre" || obj == "myFavorite" ||obj == "myPost" ||obj == "chainCorpor"){
		$("#myCentre").append("<b></b>").siblings().children("b").remove();
	}else{
		$("#"+obj).append("<b></b>").siblings().children("b").remove();
	}
});
function myLoadHead(obj, url){
	$("#"+obj).append("<b></b>").siblings().children("b").remove();
	window.location.href=url;
}
</script>
   