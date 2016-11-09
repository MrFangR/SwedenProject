function chgStatus(t){
	$('#statusIn').val(t);
}
// 重置
function reset(){
	$('#titleIn, #authorIn, #cUserNoIn').val('');
	$('#statusSelect a').first().click();
}
$(function(){
	qry(1);
});
// 查询
function qry(pageNum){
	$('.liQuery').click();
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/news/getNewsPage",
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

// 置为 可用/不可用
function optStatus(f){
	var newsId = $(":radio[name='newsId']:checked").val();
	if (newsId==null || newsId==undefined || newsId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 2) {
		confirmMsg = "是否确认发布该资讯？";
	} else if (f == 3){
		confirmMsg = "是否确认停用该资讯？";
	} else {
		pop.fail("操作标识获取失败，请稍后重新操作");
		return;
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/news/optStatus",
			data: {
				newsId : newsId,
				statusReq : f
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
// 推荐/取消推荐
function optRecommend(f){
	var newsId = $(":radio[name='newsId']:checked").val();
	if (newsId==null || newsId==undefined || newsId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 0) {
		confirmMsg = "是否确认取消推荐该资讯？";
	} else if (f == 1){
		confirmMsg = "是否确认推荐该资讯？";
	} else {
		pop.fail("操作标识获取失败，请稍后重新操作");
		return;
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/news/optRecommend",
			data: {
				newsId : newsId,
				recommendReq : f
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

// 详情
function detail(){
	var newsId = $(":radio[name='newsId']:checked").val();
	if (newsId==null || newsId==undefined || newsId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	location.href=ctx + "/back/news/edit?id=" + newsId;
}
