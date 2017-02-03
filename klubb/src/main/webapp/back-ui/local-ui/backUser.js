$(function(){
	qryUser(1);
	$("#submitUser").bind("click",function(){
		var name = $('#user_name').val();
		if(name=='' || name.length <1){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'用户管理',
				text:'<div style=" font-size:18px; color:#ff0000;"> 姓名不能为空 </div>',
				'ok':function(){},
				tag:'cw-ring'}
               );
			return false;
		}
		$.ajax({
			type : 'get',
			cache : false,
			async : true,
			url : ctx + "/back/user/addUser",
			data: {
				'user_name' : $('#user_name').val()
			},
			dataType : "json",
			success : function(data){
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'用户管理',
					text:'<div style=" font-size:18px; color:#ff0000;"> '+data.retMsg+' </div>',
					'ok':function(){
						if(data.retCode == '0'){
							$("#btn-dialog").trigger("dialog-close");
							qryUser(1);
						}
					},
					tag:'zq-ring'}
	               );
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
	});
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

function resetQry(){
	$("#titleIn").val("");
	qryUser(1);
}

function delUser(id,name){
	ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
	   {type:2,
		info:'用户管理',
		text:'<div style=" font-size:18px; color:#ff0000;"> 确定要删除用户：'+name+'，此删除不可恢复。</div>',
		'ok':function(){
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
			
		},
		tag:'tx-ring'}
    );
	
}

function viewUser(id){
	location.href=ctx + "/back/user/viewUser?userId=" + id;
}