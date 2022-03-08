/*
Detta är ett spel som börjar som ett rutnät som blir lite av en labyrint då man inte kan gå överallt. Spelaren börjar längst upp i vänster och man kan gå ett “steg” i taget för att komma i mål som finns på andra sidan av rutnätet. Vid målet kommer en annan spelare börja (styrs av en dator) vars uppgift är att fånga en (som också går ett steg i taget).
Kontroller: W: up, A: vänster, S: ner och D: höger. R: reset. " "/space: gör om de närmsta svarta rutor till vita.

Skapad av Simon Wickman
Version 2.0
09/05/2019
*/


//ändra cols och rows till samma tal för att ändra storlek
var cols = 16;
var rows = 16;

var rutnät = new Array(cols);
var test_rutnät = new Array(cols)
var giltig = true;
var spelar_x = 0;
var spelar_y = 0;
var mot_x = cols - 1;
var mot_y = rows - 1;
var score = 0;
var tot_moves = 0;
var clears = 3;

//funktionen setup skapar canvas och skapar två, 2d arrays.
function setup()
{
  createCanvas(cols * 30, rows * 30); 
  for(var g = 0; g < cols; g++) 
  {
    rutnät[g] = new Array(rows);
    test_rutnät[g] = new Array(rows)
  }
  rutnät_setup();
}

//funktionen rutnät_setup, skapar slumpmässigt en spelplan och testar om den är lösbar om inte gör den om det.
function rutnät_setup()
{
  while (giltig) 
  {
    // skapa logiskt rutnät
    for (var i = 0; i < rows; i++) 
    {
      for (var j = 0; j < cols; j++) 
      {
        //ändrar man chansen så kan det till slut bli omöjligt att klara och spelet startar aldrig
        var random = Math.round((Math.random() * 7));
        rutnät[i][j] = random >= 3 ? 1 : 0;
        test_rutnät[i][j] = random >= 3 ? 1 : 0;
      }

    }
    // ser till att start och slut är spelare och mål.
    rutnät[rows - 1][cols - 1] = 3;
    rutnät[0][0] = 2;
    // kolla om spelet går att lösa 
    var testx = 0;
    var testy = 0;
    var test_giltig = true;
    while (test_giltig)
    {
      var xv = 1;
      var xh = 1;
      var yu = 1;
      var yn = 1;

      //if satser för att inte få out of bounds error på arrayen!
      if (testx == cols - 1)
      {
        xh = 0;
      }
      if (testx == 0) 
      {
        xv = 0;
      }
      if (testy == rows - 1)
      {
        yn = 0;
      }
      if (testy == 0)
      {
        yu = 0;
      }

      if (testx == cols - 1 && testy == rows - 1) //kolla om den är i mål
      {
        test_giltig = false;
        giltig = false;
      } 
      else if (test_rutnät[testx + xh][testy] >= 1 && xh != 0) //gå höger
      {
        testx++;
      }
      else if (test_rutnät[testx][testy + yn] >= 1 && yn != 0) //gå ner
      {
        testy++;
      }
      else if (test_rutnät[testx - xv][testy] >= 1 && xv != 0) //gå vänster
      {
        test_rutnät[testx][testy] = 0;
        testx--;
      }
      else if (test_rutnät[testx][testy - yu] >= 1 && yu != 0) //gå up
      {
        test_rutnät[testx][testy] = 0;
        testy--;
      }
      else //inte giltig lösning
      {
        test_giltig = false;
      }

    }
  }
}


//funktionen draw anropas ständigt. Den kollar vinst förlust och ritar spelplanen grafiskt.
function draw()
{
  background(51);
  
  // ser till att mål alltid finns
  rutnät[cols-1][rows-1] = 3; 
  
  // Gör spel plan grafiskt
  // 1 är vit/väg , 0 är svart/väggar, 2 är ljusblå/spelare, 3 är grön/mål och 4 är röd/bot
  for (var i = 0; i < rows; i++)
  {
    for (var j = 0; j < cols; j++)
    {
      var x = i * 30;
      var y = j * 30;

      if (rutnät[i][j] == 1) 
      {
        fill(255);
        rect(x, y, cols * 3, rows * 3);
      } 
        else if (rutnät[i][j] == 2) 
      {
        fill(0, 255, 255);
        rect(x, y, cols * 3, rows * 3);
      } 
        else if (rutnät[i][j] == 3)
      {
        fill(0, 255, 0);
        rect(x, y, cols * 3, rows * 3);
      } 
        else if (rutnät[i][j] == 4) 
      {
        fill(255, 0, 0);
        rect(x, y, cols * 3, rows * 3);
      } 
        else 
      {
        fill(0);
        rect(x, y, cols * 3, rows * 3);
      }
    }
  }


  //kolla vinst och starta om spelet
  if (spelar_x == cols - 1 && spelar_y == rows - 1) 
  {
    giltig = true;
    spelar_x = spelar_y = 0;
    mot_x = cols - 1;
    mot_y = rows - 1;
    currentscore();
    rutnät_setup();
  }
  
   //kolla förlust
  if ((mot_x == spelar_x) && (mot_y == spelar_y))
  {
    giltig = true;
    spelar_x = spelar_y = 0;
    mot_x = cols - 1;
    mot_y = rows - 1;
    deletescore();
    rutnät_setup();
  }

}

//funktionen keyPressed kollar om man trycker på någon tangent och utför då något
function keyPressed() {

  //if satser som kollar W, A, S, D rör spelaren åt något håll
  if((key == 'w' || key == 'W') && spelar_y != 0)
  {
    if (rutnät[spelar_x][spelar_y - 1] != 0)
    {
      rutnät[spelar_x][spelar_y] = 1;
      rutnät[spelar_x][spelar_y - 1] = 2;
      spelar_y--;
      tot_moves++;
      motståndare();
    }
  }
  if((key == 'a' || key == 'A') && spelar_x != 0)
  {
    if (rutnät[spelar_x - 1][spelar_y] != 0) 
    {
      rutnät[spelar_x][spelar_y] = 1;
      rutnät[spelar_x - 1][spelar_y] = 2;
      spelar_x--;
      tot_moves++;
      motståndare();
    }
  }
  if((key == 's' || key == 'S') && spelar_y != rows - 1)
  {
    if (rutnät[spelar_x][spelar_y + 1] != 0)
    {
      rutnät[spelar_x][spelar_y] = 1;
      rutnät[spelar_x][spelar_y + 1] = 2;
      spelar_y++;
      tot_moves++;
      motståndare();
    }
  }
  if((key == 'd' || key == 'D') && spelar_x != cols - 1)
  {
    if (rutnät[spelar_x + 1][spelar_y] != 0)
    {
      rutnät[spelar_x][spelar_y] = 1;
      rutnät[spelar_x + 1][spelar_y] = 2;
      spelar_x++;
      tot_moves++;
      motståndare();
    }
  }
  //om man trycker 'r' resetar den banan och man kan börja om
  if(key == 'r' || key == 'R')
  {
    giltig = true;
    spelar_x = spelar_y = 0;
    mot_x = cols - 1;
    mot_y = rows - 1;
    deletescore();
    rutnät_setup();
  }
  //vid tryck av space använder man en clear vilket tar bort alla svarta rutor precis runt omkring en
  if(key == ' ' && clears != 0)
  {
    clears--;
    document.getElementById("skip").innerHTML = "Clears left: " + clears;
    var ri = -1;
    var rj = -1;
    var xcap = 1;
    var ycap = 1;
    if(spelar_x == 0)
    {
      ri = 0;
    }
    if(spelar_y == 0)
    {
      rj = 0;
    }
    if(spelar_x == cols-1)
    {
      xcap = 0;
    }
    if(spelar_y == rows-1)
    {
      ycap = 0;
    }
    for( ; ri <= xcap ; ri++)
    {
      for( ; rj <= ycap ; rj++)
      {
        if( rutnät[ri+spelar_x][rj+spelar_y] == 0)
          {
            rutnät[ri+spelar_x][rj+spelar_y] = 1;
          }
      }
      if(spelar_y == 0)
      {
        rj = 0;
      }
      else
      {
        rj = -1;
      }
    }
  }

}

//funktionen motståndare anropas vid varje W, A, S, D tryck och bestämmer hur motståndaren ska gå
function motståndare()
{
  
  if (spelar_x == mot_x - 1 && rutnät[mot_x][mot_y - 1] != 0 && spelar_y == mot_y - 1) //om man är nära ska man inte kunna lura den.
  {
      rutnät[mot_x][mot_y] = 1;
      rutnät[mot_x][mot_y - 1] = 4;
      mot_y--;
  } 
  else if (spelar_x == mot_x - 1 && rutnät[mot_x][mot_y + 1] != 0 && spelar_y == mot_y + 1) //om man är nära...
  {  
      rutnät[mot_x][mot_y] = 1;
      rutnät[mot_x][mot_y + 1] = 4;
      mot_y++;
  }
  else if ((spelar_x < mot_x) && (rutnät[mot_x - 1][mot_y] != 0)) //går vänster
  {
    rutnät[mot_x][mot_y] = 1;
    rutnät[mot_x - 1][mot_y] = 4;
    mot_x--;
  }
  else if (spelar_y < mot_y && rutnät[mot_x][mot_y - 1] != 0) //går upp
  {
    rutnät[mot_x][mot_y] = 1;
    rutnät[mot_x][mot_y - 1] = 4;
    mot_y--;
  }
  else if (spelar_x > mot_x)  //går höger
  {
    rutnät[mot_x][mot_y] = 1;
    rutnät[mot_x + 1][mot_y] = 4;
    mot_x++;
  }
  else if (spelar_y > mot_y) //går ner
  {
    rutnät[mot_x][mot_y] = 1;
    rutnät[mot_x][mot_y + 1] = 4;
    mot_y++;
  }
  else if (spelar_y == mot_y && rutnät[mot_x][mot_y - 1] != 0)
  {
    rutnät[mot_x][mot_y] = 1;
    rutnät[mot_x][mot_y - 1] = 4;
    mot_y--;
  }
  else if(mot_x != cols-1)
  {
    rutnät[mot_x][mot_y] = 0;
    rutnät[mot_x + 1][mot_y] = 4;
    mot_x++;
  }

}

//funktionen deletescore anropas då man resetar eller förlorar och sätter alla värden tillbaka igen
function deletescore()
{
  tot_moves = 0;
  score = 0;
  clears= 3
  document.getElementById("skip").innerHTML = "Clears left: " + clears;
  document.getElementById("score").innerHTML = "Score: " + score;
}

//funktionen currentscore anropas vid vinst och beräknar hur många poäng man tjänade
function currentscore()
{
  score = score + round(10000/tot_moves) + Math.round((Math.random() * 50));
  tot_moves = 0;
  document.getElementById("score").innerHTML = "Score: " + score;
  
}
