// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';

$(document).ready(function() {
	$("#send").on('click', function() {
		var name = $("#name").val();
		var gift = $("#gift").val();
		if(!name || !gift) {
			alert("please complete the form!");
		}
		else {
			$("#fan-name").text(name);
			$(".thing").text(gift);
			var famousPersionList = ["my mother", "Bill Gates", "Beyonce", "Jennifer Lawrence’s pool cleaner", "Ray Zou", "Jackie Chan"];
			$("#famous-person").text(famousPersionList[Math.floor(Math.random()*6)]);
			var locations = ["washing machine", "dashboard", "lawn mower", "bedside table", "dining room", "living room"];
			$("#location").text(locations[Math.floor(Math.random()*6)]);
			var times = ["every third Tuesday around 10am", "once in a blue moon", "whenever I am feeling really hungry"];
			$("#time").text(times[Math.floor(Math.random()*3)]);
			var pics = ["silly.png", "spud.gif", "crazy.jpg"];
			$("#pic").prop("src", "images/" + pics[Math.floor(Math.random()*3)]);


			$("#letter").css('display', 'block');
		}
	});

    // always call your code through ready to ensure the DOM is fully loaded

});
