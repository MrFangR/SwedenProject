var index = 0;
$(function(){
	searchMat(1);
	$(".list-tab .list-title").click(function(){
		$(".inputfont").val("");
	   	index = $(this).index();
        if(index <= 2){
        	searchMat(1);
		}else{
			searchMatUser(1);
		}
	 })
	 $(".inputbut").click(function(){
	   	if(index <= 2){
        	searchMat(1);
		}else{
			searchMatUser(1);
		}
	 })
	 document.onkeydown = function(e){
        if(!e) e = window.event;
        if((e.keyCode || e.which) == 13){
        	$(".inputbut").click();
        }
    }
});
//查询
function searchMat(pageNum){
	var status = 1;
	if(index==0){
		status = 1;
	}
	if(index==1){
		status = 0;
	}
	if(index==2){
		status = 2;
	}
	$.ajax({
		type : 'POST',
		url : ctx + "/front/match/list",
		data: {
			title : $('#title').val(),
			pageNum : pageNum,
			pageSize : 16,
			status : status
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
	$(".listtabcon").find(".tabsub").eq(index).find("ul").html(htmlStr);
	
	//$("#resultDIV").html(htmlStr);
	
	setPageInfo("pageDiv"+index, data, searchMat);
}
function searchMatUser(pageNum){
	$.ajax({
		type : 'POST',
		url : ctx + "/front/match/showMatUser",
		data: {
			title : $('#title').val(),
			pageNum : pageNum,
			pageSize : 16
		},
		dataType : "json",
		success : function(data){
			showUserResult(data);
			return;
		},
		error : function(json){
			pop.fail("系统异常，请稍后重试");
			return;
		}
	});
}
function showUserResult(data){
	var htmlStr = "";
	$.each(data.list, function(i, user){
		if(i%2==0){
			htmlStr += "<tr>";
		}else{
			htmlStr += "<tr class='table-tr-even'>";
		}
		htmlStr += "<td>"+user.NAME+"</td>";
		htmlStr += "<td>"+user.LAST_START_SCORE+"</td>";
		htmlStr += "</tr>";
	});
	$(".listtabcon").find(".tabsub").eq(index).find("tbody").html(htmlStr);
	
	//$("#resultDIV").html(htmlStr);
	
	setPageInfo("pageDiv"+index, data, searchMatUser);
}
function FormatDate (strTime) {
    return new Date(strTime).Format("MM/dd/yyyy hh:mm:ss");
}
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}