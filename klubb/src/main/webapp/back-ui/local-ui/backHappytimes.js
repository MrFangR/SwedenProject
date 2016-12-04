$(function(){
	qry(1);
});
// 查询
function qry(pageNum){
	$('#pageNum').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/happytimes/list",
		data: {"pageNum" : $("#pageNum").val()},
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

function updateRecommend(self, picId){
	var isRecommend = 0;
	if(self.checked){
		isRecommend = 1;
	}
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/happytimes/updateRecommend",
		data: {
			"picId" : picId,
			"isRecommend" : isRecommend
		},
		dataType : "json",
		success : function(json){
			alert(json.msg);
			return;
		},
		error : function(){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}