// 在使用中 变量 ctx 需要在调用的 jsp 当中定义  ctx = “${ctx}” 
//弹出跳转登录页面
//有母页的登录
function popLogin(){
	//补充登录页面
	$.ajax({
		url : ctx+"/sys/toLogin",
		type : 'post',
		async: false,//使用同步的方式,true为异步方式
		success : function(rtnObj){
			ui_com_hallpop(".js_login_btn","#ands_misoAlert_close","#ands-miso-popAlert",{type:6,info:'用户登录',text:rtnObj,mywidth:"500",});
		}
	});
}
//无母页的登录
function popLoginByMa(){
	//补充登录页面
	$.ajax({
		url : ctx+"/sys/toLogin",
		type : 'post',
		async: false,//使用同步的方式,true为异步方式
		data: {toUrl: toUrl},
		success : function(rtnObj){
			ui_com_hallpop(".js_login_btn","#ands_misoAlert_close","#ands-miso-popAlert",{type:6,info:'用户登录',text:rtnObj,mywidth:"500",});
		}
	});
}
//提交账号密码提交
function loginSub(){
	var loginname = $.trim($("#loginname").val());
    var password = $.trim($("#password").val());
    if(loginname==null || "" == loginname){
    	$("#loginname").parent().next(".notice").html("用户名不能为空！");
    	return false;
    }else if(jST.isHavIllChar(loginname)){
    	$("#loginname").parent().next(".notice").html("用户名不能为非法字符！ ");
    	return false;
    }
    if(password==null ||"" == password){
    	$("#password").parent().next(".notice").html("密码不能为空！");
    	return false;
    }
	$.ajax({
    	type: "post",
		url:ctx+"/sys/login",
		async: false,
		data: $("#loginForm").serialize(),
		success : function(json){
			var result = json.flag;
			if (result=='success') {
				var toUrl = json.toUrl;
				var bool = toUrl.indexOf("quickPost");
				if(bool > 0){//补充快速发布情况,需弹出快速发布框
					location.href=ctx;
					return;
				}
				
				if(toUrl!=null && toUrl.length > 1){
					location.href = ctx+toUrl;
				}else{
					location.href=ctx+"/myCentre";
				}
			} else {
				$("#password").parent().next(".notice").html(json.Msg);
				return;
			}
		},
		error : function(json){
			$("#loginSub").parent().next(".notice").html("系统异常，请稍后重试  json="+json.Msg);
			location.href=ctx;
		}
	  });
}
//短信下发
function postSms(){
	$.ajax({
    	type: "post",
		url:ctx+"/sys/postSms",
		async: false,
		data: $("#loginBySmsForm").serialize(),
		success : function(json){
			var result = json.flag;
			if (result=='0') {
				$("#postSmsBut").parent().next(".notice").html(json.Msg);
				$("#postSmsBut").attr("disabled","true");
				timeCount(60);
			} else {
				$("#postSmsBut").parent().next(".notice").html(json.Msg);
				location.href=ctx;
			}
		},
		error : function(json){
			$("#postSmsBut").parent().next(".notice").html("系统异常，请稍后重试  json="+json);
			location.href=ctx;
		}
	  });
}
//倒计时
function timeCount(i){
	  i--;
	 if(i==0){
		 $("#postSmsBut").attr("disabled","false");
		 $("#postSmsBut").attr("value","获取短信验证码");
	 }else{
	  	$("#postSmsBut").attr("value","倒计时："+i);
	  	setTimeout("timeCount("+i+")",1000);
	 }
}
function loginSubSms(){
	$.ajax({
    	type: "post",
		url:ctx+"/sys/loginSms",
		async: false,
		data: $("#loginBySmsForm").serialize(),
		success : function(json){
			var result = json.flag;
			if (result=='0') {
				var toUrl = json.toUrl;
				var bool = toUrl.indexOf("quickPost");
				if(bool > 0){//补充快速发布情况,需弹出快速发布框
					location.href=ctx;
					return;
				}
				if(toUrl!=null && toUrl.length > 1){
					location.href = ctx+toUrl;
				}else{
					location.href=ctx+"/myCentre";
				}
			} else {
				$("#postSmsBut").parent().next(".notice").html(json.Msg);
				return ;
			}
		},
		error : function(json){
			$("#loginSubSms").parent().next(".notice").html("系统异常，请稍后重试  json="+json);
			location.href=ctx;
		}
	  });
}

function logout(){
	$.ajax({
    	type: "post",
		url:ctx+"/sys/logout",
		async: false,
		success : function(json){
			var result = json.flag;
			if (result=='0') {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'退出',
					text:'<div style=" font-size:18px; color:#ff0000;"> 您已安全退出，欢迎再次光临！ </div>',
					'ok':function(){
						location.href=ctx;
					},
					tag:'zq-ring'}
		           );
			} 
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'退出',
				text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试  json= '+json+' </div>',
				'ok':function(){
					location.href=ctx;
				},
				tag:'cw-ring'}
	           );
		}
	  });
}