// 切换快速悬赏类型
function chgQuickXsKind(kind){
	$('#quick_xs_kind_q').val(kind);
}
// 切换快速悬赏状态
function chgQuickXsStatus(status){
	$('#quick_xs_status_q').val(status);
}
// 快速悬赏查询条件重置
function resetQryQuickXs(){
	$('#quick_xs_name_q, #quick_xs_phone_q').val("");
	$('#quick_xs_kind_select a').first().click();
	$('#quick_xs_status_select a').first().click();
}
// 快速悬赏查询
function qryQuickXs(){
	$('#qry_quick_xs_form').parent().show();
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getQuickXsPage",
		data: $("#qry_quick_xs_form").serialize(),
		dataType : "html",
		success : function(data){
			$('#qucik_xs_show').html(data);
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
	var tabIndex = $('.js_tab_tit ul li').filter('.on1').index();
	if (tabIndex == 0) {
		$('#quick_xs_page_num_q').val(pageNum);
		qryQuickXs();
	} else if (tabIndex == 1) {
		$('#shop_need_page_num_q').val(pageNum);
		qryShopNeed();
	} else if (tabIndex == 2) {
		$('#shop_out_page_num_q').val(pageNum);
		qryShopOut();
	} else if (tabIndex == 3) {
		$('#offer_shop_page_num_q').val(pageNum);
		qryOfferShop();
	} else if (tabIndex == 4) {
		$('#offer_need_page_num_q').val(pageNum);
		qryOfferNeed();
	}
}
// 快速悬赏详情
function detailQuickXs(){
	var quickXsId = $(":radio[name='quickXsId']:checked").val();
	if (quickXsId==null || quickXsId==undefined || quickXsId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getQuickXsDetail",
		data: {
			quickXsId : quickXsId
		},
		dataType : "html",
		success : function(data){
			$('#qry_quick_xs_form').parent().hide();// 收起查询条件
			$('#qucik_xs_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 受理快速悬赏
function optQuickXsStatus(statusIn, type){
	var quickXsId = null;
	if (type == 0) {// 从列表页发起
		quickXsId = $(":radio[name='quickXsId']:checked").val();
	} else {// 从详情页发起
		quickXsId = $('#quickXsId').val();
	}
	if (quickXsId==null || quickXsId==undefined || quickXsId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmTip = "是否确认受理该悬赏？";
	if (statusIn == 1) {
		confirmTip = "是否确认激活该悬赏？";
	}
	
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/xs/optQuickXsStatus",
			data: {
				quickXsId : quickXsId,
				statusIn : statusIn
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryQuickXs();
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



/*##################################################################*/
// 切换悬赏找铺状态
function chgShopNeedStatus(status){
	$('#shop_need_status_q').val(status);
}
// 悬赏找铺查询条件重置
function resetQryShopNeed(){
	$('#shop_need_NEEDDES_q, #shop_need_NAME_q, #shop_need_PHONE_q').val("");
	$('#shop_need_status_select a').first().click();
}
// 悬赏找铺查询
function qryShopNeed(){
	$('#qry_shop_need_form').parent().show();
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getShopNeedPage",
		data: $("#qry_shop_need_form").serialize(),
		dataType : "html",
		success : function(data){
			$('#shop_need_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 悬赏找铺详情
function detailShopNeed(){
	var shopNeedId = $(":radio[name='shopNeedId']:checked").val();
	if (shopNeedId==null || shopNeedId==undefined || shopNeedId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getShopNeedDetail",
		data: {
			id : shopNeedId
		},
		dataType : "html",
		success : function(data){
			$('#qry_shop_need_form').parent().hide();// 收起查询条件
			$('#shop_need_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 受理悬赏找铺
function optShopNeedStatus(f, type){
	var shopNeedId = null;
	if (type == 0) {// 从列表页发起
		shopNeedId = $(":radio[name='shopNeedId']:checked").val();
	} else {// 从详情页发起
		shopNeedId = $('#shopNeedId').val();
	}
	if (shopNeedId==null || shopNeedId==undefined || shopNeedId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var notes = $('#shop_need_NOTES').val();
	if (notes == '') {
		pop.fail("请输入审核意见");
		$('#shop_need_NOTES').focus();
		return;
	}
	var confirmTip = "是否确认受理该悬赏？";
	if (f == 2) {
		confirmTip = "是否确认审核通过该悬赏？";
	} else if (f == 3) {
		confirmTip = "是否确认审核不通过该悬赏？";
	} else if (f == 1) {
		confirmTip = "是否确认激活该悬赏？";
	} else {
		pop.fail("状态标识错误，请稍后重试");
		return;
	}
	
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/xs/optShopNeedStatus",
			data: {
				shopNeedId : shopNeedId,
				statusIn : f,
				notes : notes
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryShopNeed();
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



//=============================================================
// 切换悬赏出铺状态
function chgShopOutStatus(status){
	$('#shop_out_status_q').val(status);
}
// 悬赏出铺查询条件重置
function resetQryShopOut(){
	$('#shop_out_XSNAME_q, #shop_out_NAME_q, #shop_out_SHOPNAME_q').val("");
	$('#shop_out_status_select a').first().click();
}
// 悬赏出铺查询
function qryShopOut(){
	$('#qry_shop_out_form').parent().show();
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getShopOutPage",
		data: $("#qry_shop_out_form").serialize(),
		dataType : "html",
		success : function(data){
			$('#shop_out_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 悬赏出铺详情
function detailShopOut(){
	var shopOutId = $(":radio[name='shopOutId']:checked").val();
	if (shopOutId==null || shopOutId==undefined || shopOutId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getShopOutDetail",
		data: {
			id : shopOutId
		},
		dataType : "html",
		success : function(data){
			$('#qry_shop_out_form').parent().hide();// 收起查询条件
			$('#shop_out_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 受理悬赏出铺
function optShopOutStatus(f, type){
	var shopOutId = null;
	if (type == 0) {// 从列表页发起
		shopOutId = $(":radio[name='shopOutId']:checked").val();
	} else {// 从详情页发起
		shopOutId = $('#shopOutId').val();
	}
	if (shopOutId==null || shopOutId==undefined || shopOutId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var notes = $('#shop_out_NOTES').val();
	if (notes == '') {
		pop.fail("请输入审核意见");
		$('#shop_out_NOTES').focus();
		return;
	}
	var confirmTip = "是否确认受理该悬赏？";
	if (f == 2) {
		confirmTip = "是否确认审核通过该悬赏？";
	} else if (f == 3) {
		confirmTip = "是否确认审核不通过该悬赏？";
	} else if (f == 1) {
		confirmTip = "是否确认激活该悬赏？";
	} else {
		pop.fail("状态标识错误，请稍后重试");
		return;
	}
	
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/xs/optShopOutStatus",
			data: {
				id : shopOutId,
				statusIn : f,
				notes : notes
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryShopOut();
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



//-------------------------------------------------------------------
//切换提供商铺状态
function chgOfferShopStatus(status){
	$('#offer_shop_status_q').val(status);
}
// 提供商铺查询条件重置
function resetQryOfferShop(){
	$('#offer_shop_NAME_q').val("");
	$('#offer_shop_status_select a').first().click();
}
// 提供商铺查询
function qryOfferShop(){
	$('#qry_offer_shop_form').parent().show();
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getOfferShopPage",
		data: $("#qry_offer_shop_form").serialize(),
		dataType : "html",
		success : function(data){
			$('#offer_shop_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 提供商铺详情
function detailOfferShop(){
	var offerShopId = $(":radio[name='offerShopId']:checked").val();
	if (offerShopId==null || offerShopId==undefined || offerShopId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getOfferShopDetail",
		data: {
			id : offerShopId
		},
		dataType : "html",
		success : function(data){
			$('#qry_offer_shop_form').parent().hide();// 收起查询条件
			$('#offer_shop_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 受理提供商铺
function optOfferShopStatus(f, type){
	var offerShopId = null;
	if (type == 0) {// 从列表页发起
		offerShopId = $(":radio[name='offerShopId']:checked").val();
	} else {// 从详情页发起
		offerShopId = $('#offerShopId').val();
	}
	if (offerShopId==null || offerShopId==undefined || offerShopId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var notes = $('#offer_shop_NOTES').val();
	if (notes == '') {
		pop.fail("请输入审核意见");
		$('#offer_shop_NOTES').focus();
		return;
	}
	var confirmTip = "是否确认受理该需求？";
	if (f == 2) {
		confirmTip = "是否确认审核通过该需求？";
	} else if (f == 3) {
		confirmTip = "是否确认审核不通过该需求？";
	} else if (f == 1) {
		confirmTip = "是否确认激活该需求？";
	} else {
		pop.fail("状态标识错误，请稍后重试");
		return;
	}
	
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/xs/optOfferShopStatus",
			data: {
				id : offerShopId,
				statusIn : f,
				notes : notes
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryOfferShop();
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




//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// 切换提供需求状态
function chgOfferNeedStatus(status){
	$('#offer_need_status_q').val(status);
}
// 提供需求查询条件重置
function resetQryOfferNeed(){
	$('#offer_need_OFFERNEEDNAME_q, #offer_need_NAME_q').val("");
	$('#offer_need_status_select a').first().click();
}
// 提供需求查询
function qryOfferNeed(){
	$('#qry_offer_need_form').parent().show();
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getOfferNeedPage",
		data: $("#qry_offer_need_form").serialize(),
		dataType : "html",
		success : function(data){
			$('#offer_need_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 提供需求详情
function detailOfferNeed(){
	var offerNeedId = $(":radio[name='offerNeedId']:checked").val();
	if (offerNeedId==null || offerNeedId==undefined || offerNeedId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/xs/getOfferNeedDetail",
		data: {
			id : offerNeedId
		},
		dataType : "html",
		success : function(data){
			$('#qry_offer_need_form').parent().hide();// 收起查询条件
			$('#offer_need_show').html(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
// 受理提供需求
function optOfferNeedStatus(f, type){
	var offerNeedId = null;
	if (type == 0) {// 从列表页发起
		offerNeedId = $(":radio[name='offerNeedId']:checked").val();
	} else {// 从详情页发起
		offerNeedId = $('#offerNeedId').val();
	}
	if (offerNeedId==null || offerNeedId==undefined || offerNeedId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var notes = $('#offer_need_NOTES').val();
	if (notes == '') {
		pop.fail("请输入审核意见");
		$('#offer_need_NOTES').focus();
		return;
	}
	var confirmTip = "是否确认受理该需求？";
	if (f == 2) {
		confirmTip = "是否确认审核通过该需求？";
	} else if (f == 3) {
		confirmTip = "是否确认审核不通过该需求？";
	} else if (f == 1) {
		confirmTip = "是否确认激活该需求？";
	} else {
		pop.fail("状态标识错误，请稍后重试");
		return;
	}
	pop.confirm(confirmTip, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/xs/optOfferNeedStatus",
			data: {
				id : offerNeedId,
				statusIn : f,
				notes : notes
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						qryOfferNeed();
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