$(function() {

	let map = document.querySelector(".map");
	let btn = document.querySelector("#submit");
	let lat = document.querySelector("#lat");
	let lng = document.querySelector("#lng");

	btn.addEventListener("click", function() {
		let latitude = lat.value;
		let longitude = lng.value;

	$.ajax({
		url: "https://api.instagram.com/v1/locations/search",
		crossDomain: true,
		data: {
			lat: latitude,
			lng: longitude,
			access_token: "1341115569.cba6241.7650393ef7aa49f5b49ec781c10c0cd3"},
		contentType: "application/json",
		dataType: "jsonp",
		method: "GET",
		success: return_locations,
	});
	});

	function return_locations(resp) {
		console.log(resp);
		var loc = resp.data[0];
		console.log(loc);
		$.ajax({
			url: "https://api.instagram.com/v1/media/search",
			crossDomain: true,
			data: {
				lat: loc.latitude,
				lng: loc.longitude,
				access_token: "1341115569.cba6241.7650393ef7aa49f5b49ec781c10c0cd3"},
			contentType: "application/json",
			dataType: "jsonp",
			method: "GET",
			success: return_posts,
		});
	}

	function return_posts(resp) {
		console.log(resp);
	}
});
