// 状态切换
function chgStatus(statusNo){
	$('#status').val(statusNo);
}

// 查询
function qryCustMsg(pageNum){
	// 页面时间入参校验
	var startTime = $('#startTime').val();
	var endTime = $('#endTime').val();
	if (startTime!="" && endTime!="") {
		var stArray = startTime.split("-");
		var etArray = endTime.split("-");
		var st = new Date(stArray[0], stArray[1], stArray[2]);
		var et = new Date(etArray[0], etArray[1], etArray[2]);
		if (st > et) {
			pop.fail("开始时间必须小于结束时间，请重新设置查询时间");
			return;
		}
	}
	$('.liQuery').click();	// 为显示"收起查询条件"效果
	$.ajax({
		type : 'get',
		cache : false,
		async : true,
		url : ctx + "/back/custMsg/qryPage",
		data: {
			custNo : $('#custNo').val(),
			custName : $('#custName').val(),
			startTime : startTime,
			endTime : endTime,
			status : $('#status').val(),
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

// 翻页
function qry4Page(pageNum){
	qryCustMsg(pageNum);
}

// 重置
function reset(){
	$('#custNo,#custName,#startTime,#endTime').val('');
	$('#statusName').text($('#statusSelect a').first().text());
	chgStatus(0);
}