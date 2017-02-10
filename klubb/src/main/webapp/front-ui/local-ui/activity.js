$(function(){
	searchAct(1);
	document.onkeydown = function(e){
        if(!e) e = window.event;
        if((e.keyCode || e.which) == 13){
        	$(".inputbut").click();
        }
    }
});
//查询
function searchAct(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/front/activity/list",
		data: {
			title : $('#title').val(),
			pageNum : pageNum,
			pageSize : 16
		},
		dataType : "json",
		success : function(data){
			showResultList(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
function showResultList(data){
	var htmlStr = "";
	$.each(data.list, function(i, act){
		htmlStr += "<li>";
		htmlStr += "<div class='riqi'>";
		htmlStr += "<p class='date'>"+act.ACT_TIME.substr(8,2)+"</p><p class='month'>"+act.ACT_TIME.substr(5,2)+"</p><p class='Category'><i18n:get key='portal.menu.activity'></i18n:get></p>";
		htmlStr += "</div>";
		htmlStr += "<div class='zixun_content'>";
		htmlStr += "<div class='pic'><a href='"+ctx+"/front/activity/viewAct?type="+act.ID+"' target='_blank'><img src='"+uploadUrl+act.IMG+"'></a></div>";
		htmlStr += "<div class='title'><a href='"+ctx+"/front/activity/viewAct?type="+act.ID+"' target='_blank' >"+act.TITLE+"</a></div>";
		htmlStr += "<div class='intro'><a href='"+ctx+"/front/activity/viewAct?type="+act.ID+"' target='_blank'>"+act.ABSTRACT+"</a></div>";
		htmlStr += "</div>";
		htmlStr += "</li>";
	});
	$("#resultDIV").html(htmlStr);
	
	setPageInfo("pageDiv", data, searchAct);
}