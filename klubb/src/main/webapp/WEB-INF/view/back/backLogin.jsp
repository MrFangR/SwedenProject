<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>后台管理系统</title>
    <%@include file="/ninclude/back/header.jsp"%>
</head>

<body>
	<div class="ued-head">
		<div class="ued-logo fl mgl-30">后台管理系统</div>
	</div>
	
	<div class="login-bg">
		<div class="lo-wrap">
			<p class="lo-title fs-20">系统登录</p>
			<p class="color-3 mgt-10" id="tip"></p>
			<div class="login_box">
	            <div class="login-p">
	                <label class="icon-person"></label>
	                <input type="text" id="userNo_input" name="userName" maxlength="16"/>
	            </div>
	            <div>
	                <div class="login-p last">
	                    <label class="icon-yzm"></label>
	                    <input type="password" id="pwd_input" name="pwd" maxlength="16"/>
	                </div>
	            </div>
	        </div>
	        <div class="clearfix mgt-10">
	        	<input type="text" id="imgcode_input" name="imgcode" maxlength="4" class="ued-input fl" style="width:110px;"/>
	        	<img id="randCodeImage" class="mgl-10" style="height: 40px;" src="${ctx}/sys/randCodeImage" />
	        	<a href="javascript:getRandImg();" class="fr login-a mgt-10">看不清?换一张</a>
	        </div>
	        <%--<div class="mgt-10 mgb-10">
	        	<a id="resetpwd" href="javascript:void();" class="fr login-a mgb-10">忘记密码?</a>
	        </div>                
	        --%>
	        <button id="login_btn" class="ued-button mgt-20">登录</button>
		</div>
	</div>

	<div class="login-foot">
		
	</div>
</body>

<script type="text/javascript" src="${ctx}/back-ui/local-ui/backLogin.js"></script>
</html>
