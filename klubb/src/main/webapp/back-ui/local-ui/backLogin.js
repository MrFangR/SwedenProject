var welcome_msg = "欢迎使用后台管理系统";
var userNo_msg = "请输入登录账号";
var userNo_null_msg = "登录账号不可为空，请输入";
var userNo_error_msg = "登录账号格式错误，请重新输入";
var pwd_null_msg = "登录密码不可为空，请输入";
var pwd_error_msg = "登录密码格式错误，请重新输入";
var imgcode_null_msg = "验证码不可为空，请输入";
var imgcode_error_msg = "验证码格式错误，请重新输入";

$(function(){
	if (top.location.href != self.location.href) {
		top.location.href = self.location.href;
		return;
	}
	
	$('#tip').text(welcome_msg);
	$('#userNo_input').val(userNo_msg);
	//getRandImg();
});

function getRandImg(){
	$('#randCodeImage').attr('src', ctx+"/sys/randCodeImage?"+Math.random());
}

$('#userNo_input').focus(function(){
	if ($(this).val().trim() == userNo_msg) {
		$(this).val("");
	}
}).blur(function(){
	if ($(this).val().trim() == "") {
		$('#tip').text(userNo_null_msg);
		$(this).val(userNo_msg);
	} else {
		$('#tip').text(welcome_msg);
	}
});

$('#pwd_input').blur(function(){
	if ($(this).val().trim() == "") {
		$('#tip').text(pwd_null_msg);
	} else {
		$('#tip').text(welcome_msg);
	}
});

$('#imgcode_input').blur(function(){
	if ($(this).val().trim() == "") {
		$('#tip').text(imgcode_null_msg);
	}
});

$('#login_btn').click(function(){
	// 取值
	var userNo = $('#userNo_input').val().trim();
	var pwd = $('#pwd_input').val().trim();
	var imgcode = $('#imgcode_input').val().trim();
	
	// 前台校验 start
	// 登录账号
	if (userNo==null || userNo=="" || userNo==userNo_msg) {
		$('#tip').text(userNo_null_msg);
		$('#userNo_input').focus();
		return;
	} else if (!valid_userNo(userNo)) {
		$('#tip').text(userNo_error_msg);
		$('#userNo_input').focus();
		return;
	}
	// 登录密码
	if (pwd==null || pwd=="") {
		$('#tip').text(pwd_null_msg);
		$('#pwd_input').focus();
		return;
	} else if (!valid_pwd(pwd)) {
		$('#tip').text(pwd_error_msg);
		$('#pwd_input').focus();
		return;
	}
	// 验证码
	if (imgcode==null || imgcode=="") {
		$('#tip').text(imgcode_null_msg);
		$('#imgcode_input').focus();
		return;
	} else if (imgcode.length != 4) {
		$('#tip').text(imgcode_error_msg);
		$('#imgcode_input').focus();
		return;
	}
	$('#tip').text("正在验证登录信息，请稍后...");
	// 前台校验 end
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/login",
		data: {
			userNo : userNo,
			pwd : pwd,
			imgCode : imgcode
		},
		dataType : "json",
		success : function(json){
			var result = json.flag;
			if (result == 0) {
				$('#tip').text("登录信息验证通过，正在加载页面，请稍后...");
				location.href = ctx + "/back/main/init";
			} else {
				$('#tip').text(json.msg);
				getRandImg();
			}
			return;
		},
		error : function(json){
			$('#tip').text("系统异常，请稍后重试");
			return;
		}
	});
});

$("#imgcode_input").bind("keydown", function(e){
	if (e.which == 13) {
		$("#login_btn").click();
	}
});