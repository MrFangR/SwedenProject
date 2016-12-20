/**
 * 后台管理账号 统一校验
 */
var format_userNo = "格式为：6-12位字母或数字，首位必须为字母";
function valid_userNo(userNo){
	// 非空校验
	if (userNo==null || userNo==undefined || userNo.toLowerCase()=="null" || userNo.toLowerCase()=="undefined") {
		return false;
	}
	// 格式校验
	var reg = /^[A-Za-z]{1}[A-za-z0-9]{3,11}$/;
	if (!reg.test(userNo)) {
		return false;
	}
	// 默认返回
	return true;
}

/**
 * 后台管理密码 统一校验
 */
var format_pwd = "格式为：6-12位字母、数字或特殊字符";
function valid_pwd(pwd){
	// 非空校验
	if (pwd==null || pwd==undefined || pwd.toLowerCase()=="null" || pwd.toLowerCase()=="undefined") {
		return false;
	}
	// 格式校验
	if (pwd.length<6 || pwd.length>12) {
		return false;
	}
	// 默认返回
	return true;
}


var pop = {};
/**
 * 正在加载
 * @param m 指定提示语，默认"正在加载..."
 */
pop.loading = function(m){
	if (m==null || m==undefined || m=="") {
		m = "正在加载...";
	}
	// 效果未实现
}
/**
 * 成功弹出框
 * @param m 指定提示语，默认"操作成功"
 * @param func 确定后执行的方法
 */
pop.success = function(m, func){
	if (m==null || m==undefined || m=="") {
		m = "操作成功";
	}
	// 效果未实现
	alert(m);
	if (func!=null && func!=undefined && func!="") {
		eval(func());
	}
}
/**
 * 失败弹出框
 * @param m 指定提示语，默认"操作失败"
 * @param func 确定后执行的方法
 */
pop.fail = function(m, func){
	if (m==null || m==undefined || m=="") {
		m = "操作失败";
	}
	// 效果未实现
	alert(m);
	if (func!=null && func!=undefined && func!="") {
		eval(func());
	}
}
/**
 * 二次确认弹出框
 * @param m 指定提示语，默认"是否继续操作？"
 * @param func 确定后执行的方法
 */
pop.confirm = function(m, func){
	if (m==null || m==undefined || m=="") {
		m = "是否继续操作？";
	}
	// 效果未实现
	if (confirm(m)) {
		if (func!=null && func!=undefined && func!="") {
			eval(func());
		}
	}
}

/**
 * ajax返回过滤
 */
$.ajaxSetup({
	dataFilter: function(data, type){
		if(data.indexOf("NO_PRIV")>-1 || data.indexOf("NO_LOGIN")>-1){
			var jsonMap = JSON.parse(data);
			window.location = ctx + "/back/main/noPriv?flag="+jsonMap.flag;
		}else{
	        return data;
		}
    }
});