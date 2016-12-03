$(function(){
	qryUser(1);
});
// 查询
function qryUser(pageNum){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/user/getUserPage",
		data: {
			'title' : $('#titleIn').val(),
			'pageNum' : ((pageNum==undefined || pageNum=="")?1:pageNum)
		},
		dataType : "html",
		success : function(data){
			$('#showLst').html(data);
			return;
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'用户管理',
				text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
				'ok':function(){},
				tag:'cw-ring'}
               );
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

function delUser(id){
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/user/delUser",
		data: {
			"userId" : id
		},
		dataType : "json",
		success : function(json){
			var flag = json.retCode;
			if (flag == 0) {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'用户管理',
					text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
					'ok':function(){qryUser(1);},
					tag:'zq-ring'}
	               );
				
			} else {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'用户管理',
					text:'<div style=" font-size:18px; color:#ff0000;">'+json.retMsg+'</div>',
					'ok':function(){},
					tag:'cw-ring'}
	               );
			}
			return;
		},
		error : function(){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'用户管理',
				text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
				'ok':function(){},
				tag:'cw-ring'}
               );
			return;
		}
	});
}

function viewUser(id){
	location.href=ctx + "/back/user/viewUser?userId=" + id;
}