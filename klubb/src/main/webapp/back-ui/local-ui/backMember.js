function chgStatus(t){
	$('#statusIn').val(t);
}
function chgVip(t){
	$('#isvipIn').val(t);
}
// 重置
function reset(){
	$('#userNoIn, #userNameIn, #phoneIn').val('');
	$('#statusSelect a').first().click();
	$('#vipSelect a').first().click();
}
// 查询
function qry(pageNum){
	$('.liQuery').click();
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/member/getMemberPage",
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
	var memberId = $(":radio[name='memberId']:checked").val();
	if (memberId==null || memberId==undefined || memberId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 0) {
		confirmMsg = "是否确认将该用户恢复为可用状态？";
	} else if (f == 1){
		confirmMsg = "是否确认将该用户置为不可用状态？";
	} else {
		pop.fail("操作标识获取失败，请稍后重新操作");
		return;
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/member/optStatus",
			data: {
				memberId : memberId,
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

// 详情
function detail(){
	if($('li').filter(".detail").length > 0){
		pop.fail("请先关闭正在打开的详情面板", function(){
			$('li').filter(".detail").click();
		});
		return;
	}
	var memberId = $(":radio[name='memberId']:checked").val();
	if (memberId==null || memberId==undefined || memberId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/member/getInfo",
		data: {
			memberId : memberId
		},
		dataType : "html",
		success : function(data){
			var detailLi = "<li id='lilast' class='detail'>"
				  + "<a class='ued-revamp' href='javascript:void(0)'>查看详情</a>"
				  + "<span class='ued-tabClose'></span>"
				  + "</li>";
			$(".js_tab_tit .ued-tab-1").append(detailLi);
			$(".ued-tab-con").append(data);
			$('li').filter(".detail").click();
			return;
		},
		error : function(){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}

// 积分操作
function optPoint(){
	if($('li').filter(".point").length > 0){
		pop.fail("请先关闭正在打开的详情面板", function(){
			$('li').filter(".point").click();
		});
		return;
	}
	var memberId = $(":radio[name='memberId']:checked").val();
	if (memberId==null || memberId==undefined || memberId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/member/toOptPoint",
		data: {
			memberId : memberId
		},
		dataType : "html",
		success : function(data){
			var pointLi = "<li id='lilast' class='point'>"
				+ "<a class='ued-revamp' href='javascript:void(0)'>积分操作</a>"
				+ "<span class='ued-tabClose'></span>"
				+ "</li>";
			$(".js_tab_tit .ued-tab-1").append(pointLi);
			$(".ued-tab-con").append(data);
			$('li').filter(".point").click();
			return;
		},
		error : function(){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}

// VIP操作
function optVip(f){
	var memberId = $(":radio[name='memberId']:checked").val();
	if (memberId==null || memberId==undefined || memberId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 0) {
		confirmMsg = "是否确认将该用户置为VIP？";
	} else if (f == 1){
		confirmMsg = "是否确认取消该用户VIP？";
	} else {
		pop.fail("操作标识获取失败，请稍后重新操作");
		return;
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/member/optVip",
			data: {
				memberId : memberId,
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

// 关闭面板事件
$(".ued-tabClose").die("click").live("click",function(){	
	var thisPaneClass = $(this).parent().attr("class");
	$("."+thisPaneClass).remove();
	$(".ued-tab-con ."+thisPaneClass).remove();
	setSelect($(".liQuery")[0]);
});


// 操作类型切换
function chgTranType(t){
	$('#opt_tran_type_input').val(t);
}

// 积分操作面板重置
function resetPoint(){
	$('#tranTypeSelect a').first().click();
	$('#opt_amount_input, #opt_tran_desc_input').val('');
	
}

// 积分操作提交
function savePoint(){
	pop.confirm("是否确认积分操作？", function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/member/optPoint",
			data: $("#optForm").serialize(),
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qry();
						$('li').filter(".point").find('.ued-tabClose').click();
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