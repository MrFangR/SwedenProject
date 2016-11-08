$(function(){
	getRoleLst();
});
// 查询box重置
function resetQry(){
	$('#roleName_qry').val("");
}
// 查询
function getRoleLst(pageNum){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/role/getRolePage",
		data: {
			roleName : $('#roleName_qry').val(),
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
//翻页
function qry4Page(pageNum){
	getRoleLst(pageNum);
}

// 保存
function save(o){
	var thisBox = $(o).closest('.box-n');
	var roleName = thisBox.find('#roleName').val();
	if (roleName==null || roleName=="") {
		pop.fail("请输入角色名称", function(){$('#roleName_in').focus();});
		return;
	}
	var nodeIds = "";
	var treeId = thisBox.find('.ztree').attr('id');
	if (treeId!=null && treeId!=undefined) {
		var treeObj = $.fn.zTree.getZTreeObj(treeId);
		var chkedNodes = treeObj.getCheckedNodes(true);
		for(var i=0; i<chkedNodes.length; i++){
			nodeIds += (chkedNodes[i].id+",");
		}
	}
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/role/save",
		data: {
			"role.ID" : thisBox.find('#roleId').text(),
			"role.ROLE_NAME" : roleName,
			"role.REMARK" : thisBox.find('#remark').val(),
			nodeIds : nodeIds
		},
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg, function(){
					getRoleLst();// 实时查询
					if (thisBox.attr('id') == "add_box") {
						$('.liQuery').click();
						thisBox.find('#resetBtn').click();
					}
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

// 重置区域
function reset(o){
	var thisBox = $(o).closest('.box-n');
	thisBox.find('#roleId').text("");
	thisBox.find('#roleName, #remark').val("");
	var treeId = thisBox.find('.ztree').attr('id');
	if (treeId!=null && treeId!=undefined) {
		var treeObj = $.fn.zTree.getZTreeObj(treeId);
		treeObj.checkAllNodes(false);
	}
	if (thisBox.attr('id') == "upd_box") {
		fillDetailInfo();
	}
}



// 删除角色
function del(id, name){
	pop.confirm("是否确认删除该角色？角色为："+name, function(){
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/role/del",
			data: {
				id : id
			},
			dataType : "json",
			success : function(json){
				var flag = json.flag;
				if (flag == 0) {
					pop.fail(json.msg, function(){
						getRoleLst();// 触发查询操作
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

// 去除x绑定效果
$(function(){$('.ued-tabClose').die('click');});
// 详情
var choose_role;
var choose_privLst;
function detail(id){
	if($('#updLi').length > 0){
		pop.fail("请先关闭其他角色详情面板", function(){
			$('#updLi').click();
		});
		return;
	}
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/role/getInfoById",
		data: {
			id : id
		},
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				var updLi = "<li id='updLi'>"
					  + "<a class='ued-revamp' href='javascript:void(0)'>查看详情</a>"
					  + "<span class='ued-tabClose' id='updLi_close'></span>"
					  + "</li>";
				$(".js_tab_tit .ued-tab-1").append(updLi);
				$('#updLi').click();
				
				choose_role = json.role;
				choose_privLst = json.privLst;
				fillDetailInfo();
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
function fillDetailInfo(){
	if (choose_role!=undefined && choose_role!=null) {
		$('#upd_box #roleId').text(choose_role.ID);
		$('#upd_box #roleName').val(choose_role.ROLE_NAME);
		$('#upd_box #remark').val(choose_role.REMARK);
	}
	if (choose_privLst!=undefined && choose_privLst!=null && choose_privLst.length>0) {
		var treeObj = $.fn.zTree.getZTreeObj("upd_func_tree");
		for (var i = 0; i < choose_privLst.length; i++) {
			var privId = choose_privLst[i].PRIVILEGE_ID;
			var node = treeObj.getNodeByParam("id", privId);
			if (node != null) {
				treeObj.checkNode(node, true, true);
//				treeObj.selectNode(node, true);
			}
		}
	}
}
// 详情面板x
$('#updLi_close').live('click', function(){
	$('#updLi').remove();
	$('.liQuery').click();
	$('#upd_box').find('#roleId').text("");
	$('#upd_box').find('#roleName, #remark').val("");
	var treeId = $('#upd_box').find('.ztree').attr('id');
	if (treeId!=null && treeId!=undefined) {
		var treeObj = $.fn.zTree.getZTreeObj(treeId);
		treeObj.checkAllNodes(false);
	}
});
