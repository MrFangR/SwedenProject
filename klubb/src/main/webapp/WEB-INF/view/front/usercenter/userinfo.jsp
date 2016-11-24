<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="zh-CN">
<%@ include file="/ninclude/import.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no,email=no">
    <title>个人资料</title>
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
          		<div class="us-set-lf fl">
                	<div class="us-set-top">
						<dl class="info clearfix">
							<dd>
								<h3 class="nic">用户名 ： ${user.NAME }</h3>
							</dd>
                            <dd>
								<h3 >绑定手机号：${user.PHONE }</h3>
							</dd>
						</dl>
						

						
					</div>
					<ul class="us-menu mgt-25">
					    <li>
							<a href="#none" class="link curr clearfix">
								<i class="icon fl diyi"></i>
								<h5 class="name fl">信息管理</h5>
							</a>
						</li>
						<li>
							<a href="#none" class="link clearfix">
								<i class="icon fl diliu"></i>
								<h5 class="name fl">活动管理</h5>
							</a>
						</li>
						<li>
							<a href="#none" class="link clearfix">
								<i class="icon fl disan"></i>
								<h5 class="name fl">happytimes</h5>
							</a>
						</li>
						<li>
							<a href="#none" class="link clearfix">
								<i class="icon fl disi"></i>
								<h5 class="name fl">参赛管理</h5>
							</a>
						</li>
					</ul>
                </div>
                 <!--us-set-lf end-->
                 <!--us-set-rt start-->
          		<div class="us-set-rt fl">
                		<div class="us-nav-box">
                            <ul class="us-nav-ul clearfix">
                                <li class="nav curr">个人信息配置</li>
                                <li class="nav">更改密码</li>
                            </ul>
					    </div>
                        <div  class="us-body">
					<!--基本信息 S-->
						<div class="box us-bd-base">
							
							<dl class="us-base-info" >
								
								<dd class="info-box">
                                	
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl">姓名：</dt>
										<dd class="fl"><input  type="text" id="name" value="${user.NAME }"/></dd>
										<dd class="notice" id="name_notice"></dd>
									</dl>
                                    <dl  class="us-info-dl clearfix">
										<dt class="fl">昵称：</dt>
										<dd class="fl"><input  type="text" id="nickName" value="${user.NICKNAME }"/></dd>
										<dd class="notice" id="nickName_notice"></dd>
									</dl>
									<dl  class="us-info-dl clearfix">
										<dt class="fl">人口号：</dt>
										<dd class="fl"><input  type="text" id="idNum" value="${user.idNumber }"/></dd>
										<dd class="notice" id="idNum_notice"></dd>
									</dl>
                                    <dl class="us-info-dl clearfix">
										<dt class="fl">性别：</dt>
										<dd class="fl sex-box">
											<c:if test="${user.GENDER==0 }">
												<label><input name="sex" type="radio" value="1" />男生</label>  
												<label><input name="sex" type="radio" value="0" checked="checked"/>女生</label>
											</c:if>
											<c:if test="${user.GENDER==1 }">
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
										<dt class="fl">手机号码：</dt>
										<dd class="fl"><input  type="text" id="phone" value="${user.PHONE }"/></dd>
										<dd class="notice"></dd>
									</dl>
                                    <dl class="us-info-dl clearfix">
										<dt class="fl">验证码：</dt>
										<dd class="fl">
									    	<input type="text" id="imgcode" name="imgcode" maxlength="4" class="ued-input fl" style="width:100px;" /> 
											<img id="randCodeImage" class="mgl-10" style="height: 40px;" src="${ctx}/sys/randCodeImage" /> 
									    </dd>
										<dd class="notice" id="imgcode_notice"></dd>
									</dl>
									<dl class="us-info-dl clearfix">
										<dt class="fl">&nbsp;</dt>
										<dd class="fl">
										<div class="us-btn" id="submitInfo">保存个人信息</div>
										</dd>
									</dl>		
								</dd>
							</dl>
						</div>
						<!--基本信息 E-->
                        <!--更改密码 S-->
						<div class="box hidden">
                        
                            	<dl class="us-base-info  mgt-30">
								
                                    <dd class="info-box">
                                    
                                     
                                        <dl  class="us-info-dl clearfix">
                                            <dt class="fl">原始密码：</dt>
                                            <dd class="fl"><input class="iph" type="password" id="oldPwd" /></dd>
                                            <dd class="notice"></dd>
                                        </dl>
                                        <dl  class="us-info-dl clearfix">
                                            <dt class="fl"><span class="brown">*</span>新密码：</dt>
                                            <dd class="fl"><input  type="password" id="newPwd" /></dd>
                                            <dd class="notice"></dd>
                                        </dl>
                                        <dl  class="us-info-dl clearfix">
                                            <dt class="fl"><span class="brown">*</span>再次输入：</dt>
                                            <dd class="fl"><input  type="password" id="surePwd" /></dd>
                                            <dd class="notice"></dd>
                                        </dl>
                                       
                                        <dl class="us-info-dl clearfix">
                                            <dt class="fl">&nbsp;</dt>
                                            <dd class="fl">
                                            <div class="us-btn" id="submitPwd">确定</div>
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

$("#submitInfo").bind("click",submitInfo);
function submitInfo(){
	$("#submitInfo").unbind("click");
	var name = $("#name").val();
	if(name.trim().length==0){
		$("#name_notice").html("姓名不能为空！");
		return false;
	}
	var niceName = $("#nickName").val();
	if(niceName.trim().length==0){
		$("#nickName_notice").html("昵称不能为空！");
		return false;
	}
	var idNum = $("#idNum").val();
	if(idNum.trim().length==0){
		$("#idNum_notice").html("人口号不能为空！");
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
				alert(json.retMsg);
				window.location.href = '${ctx}/userCenter';
			} else {
				var tip = json.retMsg.split(":");
				$("#"+tip[0]+"_notice").html(tip[1]);
				$("#submitInfo").bind("click",userRegist);
			}
		},
		error : function() {
			alert("修改失败");
			$("#submitInfo").bind("click",userRegist);
		}
	});
}
function getRandImg(){
	$('#randCodeImage').attr('src', "${ctx}/sys/randCodeImage?"+Math.random());
}
$("#randCodeImage").click(getRandImg);
</script>

