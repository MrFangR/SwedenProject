$(function(){
	searchAct(1);
});
//查询
function searchAct(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/front/activity/list",
		data: {
			title : $('#title').val(),
			pageNum : pageNum,
			pageSize : 3
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
		htmlStr += "<p class='date'>"+act.ACT_TIME.substr(8,2)+"</p><p class='month'>"+act.ACT_TIME.substr(5,2)+"</p><p class='Category'>活动</p>";
		htmlStr += "</div>";
		htmlStr += "<div class='zixun_content'>";
		htmlStr += "<div class='pic'><a href='javascript:viewAct("+act.ID+");' target='_blank'><img src='"+uploadUrl+act.IMG+"'></a></div>";
		htmlStr += "<div class='title'><a href='javascript:viewAct("+act.ID+");' target='_blank' >"+act.TITLE+"</a></div>";
		htmlStr += "<div class='intro'><a href='javascript:viewAct("+act.ID+");' target='_blank'>"+act.ABSTRACT+"</a></div>";
		htmlStr += "</div>";
		htmlStr += "</li>";
	});
	$("#resultDIV").html(htmlStr);
	
	setPageInfo("pageDiv", data, searchAct);
}

function viewAct(ID){
	location.href=ctx + "/front/activity/viewAct?type=" + ID;
}