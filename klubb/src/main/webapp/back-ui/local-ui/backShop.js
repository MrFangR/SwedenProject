// 切换状态
var chooseStatus = "";
function chgStatus(s){
	chooseStatus = s;
}
// 切换 全景图条件
var has3D = "";
function chg3D(s){
	has3D = s;
}
// 重置
function reset(){
	$('#status_select a').first().click();
	$('#has3D_select a').first().click();
	$('#shopName,#pNo,#ownerName').val("");
	$('.catSelect span').removeClass("onS");
}
$(function(){
	qry(1);
});
// 查询
function qry(pageNum){
	$('.liQuery').click();
	
	var catIds = "";
	var chooseCat = $('.catSelect').find('.onS');
	if (chooseCat.length > 0) {
		for (var i = 0; i < chooseCat.length; i++) {
			catIds += ($(chooseCat[i]).attr("value")+',');
		}
	}
	
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/shop/getShopPage",
		data: {
			'qryShop.SHOP_NAME' : $('#shopName').val(),
			'qryShop.STATUS' : chooseStatus,
			catIds : catIds,
			'qryShop.P_USER_NO' : $('#pNo').val(),
			'qryShop.OWNER_NAME' : $('#ownerName').val(),
			has3D : has3D,
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
	qry(pageNum);
}
// 下架/激活
function updStatus(statusIn){
	var shopId = $(":radio[name='shopId']:checked").val();
	if (shopId==null || shopId==undefined || shopId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmTip = "是否确认操作？";
	if (statusIn == 7) {
		confirmTip = "是否确认下架该商铺？（再次上架需重新走审批流程）";
	} else if (statusIn == 2) {
		confirmTip = "是否确认激活该商铺？激活后将进入审批流程";
	} else if (statusIn == 9) {
		confirmTip = "是否确认该商铺已出租？";
	} else if (statusIn == 5) {
		confirmTip = "是否确认打回该举报？";
	}
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/shop/updStatus",
			data: {
				shopId : shopId,
				status : statusIn
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
//详情
function detail(){
	var shopId = $(":radio[name='shopId']:checked").val();
	if (shopId==null || shopId==undefined || shopId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	location.href = ctx + "/back/shop/edit?id="+shopId;
}