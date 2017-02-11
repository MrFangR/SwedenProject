$(function(){
	qryAct(1);
});
//查询
function qryAct(pageNum){
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/activity/list",
		data: $("#qryForm").serialize(),
		dataType : "html",
		success : function(data){
			$('#showList').html(data);
			return;
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示消息',
						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
						'ok':function(){return;},
						tag:'cw-ring'}
		               );
			return;
		}
	});
}
//翻页
function qry4Page(pageNum){
	qryAct(pageNum);
}
//重置
function reset(){
	$('#titleIn, #authorIn, #cUserNoIn').val('');
	$('#statusSelect a').first().click();
	qryAct(1);
}
//编辑
function edit(){
	var activityID = $(":radio[name='activityID']:checked").val();
	if (activityID==null || activityID==undefined || activityID=="") {
		ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'提示消息',
					text:'<div style=" font-size:18px; color:#ff0000;">请选择要操作的记录.</div>',
					'ok':function(){return;},
					tag:'tx-ring'}
	               );
		return;
	}
	location.href=ctx + "/back/activity/edit?type=" + activityID;
}
//发布
function release(){
	location.href=ctx + "/back/activity/add";
}
//删除
function deleteAct(ID,status){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/activity/deleteAct",
		data: {
			actID : ID
		},
		dataType : "html",
		success : function(data){
			location.href=ctx + "/back/activity";
			return
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示消息',
						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
						'ok':function(){return;},
						tag:'cw-ring'}
		               );
			return;
		}
	});
}
//隐藏
function hideAct(ID,status){
	if(status == 2){
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/activity/hideAct",
		data: {
			actID : ID
		},
		dataType : "html",
		success : function(data){
			location.href=ctx + "/back/activity";
			return
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示消息',
						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
						'ok':function(){return;},
						tag:'cw-ring'}
		               );
			return;
		}
	});
}
//重新发布
function ReRelease(ID,status){
	if(status == 1){
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/activity/reReleaseAct",
		data: {
			actID : ID
		},
		dataType : "html",
		success : function(data){
			location.href=ctx + "/back/activity";
			return
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
//查看活动
function viewAct(ID){
	location.href=ctx + "/back/activity/viewAct?type=" + ID;
}
