// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';

$(document).ready(function() {

	$("#calculate").click(function() {
		var width = $("#wid").val();
		var height = $("#hi").val();
		var diagonal = $("#diag").val();
		if(!width || !height || !diagonal || isNaN(width) || isNaN(height) || isNaN(diagonal)) {
			window.alert("please make sure you enter a number in each box!");
		} else {
			var ppi = Math.sqrt(Math.pow(width, 2) + Math.pow(height, 2))/diagonal;
			window.alert("The PPI is " + ppi);
		}
	});
    // always call your code through ready to ensure the DOM is fully loaded

});
