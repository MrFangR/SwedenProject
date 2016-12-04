$(function(){
	$('.liQuery').click();
	qry();
});
// 查询
function qry(){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/introduce/list",
		data: {},
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


// 详情
function edit(introId){
//	var introId = $(":radio[name='introduceId']:checked").val();
//	if (introId==null || introId==undefined || introId=="") {
//		pop.fail("请选择要操作的记录");
//		return;
//	}
	location.href=ctx + "/back/introduce/edit?type=" + introId;
}
