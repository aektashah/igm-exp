$(function() {

	let map = document.querySelector(".map");

	$.ajax({
		url: "https://api.instagram.com/v1/locations/search",
		data: {access_token: "1341115569.cba6241.7650393ef7aa49f5b49ec781c10c0cd3"},
		contentType: "application/json",
		dataType: "json",
		method: "GET",
		success: put_into_map,
	});

	function put_into_map(resp) {
		console.log(resp);
	}
});
