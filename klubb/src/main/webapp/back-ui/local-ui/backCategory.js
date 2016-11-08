$(function(){
	qry(1);
})
function chgCatType(t){
	$('#catTypeIn').val(t);
}
function chgStatus(t){
	$('#statusIn').val(t);
}
// 重置
function reset(){
	$('#catNameIn').val('');
	$('#statusSelect a').first().click();
	$('#catTypeSelect a').first().click();
}
// 查询
function qry(pageNum){
	$('.liQuery').click();
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/category/getPage",
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
	var categoryId = $(":radio[name='categoryId']:checked").val();
	if (categoryId==null || categoryId==undefined || categoryId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	var confirmMsg = "";
	if (f == 0) {
		confirmMsg = "是否确认将该类别设置为可用状态？";
	} else if (f == 1){
		confirmMsg = "是否确认将该类别设置为不可用状态？";
	} else {
		pop.fail("操作标识获取失败，请稍后重新操作");
		return;
	}
	pop.confirm(confirmMsg, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/category/optStatus",
			data: {
				categoryId : categoryId,
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

// 切换 新增类别 类别类型
function chgAddCatType(t){
	$('#addCatType').val(t);
	if (t != '') {
		$.ajax({
			type : 'get',
			cache : false,
			async : true,
			url : ctx + "/back/category/getByCatType",
			data: {
				catType : t
			},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					var catLst = json.catLst;
					var ph = "<a href=\"javascript:void(0);\" onclick=\"chgAddParent(0)\">无（新增一级类别）</a>";
					if (catLst!=null && catLst.length>0) {
						for ( var i = 0; i < catLst.length; i++) {
							var ctmp = catLst[i];
							ph += "<a href=\"javascript:void(0);\" onclick=\"chgAddParent("+ctmp.CAT_ID+")\">"+ctmp.CAT_NAME+"</a>";
						}
					}
					$('#addParentCatSelect').html(ph);
					$('#addParentDef').text("--请选择--");
				} else {
					pop.fail("父类别列表获取失败，请稍后重试");
					return;
				}
				return;
			},
			error : function(json){
				pop.fail("系统异常，请稍后重试");
				return;
			}
		});
	} else {
		$('#addParentCatSelect').empty();
	}
}
// 切换 父类别
function chgAddParent(t){
	$('#addParentId').val(t);
}
// 新增类别 重置
function resetAdd(){
	$('#addForm input').val("");
	$('#addCatTypeDef').text("--请选择--");
	$('#addParentCatSelect').empty();
	$('#addParentDef').text("--请选择类别类型--");
}

// 保存
function save(){
	if ($('#addCatName').val()==null || $('#addCatName').val()=="") {
		pop.fail("类别名称不可为空");$('#addCatName').focus();return;
	}
	if ($('#addCatType').val()==null || $('#addCatType').val()=="") {
		pop.fail("请选择类别类型");return;
	}
	if ($('#addParentId').val()==null || $('#addParentId').val()=="") {
		pop.fail("请选择父类别");return;
	}
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/category/save",
		data: $("#addForm").serialize(),
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg, function(){
					resetAdd();
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

// 详情
function detail(){
	if($('#lilast').length > 0){
		pop.fail("请先关闭正在打开的详情面板", function(){
			$('#lilast').click();
		});
		return;
	}
	var categoryId = $(":radio[name='categoryId']:checked").val();
	if (categoryId==null || categoryId==undefined || categoryId=="") {
		pop.fail("请选择要操作的记录");
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/category/getInfo",
		data: {
			optId : categoryId
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

// 二级类别详情
function detail2(cId){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/category/getInfo",
		data: {
			optId : cId
		},
		dataType : "html",
		success : function(data){
			$(".ued-tab-con div").filter('.js_copy').last().remove();
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

// 修改提交
function upd(){
	if ($('#updCatName').val()==null || $('#updCatName').val()=="") {
		pop.fail("类别名称不可为空");$('#updCatName').focus();return;
	}
	if ($('#updCatType').val()==null || $('#updCatType').val()=="") {
		pop.fail("请选择类别类型");return;
	}
	if ($('#updParentId').val()==null || $('#updParentId').val()=="") {
		pop.fail("请选择父类别");return;
	}
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/category/upd",
		data: $("#updForm").serialize(),
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg);
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