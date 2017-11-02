$(function() {

  	let map = document.querySelector(".map");
  	let btn = document.querySelector("#submit");
  	let lat = document.querySelector("#lat");
  	let lng = document.querySelector("#lng");

  	btn.addEventListener("click", function() {
    		let latitude = lat.value;
    		let longitude = lng.value;

		$.ajax({
    			url: "https://api.twitter.com/1.1/geo/search.json",
    			crossDomain: true,
    			data: {
      				lat: latitude,
      				long: longitude 
			},
    			contentType: "application/json",
    			dataType: "json",
	    		method: "GET",
    			success: return_locations,
			error: err_response,
  		});
  	});

  	function return_locations(resp) {
    		console.log(resp);
  	}	
	
	function err_response(resp) {
		console.log(resp);
	}
});
