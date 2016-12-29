$(function(){
	showMatch(1);
});
function showMatch(pageNum){
	$('#pageNumIn').val(pageNum);
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/match/list",
		data : {
			pageNum : $('#pageNumIn').val()
		},
		dataType : "html",
		success : function(data){
			$('#showList').html(data);
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
	showMatch(pageNum);
}
//保存
function update(){
	if(validData()){
		$.ajax({
			type : "POST",
			url : ctx + "/back/match/saveOrUpdate",
			dataType : "json",
			data : $("#matchForm").serialize(),
			success: function(data){
				if(data.rsFlag){
					ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'提示信息',
						text:'<div style=" font-size:18px; color:#ff0000;">添加比赛成功</div>',
						'ok':function(){back();},
						tag:'zq-ring'}
		              );
				}else{
					showNotice(data);
				}
			}
		});
	}
}
//显示提示信息
function showNotice(data){
	$(".color-3").each(function(){
		var tip = eval("data." + this.id);
		if(tip != null && tip != "" && tip != undefined && tip != "undefined"){
			$(this).html(tip);
		}else{
			$(this).html("");
		}
	});
}

//验证数据
function validData(){
	return true;
}
//取消比赛
function cancleMat(ID){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/match/cancleMatch",
		data: {
			matID : ID
		},
		dataType : "html",
		success : function(data){
			location.href=ctx + "/back/match";
			return
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}



//图片相关
function initUpload(){
	//图片上传
	$("#imgForUpload").live("change", function(){
		alert('sssss');
		$.ajaxFileUpload({
		    url : '${ctx}/upload/imgUpload',
		    secureuri:false,
		    fileElementId:'imgForUpload',//file标签的id
		    dataType: 'json',//返回数据的类型
		    data:{},//一同上传的数据
		    success: function (data) {
		    	alert(data);
		    	var obj = jQuery.parseJSON(data);
		    	$("#imgPath").val(obj.fileName);
		    	$("#showImg").attr("src", "${uploadUrl}" + obj.fileName);
		    },
		    error: function (data, status, e) {
		        alert(e);
		    }
		});
	});
}
//返回
function back(){
	location.href = ctx+"/back/match/init";
}