// 切换状态
var chooseStatus = "";
function chgStatus(status){
	chooseStatus = status;
}
// 是否申请置顶
var chooseApplyTop = "";
function chgApplyTop(at){
	chooseApplyTop = at;
}
// 重置
function reset(){
	$('#proName,#pNo,#minPrice,#maxPrice').val("");
	$('#status_select a').first().click();
	$('.catSelect span').removeClass("onS");
}
$(function(){
	qryProject(1);
});
// 查询
function qryProject(pageNum){
	$('.liQuery').click();
	
	var catIds = "";
	var chooseCat = $('.catSelect').find('.onS');
	if (chooseCat.length > 0) {
		for (var i = 0; i < chooseCat.length; i++) {
			catIds += ($(chooseCat[i]).attr("value")+',');
		}
	}
	
	var minPrice = $('#minPrice').val();
	if (minPrice != "") {
		minPrice = parseFloat(minPrice)*10000;
	}
	var maxPrice = $('#maxPrice').val();
	if (maxPrice != "") {
		maxPrice = parseFloat(maxPrice)*10000;
	}
	if (minPrice > maxPrice) {
		pop.fail("最低投资额不得高于最高投资额");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/pro/getProPage",
		data: {
			'qryPro.PROJECT_NAME' : $('#proName').val(),
			'qryPro.P_USER_NO' : $('#pNo').val(),
			'qryPro.STATUS' : chooseStatus,
			'qryPro.MIN_PRICE' : minPrice,
			'qryPro.MAX_PRICE' : maxPrice,
			'qryPro.TOP_STATUS' : chooseApplyTop,
			catIds : catIds,
			pageNum : ((pageNum==undefined || pageNum=="")?1:pageNum),
			pageSize : 80
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
	qryProject(pageNum);
}

//置顶/下顶/拒绝置顶
function updTopStatus(topReq){
	var proId = $(":radio[name='proId']:checked").val();
	if (proId==null || proId==undefined || proId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmTip = "是否确认操作？";
	if (topReq == 0) {
		confirmTip = "是否确认下顶该项目？\n提示：提前下顶积分不返还";
	} else if (topReq == 1) {
		confirmTip = "是否确认置顶该项目？";
	} else if (topReq == 2) {
		confirmTip = "是否确认对该项目拒绝置顶？";
	}
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'get',
			cache : false,
			async : true,
			url : ctx + "/back/pro/updTopStatus",
			data: {
				proId : proId,
				topReq : topReq
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryProject();
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
// 下架/激活
function updStatus(statusReq){
	var proId = $(":radio[name='proId']:checked").val();
	if (proId==null || proId==undefined || proId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmTip = "是否确认操作？";
	if (statusReq == 7) {
		confirmTip = "是否确认下架该项目？（再次上架需重新走审批流程）";
	} else if (statusReq == 2) {
		confirmTip = "是否确认激活该项目？激活后将进入审批流程";
	}
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/pro/updStatus",
			data: {
				proId : proId,
				statusReq : statusReq
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryProject();
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
function updRecommend(recommendReq){
	var proId = $(":radio[name='proId']:checked").val();
	if (proId==null || proId==undefined || proId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmTip = "是否确认操作？";
	if (recommendReq == 1) {
		confirmTip = "是否确认推荐该项目？";
	} else if (recommendReq == 0) {
		confirmTip = "是否确认取消推荐该项目？";
	}
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/pro/updRecommend",
			data: {
				proId : proId,
				recommendReq : recommendReq
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryProject();
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
	var proId = $(":radio[name='proId']:checked").val();
	if (proId==null || proId==undefined || proId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	location.href = ctx + "/back/pro/detail?proId=" + proId;
}