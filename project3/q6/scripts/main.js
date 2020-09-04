// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';
var c;

function setup() {
  createCanvas(1000, 1000);

}

function draw() {
  clear();
  c = color(255, 255, 0);
  fill(c);
  ellipse(mouseX, mouseY, 150, 150);
  c = color(0, 255, 0);
  fill(c);
  line(mouseX, mouseY - 20, mouseX, mouseY - 10);
  line(mouseX - 5, mouseY - 10, mouseX + 5, mouseY - 10);
  rect(mouseX - 50, mouseY - 40, 20, 15);
  rect(mouseX + 30, mouseY - 40, 20, 15);
  c = color(255, 50, 0);
  fill(c);
  arc(mouseX, mouseY + 10, 50, 80, 0, PI, PIE);
}
