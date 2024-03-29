// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';

$(document).ready(function() {
	$("#cmToInch").click(function(){
		var input = $("#inputCm").val();
		if(!input || isNaN(input)) {
			alert("please enter a number!");
		}else {
			alert(input + " centimeters is " + input*0.39 + " inches");
		}
	});	

    // always call your code through ready to ensure the DOM is fully loaded

});
