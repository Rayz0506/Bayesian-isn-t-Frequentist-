// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';

function setup() {
  createCanvas(1000, 1000);
}

function draw() {
  if(mouseIsPressed){
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

function keyPressed() {
    if (key === 'r' || key === 'R') {
      stroke(255, 0, 0);
    } else if (key === 'g' || key === 'G') {
      stroke(0, 255, 0);
    } else if (key === 'b' || key === 'B') {
      stroke(0, 0, 255);
    }
}
