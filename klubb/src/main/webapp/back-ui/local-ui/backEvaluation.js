function chgObjType(t){
	$('#objTypeIn').val(t);
}
function chgOptType(t){
	$('#optTypeIn').val(t);
}
function chgStatus(t){
	$('#statusIn').val(t);
}
// 重置
function reset(){
	$('#userNoIn').val('');
	$('#objTypeSelect a').first().click();
	$('#optTypeSelect a').first().click();
	$('#statusSelect a').first().click();
}
// 查询
function qry(pageNum){
	$('.liQuery').click();
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/evaluation/getEvaluationPage",
		data: $("#qryForm").serialize(),
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
	qry(pageNum);
}
// 接受/拒绝
function opt(f){
	var evalId = $(":radio[name='evalId']:checked").val();
	if (evalId==null || evalId==undefined || evalId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 1) {
		confirmMsg = "是否确认接受该举报或纠错？";
	} else {
		confirmMsg = "是否确认拒绝该举报或纠错？";
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/evaluation/optStatus",
			data: {
				evalId : evalId,
				optFlag : f
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qry();
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
	});
}