function popQuick(){
	//补充登录页面
	$.ajax({
		url : ctx+"/quickPost",
		type : 'post',
		async: false,//使用同步的方式,true为异步方式
		success : function(rtnObj){
			if(rtnObj.flag=="nologin"){//未登录，跳转到登录页面
				toUrl = rtnObj.toUrl;
				popLoginByMa();
			}else{
				ui_com_hallpop(".js_fastfb", "#ands_misoAlert_close","#ands-miso-popAlert", {type : 6,info : '快速发布', text : rtnObj, mywidth : "500"});
			}
		}
	});
}

function quickSub(){
	var prodName = $.trim($("#prodName").val());
    var prodDesc = $.trim($("#prodDesc").val());
    if(prodName==null || "" == prodName){
    	$("#prodName").parent().next(".notice").html("产品名称不可为空，请补充！");
    	return false;
    }else if(jST.isHavIllChar(prodName)){
    	$("#prodName").parent().next(".notice").html("产品名称不能为非法字符！");
    	return false;
    }
    if(prodDesc!=null && prodDesc.length>0 && jST.isHavIllChar(prodDesc) ){
    	$("#prodDesc").parent().next(".notice").html("产品描述不能包含非法字符！");
    	return false;
    }
	$.ajax({
    	type: "post",
		url:ctx+"/quickPost/addInfo",
		async: false,
		data: $("#quickForm").serialize(),
		success : function(json){
			var result = json.flag;
			if (result=='success') {
				location.href=ctx;
			} else {
				ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
				   {type:2,
					info:'快速发布',
					text:'<div style=" font-size:18px; color:#ff0000;">'+ json.Msg + '</div>',
					'ok':function(){
							window.location.href=ctx;
						},
					tag:'cw-ring'}
		           );
			}
			$(".ands-miso-cover").remove();
			$("#ands-miso-popAlert").hide();
		},
		error : function(json){
			ui_com_hallpop(".js_collect2","#ands_misoAlert_close","#ands-miso-popAlert",
			   {type:2,
				info:'快速发布',
				text:'<div style=" font-size:18px; color:#ff0000;"> 系统异常，请稍后重试  json= '+ json.Msg + '</div>',
				'ok':function(){
						window.location.href=ctx;
					},
				tag:'cw-ring'}
	           );
		}
	  });
}
