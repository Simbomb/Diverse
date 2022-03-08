/*
fill a pix
By Simbomberino
Version: 0.01
Latest Update: 06/07/2019
*/
var visa = false;
var cols = 6;
var rows = 6;
var riktig_number = 0;
var first = true;
var number = [];

var test_spelplan = new Array(cols);
var spelplan = new Array(cols);

function setup() {
  createCanvas(cols * 68, rows * 68);
  textSize(16);
  background(220);

  if (first) {
    for (var g = 0; g < rows; g++) {
      test_spelplan[g] = new Array(rows);
      spelplan[g] = new Array(rows);
      number[g] = new Array(rows);
    }

    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        var random = Math.round((Math.random() * 6));
        test_spelplan[i][j] = random >= 3 ? 1 : 0;
        spelplan[i][j] = 2;
      }

    }
  }
  test_show();
  show();
  determine_number();
}

function test_show() {

  for (var b = 0; b < rows; b++) {
    for (var n = 0; n < cols; n++) {
      var x = b * 30;
      var y = n * 30;

      if (test_spelplan[b][n] == 0) {
        fill(255, 255, 255);
        rect(x, y, cols * 4, rows * 4);
      } else if (test_spelplan[b][n] == 1) {
        fill(0, 0, 0)
        rect(x, y, cols * 4, rows * 4);
      }
    }
  }

  for (var i = 0; i < rows; i++) {
    for (var j = 0; j < cols; j++) {
      var number_count = 0;
      var ri = -1;
      var rj = -1;
      var xcap = 1;
      var ycap = 1;
      if (i == 0) {
        ri = 0;
      }
      if (j == 0) {
        rj = 0;
      }
      if (i == cols - 1) {
        xcap = 0;
      }
      if (j == rows - 1) {
        ycap = 0;
      }
      for (; ri <= xcap; ri++) {
        for (; rj <= ycap; rj++) {
          if (test_spelplan[ri + i][rj + j] == 1) {
            number_count++;
          }
        }
        if (j == 0) {
          rj = 0;
        } else {
          rj = -1;
        }
      }
      number[i][j] = number_count;
      fill(255, 0, 0);
      text(number_count, i * 30 + 8, j * 30 + 18);
    }

  }


}

function show() {
  translate(0, 220);
  for (var b = 0; b < rows; b++) {
    for (var n = 0; n < cols; n++) {
      var x = b * 30;
      var y = n * 30;

      if (spelplan[b][n] == 0) {
        fill(255, 255, 255);
        rect(x, y, cols * 4, rows * 4);
        fill(205,0,0,110);
        text("X", x + 7, y + 19);
      } else if (spelplan[b][n] == 1) {
        fill(0, 0, 0)
        rect(x, y, cols * 4, rows * 4);
      } else if (spelplan[b][n] == 2) {
        fill(255, 255, 255);
        rect(x, y, cols * 4, rows * 4);
      }

    }
  }

}

function determine_number() {
  
      for(var b = 0 ; b<rows ; b++)
      { for( var n = 0 ; n<rows ; n++) {
    
      var x = b * 30;
      var y = n * 30;
        if(ai(b, n))
      {
         fill(0,0,255);
         text(number[b][n], x + 7, y + 19);
        
      }

      }}
  

    
  


}


function ai(b, n)
{
  /*
  if(number[b][n] == 0 || number[b][n] == 9  || b == 0 || n == 0 || b == rows-1 || n == cols-1)
  {
    visa = false;
  }
  else if(number[b+1][n] == number[b][n]-3 || number[b+1][n] == number[b][n]-3 || number[b][n-1] == number[b][n]-3 || number[b][n+1] == number[b][n]-3 ||number[b-1][n] == number[b][n]-3)
  {
    visa = false;
  }
  
  else
  {
    visa = true;
  }
  */
  var random = Math.round(Math.random(5)+ 1);
    if(random>=2)
    {
    visa = false;
    }
    else
    {
    visa = true
    }
  
  
  if (visa)
  {
    return true;
  }
  else
  {
    return false;
  }


}

function mousePressed() {
  var my = ceil((mouseY - 220) / 30);
  var mx = ceil(mouseX / 30);
  if (mx <= cols && my <= rows) {
    spelplan[mx - 1][my - 1]--;
    if (spelplan[mx - 1][my - 1] < 0) {
      spelplan[mx - 1][my - 1] = 1;
    }
    clear();
    first = false;
    setup();
    check();
  }
}
function keyPressed()
{
  if(key == "r" || key == "R")
  {
    setup();
  }

}

function check() {
  var count = 0;
  for (var i = 0; i < rows; i++) {
    for (var j = 0; j < cols; j++) {
      if (test_spelplan[i][j] == spelplan[i][j]) {
        count++
      }
    }

  }
  if (count == cols * rows) {
    console.log("Huuzaa!");
  }

}


var visvers = true;

function cheat() {
  if (visvers) {
    document.getElementById("block").style.display = "none";
    document.getElementById("cheat").innerHTML = "Göm!";
    visvers = false;
  } else {
    document.getElementById("block").style.display = "block";
    document.getElementById("cheat").innerHTML = "Cheat!";
    visvers = true;
  }
}