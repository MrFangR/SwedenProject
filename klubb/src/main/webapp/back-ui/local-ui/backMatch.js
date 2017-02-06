$(function(){
	initUpload();
	showMatch(1);
	$("input[name='match.TYPE']").click(function(){
		var type = $(this).val();
		if(type==2||type==4){
			 $("input[name='match.STOP_PLAYER']").parent().parent().show();
		}else{
			$("input[name='match.STOP_PLAYER']").val("");
			 $("input[name='match.STOP_PLAYER']").parent().parent().hide();
		}
	 })
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
	$(".fs-14").each(function(){
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
function cancleMat(ID,status){
	var statusMsg = "";
	if(status == -1){
		return;
	}else if(status == 0){
		statusMsg = "未开始";
	}else if(status == 1){
		statusMsg = "进行中";
	}else if(status == 2){
		statusMsg = "已完成";
	}
		
	$(".js_collect2").live("click",function(){
		ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
					   {type:2,
						info:'取消比赛确认',
						text:'<div style=" font-size:18px; color:#ff0000;"> 取消比赛提示</div>您好，您确认要取消比赛吗，目前比赛状态：'+statusMsg,
						'ok':function(){canMat(ID)},
						tag:'cw-ring'}
		               );
	})
}

//取消比赛
function canMat(ID){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/match/cancleMatch",
		dataType : "json",
		data: {
			matID : ID
		},
		success : function(data){
			if(data.rsFlag){
				location.href=ctx + "/back/match";
				return
			}else{
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
						   {type:2,
							info:'提示信息',
							text:'<div style=" font-size:18px; color:#ff0000;">'+data.rsMsg+'</div>',
							'ok':function(){back();},
							tag:'zq-ring'}
			              );
			}
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}

//开始比赛
function startMat(matId){
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/match/startMatch",
		data: {
			matID : matId
		},
		dataType : "json",
		success : function(data){
			if(data.rsFlag){
				location.href=ctx + "/back/match";
				return
			}else{
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
						   {type:2,
							info:'提示信息',
							text:'<div style=" font-size:18px; color:#ff0000;">开始比赛失败！</div>',
							'ok':function(){back();},
							tag:'zq-ring'}
			              );
			}
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
		$.ajaxFileUpload({
		    url : ctx + '/upload/imgUpload',
		    secureuri:false,
		    fileElementId:'imgForUpload',//file标签的id
		    dataType: 'json',//返回数据的类型
		    data:{},//一同上传的数据
		    success: function (data) {
		    	var obj = jQuery.parseJSON(data);
		    	$("#imgPath").val(obj.fileName);
		    	$("#showImg").attr("src", uploadUrl + obj.fileName);
		    },
		    error: function (data, status, e) {
		    	ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
	   					   {type:2,
	   						info:'提示信息',
	   						text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试 </div>',
	   						'ok':function(){},
	   						tag:'cw-ring'}
	   		               );
		    }
		});
	});
}
//返回
function back(){
	location.href = ctx+"/back/match/init";
}