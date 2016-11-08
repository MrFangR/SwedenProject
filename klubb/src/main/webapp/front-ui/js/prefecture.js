
/**
 * 修改地区选择
 */
function changePrefecture(obj, index){
	$("#" + obj.id + "_NAME").val($("#" + obj.id).find("option:selected").text()); //设置名称
	if(index != null){ //不是街道
		var prefectureIdArr = ["CITY", "COUNTY", "STREET"];
		var parentId = obj.value;
		if(parentId == "-1"){
			for(var i = index; i < prefectureIdArr.length; i++){
				$("#" + prefectureIdArr[i]).html("<option value='-1'>--请选择--</option>");
			}
			return;
		}
	
		$.ajax({
			type : "POST",
			url : rootContext + "/prefecture/findChild",
			dataType : "json",
			async : false,
			data : {
				parentId : parentId
			},
			success: function(data){
				var htmlStr = "<option value='-1'>--请选择--</option>";
				$.each(data.prefectureList, function(i, p){
					htmlStr += "<option value='" + p.PREFECTURE_ID + "'>" + p.PREFECTURE_NAME + "</option>";
				});
				var childId = prefectureIdArr[index];
				$("#" + childId).html(htmlStr);
			}
		});
	}
}
