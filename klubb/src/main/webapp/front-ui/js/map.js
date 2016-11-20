var map = null;

/**
 * 地图相关
 */
// 初始化地图
function initMap() {
	var origin_place_id = $("#placeId").val();
	var destination_place_id = null;
	var travel_mode = google.maps.TravelMode.WALKING;
	var map = new google.maps.Map(document.getElementById('allmap'), {
		mapTypeControl: false,
		center : {
			lat : 60.178909,
			lng : 18.571950
		},
		zoom : 13
	});
	
	var directionsService = new google.maps.DirectionsService;
	var directionsDisplay = new google.maps.DirectionsRenderer;
	directionsDisplay.setMap(map);

	var input = document.getElementById('pac-input');
	var modes = document.getElementById('mode-selector');
	
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(modes);
	
	var destination_autocomplete = new google.maps.places.Autocomplete(input);
	destination_autocomplete.bindTo('bounds', map);

	map.addListener('bounds_changed', function() {
		searchBox.setBounds(map.getBounds());
	});
	
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

	function setupClickListener(id, mode) {
		var radioButton = document.getElementById(id);
		radioButton.addEventListener('click', function() {
			travel_mode = mode;
		});
	}
	setupClickListener('changemode-walking', google.maps.TravelMode.WALKING);
	setupClickListener('changemode-transit', google.maps.TravelMode.TRANSIT);
	setupClickListener('changemode-driving', google.maps.TravelMode.DRIVING);
	
	function expandViewportToFitPlace(map, place) { 
		if (place.geometry.viewport) {
			map.fitBounds(place.geometry.viewport);
		} else {
			map.setCenter(place.geometry.location);
			map.setZoom(17);
		}
	}
	

	destination_autocomplete.addListener('place_changed', function() {
		var place = destination_autocomplete.getPlace();
		if (!place.geometry) {
			window.alert("Autocomplete's returned place contains no geometry");
			return;
		}
		expandViewportToFitPlace(map, place);

		// If the place has a geometry, store its place ID and route if we have
		// the other place ID
		destination_place_id = place.place_id;
		route(origin_place_id, destination_place_id, travel_mode,
				directionsService, directionsDisplay);
	});
	

	function route(origin_place_id, destination_place_id, travel_mode, directionsService, directionsDisplay) {
		if (!origin_place_id || !destination_place_id) {
			return;
		}
		directionsService.route({
			origin : {
				'placeId' : origin_place_id
			},
			destination : {
				'placeId' : destination_place_id
			},
			travelMode : travel_mode
		}, function(response, status) {
			if (status === google.maps.DirectionsStatus.OK) {
				directionsDisplay.setDirections(response);
			} else {
				window.alert('Directions request failed due to ' + status);
			}
		});
	}
}
