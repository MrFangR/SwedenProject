$(function(){
	searchMat(1);
});
//查询
function searchMat(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/front/match/list",
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
	$.each(data.list, function(i, mat){
		var startDate = FormatDate(mat.START_DATE);
		htmlStr += "<li class='listbox mr20'>";
		htmlStr += "<div class='listboximg'>";
		htmlStr += "<a href='"+ctx+"/front/matchdetail?matchId="+mat.ID+"'  target='_blank'><img  src='"+uploadUrl+mat.IMG+"' class='attachment-thumbnail wp-post-image'></a>";
		htmlStr += "</div>";
		htmlStr += "<div class='listinfo'>";
		htmlStr += "<div class='listtitle'><a href='"+ctx+"/front/matchdetail?matchId="+mat.ID+"'  target='_blank'>"+mat.NAME+"</a></div>";
		htmlStr += "<div class='listdate'>比赛时间："+startDate+"</div>";
		htmlStr += "</div>";
		htmlStr += "</li>";
	});
	$("#resultDIV").html(htmlStr);
	
	setPageInfo("pageDiv", data, searchMat);
}
function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getDate()+"/"+(date.getMonth()+1)+"/"+date.getFullYear()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
}