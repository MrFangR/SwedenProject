/**
 * 获取市列表
 */
function getCityLst(){
	var _p = $('#PROVINCE').val();
	$.ajax({
		type : "GET",
		url : ctx + "/prefecture/findChild",
		dataType : "json",
		async : false,
		data : {
			parentId : _p
		},
		success: function(json){
			var htmlStr = "<option value='-1'>--请选择--</option>";
			$.each(json.prefectureList, function(i, p){
				htmlStr += "<option value='" + p.PREFECTURE_ID + "'>" + p.PREFECTURE_NAME + "</option>";
			});
			$("#CITY").html(htmlStr);
		}
	});
}
//图片上传
$(".ued-file").live("change", function(){
	var $td = $(this).parent().prev();
	$("#imgTbody input").each(function(i, obj){
		$(obj).attr("id", "");
		$(obj).attr("name", "");
	})
	$(this).attr("id", "imgForUpload");
	$(this).attr("name", "imgForUpload");
	$.ajaxFileUpload({
		url : ctx+'/upload/imgUpload',
		secureuri:false,
		fileElementId:'imgForUpload',//file标签的id
		dataType: 'json',//返回数据的类型
		data:{},//一同上传的数据
		success: function (data) {
			var obj = jQuery.parseJSON(data);
			var imgHtml = "<img style='width:130px; height:100px;' src='${uploadUrl}" + obj.fileName + "' path='" + obj.fileName + "'/>";     
			$td.html(imgHtml);
		},
		error: function (data, status, e) {
			alert(e);
		}
	});
});
/*添加图片*/
$("#imgAddBtn").click(function(){
	var imgSum = $("#imgTbody tr").size();
	var className = "ued-tr-odd";
	if(imgSum % 2 == 0){ //当前为偶数个
		className = "ued-tr-even";
	}
	var htmlStr = "<tr class='" + className + "'>"
	+ "    <td></td>"
	+ "    <td><input name='imgForUpload'  type='file' class='ued-file'></td>"
	+ "    <td>340*340</td>"
	+ "    <td><a class='mgr-10' onclick='deleteImgTr(this)'>[删除]</a></td>"
	+ "</tr>";
	$("#imgTbody").append(htmlStr);
	return false;
});
/**
 * 删除图片TR
 */
function deleteImgTr(obj){
	$(obj).parent().parent().remove();
	if($("#imgTbody tr").size() <= 1){//删完了
		var htmlStr = "<tr class='ued-tr-odd'>"
						+ "    <td></td>"
						+ "    <td><input name='imgForUpload'  type='file' class='ued-file'></td>"
						+ "    <td>340*340</td>"
						+ "    <td></td>"
						+ "</tr>";
		$("#imgTbody").append(htmlStr);
	}
	resetImgTrClass();
}
/**
 * 重置imgTr因删除造成的样式问题
 */
function resetImgTrClass(){
	$.each($("#imgTbody tr:gt(1)"), function(i, obj){
		var className = "ued-tr-odd";
		if(i % 2 == 0){ //当前为偶数
			className = "ued-tr-even";
		}
		$(this).removeClass().addClass(className);
	})
}

// 初审通过
function firstPass(){
	var review = $('#first_review').val();
	if (review == "") {
		pop.fail("请输入初审意见", function(){$('#first_review').focus();});
		return;
	}
	$('#PRE_REVIEW_COMMENT').val(review);
	//设置文章
	$("#CONTENT").val(UE.getEditor('editor').getContent());
	//设置类别
	var catArr = [];
	$('#cat_panel').find('.onS').each(function(i, cObj){
		catArr.push($(cObj).attr("value"));
	});
	$("#CAT").val(catArr.join(","));
	
	//设置图片
	var imgArr = [];
	$("#imgTbody img").each(function(i, obj){
		imgArr.push($(obj).attr("path"));
	});
	$("#IMG").val(imgArr.join(","));
	//设置POI
	$("#POI").val(poiToString());
	
	$.ajax({
		type : 'POST',
		cache : false,
		async : true,
		url : ctx + "/back/pro/firstPass",
		data: $("#proForm").serialize(),
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg, function(){
					back();
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
// 初审拒绝
function firstFail(){
	var review = $('#first_review').val();
	if (review == "") {
		pop.fail("请输入初审意见", function(){$('#first_review').focus();});
		return;
	}
	$.ajax({
		type : 'POST',
		cache : false,
		async : true,
		url : ctx + "/back/pro/firstFail",
		data: {
			proId : $('#proId').val(),
			review : review
		},
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg, function(){
					back();
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
//终审
function finalChk(chkStatus){
	var review = $('#final_review').val();
	if (review == "") {
		pop.fail("请输入终审意见", function(){$('#final_review').focus();});
		return;
	}
	$.ajax({
		type : 'POST',
		cache : false,
		async : true,
		url : ctx + "/back/pro/finalChk",
		data: {
			proId : $('#proId').val(),
			chkStatus : chkStatus,
			review : review
		},
		dataType : "json",
		success : function(json){
			if (json.flag == 0) {
				pop.success(json.msg, function(){
					back();
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
// 返回
function back(){
	location.href = ctx+"/back/pro/init";
}