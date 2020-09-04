// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';

$(document).ready(function() {

	document.getElementById("ask").addEventListener('click', function() {
		var a = Math.floor(Math.random()*6) + 1;
		if($('#effect').css('display') !=='none'){
			$("#effect").fadeOut();
		}
		switch(a) {
			case 1:
				$("#effect").text("Yes");
				break;
			case 2:
				$("#effect").text("No");
				break;
			case 3:
				$("#effect").text("Absolutely!");
				break;
			case 4:
				$("#effect").text("Definitely Not!");
				break;
			case 5:
				$("#effect").text("Maybe");
				break;
			case 6:
				$("#effect").text("Very Doubtful");
				break;
			default:
				$("#effect").text("Something is wrong");
		}

		$("#effect").fadeIn();
	});
    // always call your code through ready to ensure the DOM is fully loaded

});
