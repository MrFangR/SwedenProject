var func_id = "";
var func_parentId = "0";
var is_menu = 0;
var func_status = 0;

// 切换 父级ID
function chgParentId(vid){
	func_parentId = vid;
}
// 切换 是否菜单
function chgIsMenu(v){
	is_menu = v;
	if (0 == v) {
		$('#menu_index_title, #menu_index_value').show();
	} else {
		$('#menu_index_title, #menu_index_value').hide();
	}
}
// 切换 状态
function chgStatus(status){
	func_status = status;
}
// 新增功能 初始化
$('#addBtn').click(function(){
	func_id = "";
	$('#func_name,#func_url,#menu_index').val("");
	$('#isParent-1').click();
	$('#parentId-0').click();
	$('#isMenu-0').click();
	$('#status-0').click();
});
// 校验 输入参数
function chk(){
	if($('#func_name').val() == ""){
		pop.fail("请输入功能名称", function(){$('#func_name').focus();});
		return false;
	}else if(is_menu==0 && $('#menu_index').val() == ""){
		pop.fail("请输入菜单索引", function(){$('#menu_index').focus();});
		return false;
	}
	return true;
}
// 保存
function save(){
	if (!chk()) {
		return;
	}
	$.ajax({
		type : 'post',
		cache : false,
		async : true,
		url : ctx + "/back/priv/save",
		data: {
			"priv.ID": func_id,
			"priv.FUNC_NAME": $('#func_name').val(),
			"priv.PARENT_ID": func_parentId,
			"priv.IS_MENU": is_menu,
			"priv.MENU_INDEX": $('#menu_index').val(),
			"priv.FUNC_URL": $('#func_url').val(),
			"priv.STATUS": func_status
		},
		dataType : "json",
		success : function(json){
			var result = json.flag;
			if (result == 0) {
				pop.success(json.msg, function(){
					location.reload();
				});
			} else {
				pop.fail(json.msg);
			}
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}

// 选中菜单树功能
var chooseId;
function chooseMenu(id){
	chooseId = id;
}
// 修改
var updMenu;
$('#updBtn').click(function(){
	if (chooseId==null || chooseId=="") {
		pop.fail("请先在左侧菜单树中选择要修改的功能");
		return;
	}
	func_id = chooseId;
	$.ajax({
		type : 'get',
		cache : false,
		async : false,
		url : ctx + "/back/priv/getInfoById",
		data: {
			id: chooseId
		},
		dataType : "json",
		success : function(json){
			var result = json.flag;
			if (result == 0) {
				updMenu = json.func;
			} else {
				pop.fail(json.msg);
			}
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
	
	reset();
});
function reset(){
	if (updMenu != null) {
		$('#func_name').val(updMenu.FUNC_NAME);
		$('#parentId-'+updMenu.PARENT_ID).click();
		$('#func_url').val(updMenu.FUNC_URL);
		$('#isMenu-'+updMenu.IS_MENU).click();
		$('#menu_index').val(updMenu.MENU_INDEX);
		$('#status-'+updMenu.STATUS).click();
		return;
	}
}

$('#resetCacheBtn').click(function(){
	pop.confirm("是否确认刷新缓存？\n温馨提示：请勿频繁刷新", function(){
		pop.loading("缓存刷新中，请稍后...");
		$.ajax({
			type : 'post',
			cache : false,
			async : true,
			url : ctx + "/back/priv/flushBackPrivCache",
			data: {},
			dataType : "json",
			success : function(json){
				if (json.flag == 0) {
					pop.success(json.msg, function(){
						window.parent.reloadPanel();
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
	
	
	
});