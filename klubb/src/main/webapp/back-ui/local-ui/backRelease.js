// 切换类型
var chooseType = "";
function chgType(type){
	chooseType = type;
}
// 切换状态
var chooseStatus = "";
function chgStatus(status){
	chooseStatus = status;
}
// 重置
function reset(){
	$('#PRODUCT_NAME').val("");
	$('#type_select a').first().click();
	$('#status_select a').first().click();
}
// 查询
function qry(pageNum){
	$('.liQuery').click();
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/release/getReleasePage",
		data: {
			'release.PRODUCT_NAME' : $('#PRODUCT_NAME').val(),
			'release.PRODUCT_TYPE' : chooseType,
			'release.STATUS' : chooseStatus,
			pageNum : ((pageNum==undefined || pageNum=="")?1:pageNum),
			pageSize : 6
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
// 翻页
function qry4Page(pageNum){
	qry(pageNum);
}
// 拒绝
function refuse(){
	var releaseInfo = $(":radio[name='releaseInfo']:checked").val();
	if (releaseInfo==null || releaseInfo==undefined || releaseInfo=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var releaseId = releaseInfo.split("_")[0];
	pop.confirm("是否确认拒绝发布该申请？", function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/release/refuseRelease",
			data: {
				releaseId : releaseId
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
// 恢复申请
function renew(){
	var releaseInfo = $(":radio[name='releaseInfo']:checked").val();
	if (releaseInfo==null || releaseInfo==undefined || releaseInfo=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var releaseId = releaseInfo.split("_")[0];
	pop.confirm("是否确认恢复该申请？", function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/release/renewRelease",
			data: {
				releaseId : releaseId
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
// 快速发布
function toRelease(){
	var releaseInfo = $(":radio[name='releaseInfo']:checked").val();
	if (releaseInfo==null || releaseInfo==undefined || releaseInfo=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var r = releaseInfo.split("_");
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/release/getReleaseInfo",
		data: {
			releaseId : r[0]
		},
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				if (r[1] == 1) {
					location.href = ctx + "/back/shop/add?releaseId=" + r[0];
				} else if (r[1] == 2) {
					location.href = ctx + "/back/pro/fastAdd?releaseId=" + r[0];
				} else {
					pop.fail("该申请类型目前无法识别");
				}
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
}