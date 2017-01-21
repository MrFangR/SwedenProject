<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="zh-CN">
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title><i18n:get key="portal.user.center.info"></i18n:get></title>
    <script  src="${ctx}/front-ui/js/jquery1.9.0.min.js"></script>
    <script  src="${ctx}/front-ui/js/ui.js"></script>
    <script  src="${ctx }/js/jST.v0.1.4.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/front-ui/css/component.css" />
</head>
<body class="tm-background">
  <header >
	<%@include file="/ninclude/frontMember/header.jsp"%>
  </header >

   
<!--内容 start-->
     <div class="main_body" style="margin-top:110px;">
          <div class="us-set mgt-30 clearfix">
          		 <!--us-set-lf start-->
          			<%@include file="/ninclude/frontMember/memLeft.jsp"%>
                 <!--us-set-lf end-->
                 <!--us-set-rt start-->
          		<div class="us-set-rt fl">
                		<div class="us-nav-box">
                            <ul class="us-nav-ul clearfix">
                                <li class="nav curr"><i18n:get key="portal.user.center.setinfo"></i18n:get></li>
                                <li class="nav"><i18n:get key="portal.user.center.resetpwd"></i18n:get></li>
                            </ul>
					    </div>
                        <div  class="us-body">
					<!--基本信息 S-->
						<div class="box us-bd-base">
							
							<dl class="us-base-info" >
								
								<dd class="info-box">
                                	
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><i18n:get key="portal.contact.form.name"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="name" value="${user.NAME }"/></dd>
										<dd class="notice" id="name_notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><i18n:get key="portal.regist.nickname"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="nickName" value="${user.NICKNAME }"/></dd>
										<dd class="notice" id="nickName_notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl"><i18n:get key="portal.regist.number"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="idNum" value="${user.idNumber }"/></dd>
										<dd class="notice" id="idNum_notice"></dd>
									</dl>
                                    <dl class="us-info-dl clearfix">
										<dt class="fl"><i18n:get key="portal.regist.gender"></i18n:get>：</dt>
										<dd class="fl sex-box">
											<c:if test="${user.GENDER==0 }">
												<label><input name="sex" type="radio" value="1" />男生</label>  
												<label><input name="sex" type="radio" value="0" checked="checked"/>女生</label>
											</c:if>
											<c:if test="${user.GENDER!=0 }">
												<label><input name="sex" type="radio" value="1" checked="checked"/>男生</label>  
												<label><input name="sex" type="radio" value="0" />女生</label>
											</c:if>
										</dd>
										<dd class="notice"></dd>
									</dl>
									<!-- 
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl">邮箱地址：</dt>
										<dd class="fl"><input  type="text" id="email" value="${user.EMAIL }"/></dd>
										<dd class="notice" id="email_notice"></dd>
									</dl>
									 -->
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl"><i18n:get key="portal.regist.phone"></i18n:get>：</dt>
										<dd class="fl"><input  type="text" id="phone" value="${user.PHONE }"/></dd>
										<dd class="notice"></dd>
									</dl>
                                    <dl class="us-info-dl clearfix">
										<dt class="fl"><i18n:get key="portal.contact.form.code"></i18n:get>：</dt>
										<dd class="fl">
									    	<input type="text" id="imgcode" name="imgcode" maxlength="4" class="ued-input fl" style="width:100px;" /> 
											<img id="randCodeImage" class="mgl-10" style="height: 40px;" src="${ctx}/sys/randCodeImage" /> 
									    </dd>
										<dd class="notice" id="imgcode_notice"></dd>
									</dl>
									<dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn" id="submitInfo"><i18n:get key="portal.user.center.save"></i18n:get></div>
										</dd>
									</dl>		
								</dd>
							</dl>
						</div>
						<!--基本信息 E-->
                        <!--更改密码 S-->
						<div class="box" style="display: none;">
                        
                            	<dl class="us-base-info  mgt-30">
								
                                    <dd class="info-box">
                                    
                                     
                                        <dl  class="us-info-dl clearfix">
                                            <dt class="fl"><span class="brown">*</span><i18n:get key="portal.user.center.oldpwd"></i18n:get>：</dt>
                                            <dd class="fl"><input type="password" id="oldPwd" placeholder="Ange gamla lösenordet"/></dd><!-- 请输入原始密码 -->
                                            <dd class="notice"></dd>
                                        </dl>
                                        <dl  class="us-info-dl clearfix">
                                            <dt class="fl"><span class="brown">*</span><i18n:get key="portal.user.forget.newpwd"></i18n:get>：</dt>
                                            <dd class="fl"><input  type="password" id="newPwd" placeholder="ange ett nytt lösenord"/></dd><!-- 请输入新密码 -->
                                            <dd class="notice"></dd>
                                        </dl>
                                        <dl  class="us-info-dl clearfix">
                                            <dt class="fl"><span class="brown">*</span><i18n:get key="portal.regist.repassword"></i18n:get>：</dt>
                                            <dd class="fl"><input  type="password" id="repwd" placeholder="bekräfta ditt nytt lösenord"/></dd><!-- 请再 次输入新密码 -->
                                            <dd class="notice"></dd>
                                        </dl>
                                       
                                        <dl class="us-info-dl clearfix">
                                            <dt class="fl">&nbsp;</dt>
                                            <dd class="fl">
                                            <div class="us-btn" id="submitPwd"><i18n:get key="portal.contact.form.submit"></i18n:get></div>
                                            </dd>
									   </dl>
                                    </dd>
							</dl>
                        </div>
                        <!--更改密码 E-->
					</div>
                
                </div>
           <!--us-set-rt end-->
           
          </div>
      <div class="clearfix"></div>
     </div>
 
 <!--内容 end-->
<!--bottom S-->
<%@ include file="/ninclude/frontMember/footer.jsp"%>
<!--bottom E-->
</body>
</html>
<script type="text/javascript">
$(function(){
	
	$("#submitInfo").bind("click",submitInfo);
	$("#submitPwd").bind("click",submitPwd);
	$("#randCodeImage").click(getRandImg);
	$("#name").focus(function(){
		$("#name_notice").html("");
	});
	$("#nickName").focus(function(){
		$("#nickName_notice").html("");
	});
	$("#idNum").focus(function(){
		$("#idNum_notice").html("");
	});
	$("#imgcode").focus(function(){
		$("#imgcode_notice").html("");
	});
	$("#oldPwd").focus(function(){
		$("#oldPwd").parent().next(".notice").html("");
	});
	$("#newPwd").focus(function(){
		$("#newPwd").parent().next(".notice").html("");
	});
	$("#repwd").focus(function(){
		$("#repwd").parent().next(".notice").html("");
	});
});
function submitInfo(){
	$("#submitInfo").unbind("click");
	var name = $("#name").val();
	if(name.trim().length==0){
		$("#name_notice").html("姓名不能为空！");
		$("#submitInfo").bind("click",submitInfo);
		return false;
	}
	var niceName = $("#nickName").val();
	if(niceName.trim().length==0){
		$("#nickName_notice").html("昵称不能为空！");
		$("#submitInfo").bind("click",submitInfo);
		return false;
	}
	var idNum = $("#idNum").val();
	if(idNum.trim().length==0){
		$("#idNum_notice").html("人口号不能为空！");
		$("#submitInfo").bind("click",submitInfo);
		return false;
	}
	/* var email = $("#email").val();
	if(email.trim().length==0){
		$("#email_notice").html("邮箱不能为空！");
		return false;
	}else if(!jST.isEmail(email)){
		$("#email_notice").html("请输入全法邮箱地址！");
		return false;
	} */
	$.ajax({
		type: "post",
		cache: false,
		dataType : "json",
		url : "${ctx}/userCenter/submitInfo",
		data : {
			"name" : $("#name").val(),
			"nickName" : $("#nickName").val(),
			"idNum" : $("#idNum").val(),
			//"email" : $("#email").val(),
			"sex" : $("input[name='sex']:checked").val(),
			"phone" : $("#phone").val(),
			"imgcode" : $("#imgcode").val()
		},
		success : function(json) {
			var mark = json.retCode;
			if (mark == 0) {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'个人资料',
					text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
					'ok':function(){window.location.href = '${ctx}/userCenter/toUserInfo';},
					tag:'zq-ring'}
	               );
				
			} else {
				var tip = json.retMsg.split(":");
				$("#"+tip[0]+"_notice").html(tip[1]);
				$("#submitInfo").bind("click",submitInfo);
			}
		},
		error : function() {
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'个人资料',
				text:'<div style=" font-size:18px; color:#ff0000;">Det gick inte att ändra lösenordet. </div>',//修改失败
				'ok':function(){
					$("#submitInfo").bind("click",submitInfo);
					},
				tag:'cw-ring'}
               );
			return;
		}
	});
}

function submitPwd(){
	
	$("#submitPwd").unbind("click");
	var oldpwd = $("#oldPwd").val();
	if(oldpwd.trim().length == 0){
		$("#oldPwd").parent().next(".notice").html("原始密码不能为空！");
		$("#submitPwd").bind("click",submitPwd);
		return false;
	}
	var newpwd = $("#newPwd").val();
	if(newpwd.trim().length==0){
		$("#newPwd").parent().next(".notice").html("新密码不能为空！");
		$("#submitPwd").bind("click",submitPwd);
		return false;
	}
	var repwd = $("#repwd").val();
	if(repwd.trim().length==0){
		$("#repwd").parent().next(".notice").html("确认密码不能为空！");
		$("#submitPwd").bind("click",submitPwd);
		return false;
	}else if(newpwd!=repwd){
		$("#repwd").parent().next(".notice").html("Lösenorden stämmer inte");//两次密码不一致,请重新输入!	
		$("#submitPwd").bind("click",submitPwd);
		return false;
	}
	
	$.ajax({
		type: "post",
		cache: false,
		dataType : "json",
		url : "${ctx}/userCenter/submitPwd",
		data : {
			"oldPwd" : $("#oldPwd").val(),
			"newPwd" : $("#newPwd").val(),
			"repwd" : $("#repwd").val()
		},
		success : function(json) {
			var mark = json.retCode;
			if (mark == 0) {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'个人资料',
					text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
					'ok':function(){window.location.href = '${ctx}/userCenter/toUserInfo';},
					tag:'zq-ring'}
	               );
			} else {
				var tip = json.retMsg.split(":");
				$("#"+tip[0]).parent().next(".notice").html(tip[1]);
				$("#submitPwd").bind("click",submitPwd);
				return;
			}
		},
		error : function() {
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'个人资料',
				text:'<div style=" font-size:18px; color:#ff0000;">Det gick inte att ändra lösenordet.</div>',//修改失败 
				'ok':function(){
					$("#submitPwd").bind("click",submitPwd);
					},
				tag:'cw-ring'}
               );
			return;
		}
	});
}
function getRandImg(){
	$('#randCodeImage').attr('src', "${ctx}/sys/randCodeImage?"+Math.random());
}

</script>

