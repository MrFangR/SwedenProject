$(function(){
	qryUser();
	$('#userNo_a_tip').text(format_userNo);
	$('#pwd_a_tip').text(format_pwd);
});

var status_q = 0;
// 切换状态
function chgStatus(status){
	status_q = status;
}
// 查询面板重置
function resetQry(){
	$('#userNo_q, #userName_q, #phone_q').val("");
	chgStatus(0);
	$('#statusName_q').text("正常");
}
// 查询
function qryUser(pageNum){
	$('.liQuery').click();
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/user/getUserPage",
		data: {
			'qryUser.USER_NO' : $('#userNo_q').val(),
			'qryUser.USER_NAME' : $('#userName_q').val(),
			'qryUser.PHONE' : $('#phone_q').val(),
			'qryUser.STATUS' : status_q,
			pageNum : ((pageNum==undefined || pageNum=="")?1:pageNum),
			pageSize : 6
		},
		dataType : "html",
		success : function(data){
			$('#showLst').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
//翻页
function qry4Page(pageNum){
	qryUser(pageNum);
}


//////////// add
function chgRoleId_a(rId){
	$('#roleId_a').val(rId);
}

function resetAdd(){
	$('#userNo_a, #userName_a, #roleId_a, #pwd_a, #phone_a').val("");
	$('#roleName_a').text("");
}

function add(){
	var uNo = $("#userNo_a").val();
	if (uNo == "") {
		pop.fail("账号不可为空", function(){$("#userNo_a").focus();});
		return;
	} else if(!valid_userNo(uNo)){
		pop.fail("账号格式错误！"+format_userNo, function(){$("#userNo_a").focus();});
		return;
	}
	var uName = $("#userName_a").val();
	if (uName == "") {
		pop.fail("姓名不可为空", function(){$("#userName_a").focus();});
		return;
	}
	var rId = $('#roleId_a').val();
	if (rId == "") {
		pop.fail("请选择角色");
		return;
	}
	var uPwd = $("#pwd_a").val();
	if (uPwd == "") {
		pop.fail("密码不可为空", function(){$("#pwd_a").focus();});
		return;
	} else if (!valid_pwd(uPwd)){
		pop.fail("密码格式错误！"+format_pwd, function(){$("#pwd_a").focus();});
		return;
	}

	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/user/save",
		data: {
			optType : "A",
			"user.USER_NO" : uNo,
			"user.USER_NAME" : uName,
			"user.PASSWORD" : uPwd,
			"user.PHONE" : $("#phone_a").val(),
			"role.ROLE_ID" : rId
		},
		dataType : "json",
		success : function(json){
			var flag = json.flag;
			if (flag == 0) {
				pop.success(json.msg, function(){
					qryUser();
				});
			} else {
				pop.fail(json.msg);
			}
			return;
		},
		error : function(){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}