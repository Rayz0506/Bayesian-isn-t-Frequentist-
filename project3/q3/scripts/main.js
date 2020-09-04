// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';

$(document).ready(function() {

	$('#upperCase').click(function(){
		if($('#upperCase').prop('checked')){
			$("#article").text($("#article").text().toUpperCase());
		} else {
			$("#article").text($("#article").text().toLowerCase());
		}
	});

	$('#border').click(function(){	
		if($('#border').prop('checked')){
			$("#article").css('border', '5px solid red');
		} else {
			$("#article").css('border', 'none');
		}
	});

	$("#serif").click(function() {
		$("#article").css('font-family', '\"Times New Roman\", Times, serif');
	});

	$("#sans-serif").click(function() {
		$("#article").css('font-family', 'Arial, Helvetica, sans-serif');
	});

	$("#mono").click(function() {
		$("#article").css('font-family', '\"Courier New\", Courier, monospace');
	});
    // always call your code through ready to ensure the DOM is fully loaded

});
