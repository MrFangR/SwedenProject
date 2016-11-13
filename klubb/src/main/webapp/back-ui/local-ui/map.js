var map = null;

/**
 * 地图相关
 */
// 初始化地图
function initMap() {
	var map = new google.maps.Map(document.getElementById('allmap'), {
		center : {
			lat : 60.178909,
			lng : 18.571950
		},
		zoom : 8,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	});

	var input = document.getElementById('pac-input');
	var searchBox = new google.maps.places.SearchBox(input);
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

	map.addListener('bounds_changed', function() {
		searchBox.setBounds(map.getBounds());
	});

	var infowindow = new google.maps.InfoWindow();
	
	var markers = [];
	searchBox.addListener('places_changed', function() {
		var places = searchBox.getPlaces();

		if (places.length == 0) {
			return;
		}
		
		infowindow.close();
		
		//清除旧marker
		markers.forEach(function(marker) {
			marker.setMap(null);
		});
		markers = [];

		var bounds = new google.maps.LatLngBounds();
		places.forEach(function(place) {
			var icon = {
				url : place.icon,
				size : new google.maps.Size(71, 71),
				origin : new google.maps.Point(0, 0),
				anchor : new google.maps.Point(17, 34),
				scaledSize : new google.maps.Size(25, 25)
			};
			
			//创建marker
			var marker = new google.maps.Marker({
				map : map,
				icon : icon,
				title : place.name,
				position : place.geometry.location
			});
			markers.push(marker);

			if (place.geometry.viewport) {
				bounds.union(place.geometry.viewport);
			} else {
				bounds.extend(place.geometry.location);
			}
			
			var address = '';
		    if (place.address_components) {
		      address = [
		        (place.address_components[0] && place.address_components[0].short_name || ''),
		        (place.address_components[1] && place.address_components[1].short_name || ''),
		        (place.address_components[2] && place.address_components[2].short_name || '')
		      ].join(' ');
		    }

		    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address 
		    		+ '<br>' + '<input type="button" onclick="'
		    		+'showResult(\'' + address + '\',\'' + place.place_id + '\',\'' + place.url + '\')" value="确定">');
		    infowindow.open(map, marker);
		});
		map.fitBounds(bounds);
	});
}

/**
 * 显示所选点数据
 */
function showResult(address, placeId, url) {
	$("#address").val(address);
	$("#placeId").val(placeId);
	$("#mapUrl").val(url);
}
