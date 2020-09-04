// main.js

// 'use strict;' turns on JavaScripts strict mode, which helps catch errors

// $ is the main jQuery function used for calling jQuery functions

// document is a pre-defined JavaScript variable that refers to the entire web
// page

// ready is a jQuery function that is not called until the page's DOM is fully
// loaded and the page is ready --- you should always use it!

'use strict';

var start = false;

var difficultyLevel = 0;
var incLevel = 1;
var mySound1;
var mySound2;

var score = 0;

var x = [20, 180, 222, 6, 78, 23, 74, 44, 260, 100, 430, 222, 333, 532, 555, 234, 432, 280, 597, 21];
var y = [20, 60, 90, 300, 210, 430, 342, 230, 111, 444, 650, 700, 844, 733, 511, 422, 344, 555, 922, 270];
var incx = [1, 4, -1, -2, 3, -2, -5, 1, -2, -1, 2, -3 ,5, 2, 1, -1, 9, 3, -6, 7];
var incy = [1, -2, -1, 3, 1, 1, 4, -2, -1, 5, -2, 2, 3, 4, -6, -7, 1, 4, -2, -8];
var touched = false;


function preload() {
  mySound1 = loadSound('music/bump.wav');
  mySound2 = loadSound('music/universe.wav')
}

function setup() {
  mySound1.setVolume(0.1);
  mySound2.setVolume(0.1);
  mySound2.play();
  createCanvas(600, 1000);
}

function draw() {
  background(255, 204, 0);
  if(start){
    if(!touched){
      for(var i = 0; i < 20; i++){
        if(Math.pow(x[i]-mouseX, 2) + Math.pow(y[i]-mouseY, 2) < 400){
            fill(255, 0, 0);
            touched = true;
            mySound1.play();
        }
         x[i] += incx[i];
         y[i] += incy[i];
         if(x[i] <= 0 || x[i] >= 580) {
           incx[i]*=(-1);
         }
         if(y[i] <= 0 || y[i] >= 980) {
           incy[i]*=(-1);
         }
         ellipse(x[i], y[i], 40, 40);
      }
    } else {
      document.getElementById("gameOver").textContent = "Game Over ---------- Your Score is: " + score;
      document.getElementById("gameOver").style.display = 'block';
      document.getElementById("restart").style.display = 'block';
      document.getElementById("board").style.display = 'none';
      document.getElementById("warning").textContent = ":(";
      start = false;
    }
  } else {
    for(var j = 0; j < 20; j++){
      ellipse(x[j], y[j], 40, 40);
    }
  }
}

function keyPressed() {
  if(key === 'F' || key === 'f'){
    if(difficultyLevel <= 4) {
      difficultyLevel++;
      incLevel++;
      for(var k = 0; k < 20; k++) {
        incx[k] = incx[k] > 0 ? incx[k] + 3 : incx[k] - 3;
        incy[k] = incy[k] > 0 ? incy[k] + 3 : incy[k] - 3;
      }
      document.getElementById("difficulty").textContent = "Difficulty Level: " + incLevel;
    }
  } else if(key === 'S' || key === 's') {
    if(difficultyLevel >= 1){
      difficultyLevel--;
      incLevel--;
      for(var k = 0; k < 20; k++) {
        incx[k] = incx[k] > 0 ? incx[k] - 3 : incx[k] + 3;
        incy[k] = incy[k] > 0 ? incy[k] - 3 : incy[k] + 3;
      }
      document.getElementById("difficulty").textContent = "Difficulty Level: " + incLevel;
    }
  }
}

$(document).ready(function() {
  document.getElementById("restart").addEventListener('click', function() {
    location.reload();
  });

  setInterval(function(){
     if(start){
       score+=incLevel;
       document.getElementById("score").textContent = score;
     }
   }, 1000);

   setTimeout(function(){
     start = true;
     document.getElementById("warning").textContent = ":)";
     document.getElementById("difficulty").textContent = "Difficulty Level: " + incLevel;
   }, 3000);


});
