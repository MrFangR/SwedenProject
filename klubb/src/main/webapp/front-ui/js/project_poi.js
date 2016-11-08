var map = null;
var poiArr = new Array();

$(function(){
	var _text = $("#js_ditu").html();
	$("#js_ditu").html("");
	//纯净版弹框
	$(".js_collect6").live("click",function(){
		ui_com_hallpop(".js_collect6","#ands_misoAlert_close","#ands-miso-popAlert",{type:6,info:'地图定位',text:_text,mywidth:"900",});
		initMap();
		initMapSearch();
		$("#poiType").val($(this).attr("typeNum"));
		initPoiData();
	});
	
});

/**
 *地图相关
 */
 //初始化地图
function initMap(){
	map = new BMap.Map("allmap", {enableMapClick:false});    // 创建Map实例
	// 百度地图API功能
	map.centerAndZoom("太原", 12);  // 初始化地图,设置中心点坐标和地图级别
	//map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	map.setCurrentCity("太原");          // 设置地图显示的城市 此项是必须设置的
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	map.addControl(top_left_control);
	map.addControl(top_left_navigation);
	
	//绘制工具
	var drawingManager = new BMapLib.DrawingManager(map, {
		isOpen: false, //是否开启绘制模式
		enableDrawingTool: true, //是否显示工具栏
		drawingToolOptions: {
			anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
			offset: new BMap.Size(5, 5), //偏离值
			//scale: 0.8, //工具栏缩放比例
			drawingModes: [
				BMAP_DRAWING_MARKER
			]
		}
	});
	
	drawingManager.addEventListener('overlaycomplete', function(e) {
		map.addOverlay(e.overlay);
		initMyOverlayOption(e.overlay);
		
		drawingManager.close();
	});
}

//设置自定义覆盖物选项
function initMyOverlayOption(myOverlay){
	myOverlay.enableDragging();
	showMyInfoWindow(myOverlay.point);
	myOverlay.addEventListener("dragend", callback); //标点拖拽结束
	myOverlay.addEventListener("click", callback); //标点点击
	
	function callback(e){
		showMyInfoWindow(e.point);
	}
	
	function showMyInfoWindow(point){
		var infoWindow = getInfoWindow("", "", point.lng, point.lat);
		map.openInfoWindow(infoWindow, point);      // 打开信息窗口
	}
}

/**
 * 地图搜索
 */
function initMapSearch(){
	$("#mapSearchBtn").click(function(){
//		map.clearOverlays();
		var options = {
			onSearchComplete: function(rs){
				if (local.getStatus() != BMAP_STATUS_SUCCESS){
			        return ;
			    }
				
			    for(var index = 0; index < rs.getCurrentNumPois(); index++){
			        var point = rs.getPoi(index);
			        addMarker(point.point, point.address);
			    }
			}
		};
		var local = new BMap.LocalSearch(map, options);
		local.enableAutoViewport();
		local.search($("#searchName").val());
	});
}

/**
 * 添加标点
 */
function addMarker(point, name){
    var marker = new BMap.Marker(point);

    var infoWindow = getInfoWindow("", name, point.lng, point.lat);
    marker.addEventListener("click",
        function(){
            marker.openInfoWindow(infoWindow);
        }
    );
    map.addOverlay(marker);
}

/**
 * 获取信息框
 */
function getInfoWindow(id, name, lng, lat){
	var opts = {    
		width : 250,     // 信息窗口宽度    
		height: 100     // 信息窗口高度    
	};
	
	var htmlStr = "<div>"
					+ "<input type='hidden' name='ID' value='" + id + "'/>"
					+ "<input type='hidden' name='LONGITUDE' value='" + lng + "'/>"
					+ "<input type='hidden' name='LATITUDE' value='" + lat + "'/>"
		 			+ "店铺名称：<input name='POI_NAME' value='" + name + "'/></br></br><div style='margin-left:2px'><input onclick='savePoi(this)' style='width:40%' type=\"button\" value=\"保存\"/>&nbsp;&nbsp;<input style='width:40%' onclick='delPoi(this)' type=\"button\" value=\"删除\"/></div></div>";

	var infoWindow = new BMap.InfoWindow(htmlStr, opts);  // 创建信息窗口对象
	return infoWindow;
}

/**
 * 初始化poi数据
 */
function initPoiData(){
	var projectId = $("#projectId").val();
	if(poiArr.length == 0 && projectId != ""){
		$.ajax({
			type : "POST",
			url : rootContext + "/project/searchPoi",
			dataType : "json",
			async : false,
			data : {
				projectId : projectId
			},
			success: function(data){
				$.each(data.list, function(i, p){
					var proPoi = {
							id : p.ID,
							name : p.POI_NAME,
							lng : p.LONGITUDE,
							lat : p.LATITUDE,
							type : p.TYPE
					};
					poiArr.push(proPoi);
				});
			}
		});
	}
	
	refreshPoi();
}

/**
 * POI相关操作
 */
function savePoi(obj){
	var proPoi = makePoi(obj);
	if(proPoi.name == ""){
		alert("请填写店铺名称");
		return;
	}
	deleteFromPoiArr(proPoi);
	poiArr.push(proPoi);
	alert("保存成功");
	map.closeInfoWindow();
	refreshPoi();
}

function delPoi(obj){
	var proPoi = makePoi(obj);
	deleteFromPoiArr(proPoi);
	alert("删除成功");
	map.closeInfoWindow();
	refreshPoi();
}

/**
 * 从数组中删除
 * @param proPoi
 */
function deleteFromPoiArr(proPoi){
	for(var i = 0; i < poiArr.length; i++){
		if((poiArr[i].id == proPoi.id && poiArr[i].id != null && poiArr[i].id != "") || 
				(poiArr[i].lng == proPoi.lng && poiArr[i].lat == proPoi.lat)){
			var tmpArr = poiArr.concat();
			poiArr = new Array();
			for(var j = 0; j < tmpArr.length; j++){
				if(j != i){
					poiArr.push(tmpArr[j]);
				}
			}
			break;
		}
	}
}

/**
 * 创建POI对象
 * @param obj
 */
function makePoi(obj){
	var proPoi = {type : $("#poiType").val()};
	$(obj).parent().siblings("input").each(function(){
		if($(this).attr("name") == "ID"){
			proPoi.id = $(this).val();
		}
		if($(this).attr("name") == "LONGITUDE"){
			proPoi.lng = $(this).val();
		}
		if($(this).attr("name") == "LATITUDE"){
			proPoi.lat = $(this).val();
		}
		if($(this).attr("name") == "POI_NAME"){
			proPoi.name = $(this).val();
		}
	});
	return proPoi;
}

function poiToString(){
	var str = "";
	for(var i = 0; i < poiArr.length; i++){
		var p = poiArr[i];
		if(p.name == "" || p.lng == "" || p.lat == "" || p.type == ""){
			continue;
		}
		str += p.id + "|" + p.name + "|" + p.lng + "|" + p.lat + "|" + p.type + "@";
	}
	if(str.length > 0){
		str = str.substr(0, str.length - 1);
	}
	return str;
}

function refreshPoi(){
	map.clearOverlays();
	for(var i = 0; i < poiArr.length; i++){
		var poi = poiArr[i];
		if(poi.type == $("#poiType").val()){
			addMarker(new BMap.Point(poi.lng, poi.lat), poi.name);
		}
	}
}
