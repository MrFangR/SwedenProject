var map = null;

$(function(){
	var _text = $("#js_ditu").html();
	$("#js_ditu").html("");
	//纯净版弹框
	$(".js_collect6").live("click",function(){
		ui_com_hallpop(".js_collect6","#ands_misoAlert_close","#ands-miso-popAlert",{type:6,info:'地图定位',text:_text,mywidth:"900",});
		initMap();
		initMapSearch();
	});
	
	//支付方式修改，年、半年
//	$("input[name='shop.PAY_TYPE']").change(function(){
//		var unit = $("input[name='shop.PAY_TYPE']:checked").attr("unit");
//		$("#priceUnit").html(unit);
//	});
	

	initUpload();
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
	
	var myOverlay = null;
	drawingManager.addEventListener('overlaycomplete', function(e) {
		if(myOverlay != null){
		    map.removeOverlay(myOverlay);
		}
		myOverlay = null;
		myOverlay = e.overlay;
		map.addOverlay(myOverlay);
		initMyOverlayOption(myOverlay);
		
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
		var gc = new BMap.Geocoder();//地址解析类
		gc.getLocation(point, function(rs){
			var infoWindow = getInfoWindow(rs.address, point.lng, point.lat);
			map.openInfoWindow(infoWindow, point);      // 打开信息窗口
	    });
	}
}

/**
 * 地图搜索
 */
function initMapSearch(){
	$("#mapSearchBtn").click(function(){
		map.clearOverlays();
		var options = {
			onSearchComplete: function(rs){
				if (local.getStatus() != BMAP_STATUS_SUCCESS){
			        return ;
			    }
				/*var minLng = 1000000;
				var minLat = 1000000;
				var maxLng = 0;
				var maxLat = 0;*/
				
			    for(var index = 0; index < rs.getCurrentNumPois(); index++){
			        var point = rs.getPoi(index);
			        addMarker(rs, point, index);
			        /*
			        if(point.point.lng > maxLng){
			        	maxLng = point.point.lng;
			        }
			        if(point.point.lat > maxLat){
			        	maxLat = point.point.lat;
			        }
			        if(point.point.lng < minLng){
			        	minLng = point.point.lng;
			        }
			        if(point.point.lat < minLat){
			        	minLat = point.point.lat;
			        }*/
			    }
			    /*		    
			    var b = new BMap.Bounds(new BMap.Point(minLng, minLat), new BMap.Point(maxLng, maxLat));
				try {
					BMapLib.AreaRestriction.setBounds(map, b);
				} catch(e) {
					alert(e);
				}
				*/
				//map.zoomToSpan();
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
function addMarker(rs, point, index){
    var marker = new BMap.Marker(point.point);

    var infoWindow = getInfoWindow(point.address, point.point.lng, point.point.lat);
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
function getInfoWindow(address, lng, lat){
	var opts = {    
		width : 250,     // 信息窗口宽度    
		height: 100     // 信息窗口高度    
	};
	
//		var p = myOverlay.getPosition();       //获取marker的位置
	var htmlStr = "<div><p>" + address + "</p><input onclick=\"showResult('" + address + "'," + lng + "," + lat + ")\" type=\"button\" value=\"确定\"/></div>";

	var infoWindow = new BMap.InfoWindow(htmlStr, opts);  // 创建信息窗口对象
	return infoWindow;
}

/**
 * 显示所选点数据
 */
function showResult(address, lng, lat){
	$("#alertAddress").val(address);
	$("#alertLongitude").val(lng);
	$("#alertLatitude").val(lat);
	map.closeInfoWindow();
}

/**
 * 修改点位置
 */
function moveByInput(){
	var lng = $("#alertLongitude").val();
	var lat = $("#alertLatitude").val();
	if(lng != null && lng != "" && lat != null && lat != "")
	map.clearOverlays();
	
	myOverlay = new BMap.Marker(new BMap.Point(lng, lat));
	map.addOverlay(myOverlay);
	initMyOverlayOption(myOverlay);
	
	$("#alertAddress").val("");
}

/**
 * 设置表单中地址、经纬度
 */
function setAddress(){
	$("#LONGITUDE").val($("#alertLongitude").val());
	$("#LATITUDE").val($("#alertLatitude").val());
	$("#SHOP_ADDRESS").val($("#alertAddress").val());
	$("#showAddress").val($("#alertAddress").val());
	$("#ands_misoAlert_close").trigger("click");
}