//----- qry start -----//
function chgStatus(t){
	$('#statusIn').val(t);
}
// 重置
function reset(){
	$('#chainNameIn, #contactsIn, #phoneNoIn').val('');
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
		url : ctx + "/back/chain/getPage",
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

// 发布/下架
function optStatus(f){
	var optId = $(":radio[name='optId']:checked").val();
	if (optId==null || optId==undefined || optId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 5) {
		confirmMsg = "是否确认发布该连锁公司？";
	} else if (f == 7){
		confirmMsg = "是否确认下架该连锁公司？";
	} else {
		pop.fail("操作标识获取失败，请稍后重新操作");
		return;
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/chain/optStatus",
			data: {
				optId : optId,
				reqFlag : f
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
//----- qry end -----//
///// add start /////
//清空
function resetAdd(){
	$('#addForm input, #addForm textarea').val("");
	$('#addForm img').hide().attr("src","");
}
//清空已选类别
function resetAddCat(){
	$('#addForm .catSelect').find('.onS').removeClass('onS');
}
// 新增提交
function save(f){
	// 校验
	if (!chk('add')) {
		return;
	}
	if (f!=1 && f!=5) {
		pop.fail("提交状态标识获取失败，请稍后重新操作");return;
	}
	$('#addStatusIn').val(f);
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/chain/save",
		data: $("#addForm").serialize(),
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg, function(){
					resetAdd();
					resetAddCat();
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
}
///// add end /////

//===== upd start =====//
//详情
function detail(){
	if($('#lilast').length > 0){
		pop.fail("请先关闭正在打开的详情面板", function(){
			$('#lilast').click();
		});
		return;
	}
	var optId = $(":radio[name='optId']:checked").val();
	if (optId==null || optId==undefined || optId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/chain/detail",
		data: {
			ID : optId
		},
		dataType : "html",
		success : function(data){
			var detailLi = "<li id='lilast'>"
				  + "<a class='ued-revamp' href='javascript:void(0)'>详情</a>"
				  + "<span class='ued-tabClose'></span>"
				  + "</li>";
			$(".js_tab_tit .ued-tab-1").append(detailLi);
			$(".ued-tab-con").append(data);
			$('#lilast').click();
			return;
		},
		error : function(){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
//修改提交
function upd(){
	// 校验
	if (!chk('upd')) {
		return;
	}
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/chain/upd",
		data: $("#updForm").serialize(),
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg, function(){
					closeDetail();
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
}
//关闭详情面板
function closeDetail(){
	$('.ued-tabClose').click();
}
//===== upd end =====//

//图片上传
$(".ued-file").live("change", function(){
	var thisId = $(this).attr("id");
	var imgBody = $('#'+thisId+'_img');
	$.ajaxFileUpload({
	    url: ctx+'/upload/imgUpload',
	    secureuri: false,
	    fileElementId: thisId,//file标签的id
	    dataType: 'json',//返回数据的类型
	    data:{},//一同上传的数据
	    success: function (data) {
	    	var jObj = jQuery.parseJSON(data);
	    	imgBody.attr("src", uploadUrl+jObj.fileName);
	    	imgBody.attr("path", jObj.fileName);
	    	imgBody.show();
	    },
	    error: function (data, status, e) {
	        pop.fail("图片上传失败，请稍后重新操作");
	    }
	});
});
//提交数据校验
function chk(t){
	if (isBlank($('#'+t+'ChainNameIn').val())) {
		pop.fail("请输入连锁公司名称");$('#'+t+'ChainNameIn').focus();return false;
	}
	var logoPath = $('#'+t+'LogoIn_img').attr("path");
	if (isBlank(logoPath)) {
		pop.fail("请上传公司Logo");$('#'+t+'LogoIn').focus();return false;
	}
	$('#'+t+'LogoPathIn').val(logoPath);
	var areaReg = /^[0-9\\.]+$/;
	if (isBlank($('#'+t+'MinAreaIn').val())) {
		pop.fail("请输入最小面积");$('#'+t+'MinAreaIn').focus();return false;
	} else if (!areaReg.test($('#'+t+'MinAreaIn').val())) {
		pop.fail("请正确输入最小面积");$('#'+t+'MinAreaIn').focus();return false;
	}
	if (isBlank($('#'+t+'MaxAreaIn').val())) {
		pop.fail("请输入最大面积");$('#'+t+'MaxAreaIn').focus();return false;
	} else if (!areaReg.test($('#'+t+'MaxAreaIn').val())) {
		pop.fail("请正确输入最大面积");$('#'+t+'MaxAreaIn').focus();return false;
	}
	if (isBlank($('#'+t+'ContactsIn').val())) {
		pop.fail("请输入联系人");$('#'+t+'ContactsIn').focus();return false;
	}
	if (isBlank($('#'+t+'PhoneNoIn').val())) {
		pop.fail("请输入联系电话");$('#'+t+'PhoneNoIn').focus();return false;
	} else if (!(/^\d+$/.test($('#'+t+'PhoneNoIn').val()))) {
		pop.fail("请正确输入联系电话");$('#'+t+'PhoneNoIn').focus();return false;
	}
	if (isBlank($('#'+t+'WechatIn').val())) {
		pop.fail("请输入微信号");$('#'+t+'WechatIn').focus();return false;
	}
	var wechat2Path = $('#'+t+'Wechat2In_img').attr("path");
	if (isBlank(wechat2Path)) {
		pop.fail("请上传微信二维码图片");$('#'+t+'Wechat2In').focus();return false;
	}
	$('#'+t+'Wechat2PathIn').val(wechat2Path);
	// 设置已选择类别
	var catArr = [];
	$('#'+t+'Form .catSelect').find('.onS').each(function(i, obj){
		catArr.push($(obj).attr("value"));
	});
	$('#'+t+'CatIn').val(catArr.join(","));
	return true;
}
//非空校验
function isBlank(s){
	return s==undefined || s==null || s=="";
}
