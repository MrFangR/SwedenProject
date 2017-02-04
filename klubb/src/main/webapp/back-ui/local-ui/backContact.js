function chgStatus(t){
	$('#status').val(t);
}
// 重置
function reset(){
	$('#phone').val('');
	$('#statusSelect a').first().click();
}
$(function(){
	$('.liQuery').click();
	qry(1);
});
// 查询
function qry(pageNum){
	$('#pageNum').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/contact/search",
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
function updateStatus(f, contactId){
//	var newsId = $(":radio[name='contactId']:checked").val();
	if (contactId==null || contactId==undefined || contactId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 0) {
		confirmMsg = "是否确认将此留言标记为未读？";
	} else if (f == 1){
		confirmMsg = "是否确认将此留言标记为已读？";
	} else {
		pop.fail("操作标识获取失败，请稍后重新操作");
		return;
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/contact/updateStatus",
			data: {
				contactId : contactId,
				status : f
			},
			dataType : "json",
			success : function(json){
                var type = "cw-ring";
                if (json.flag == 0) {
                    type = "zq-ring";
                    qry(1);
                }
                ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
                    {type:2,
                        info:'留言管理',
                        text:'<div style=" font-size:18px; color:#ff0000;"> '+json.msg+' </div>',
                        'ok':function(){},
                        tag:type}
                );
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
