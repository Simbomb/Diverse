//main program
//Made by Simon Wickman and Philip Zandin
//v0.1

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#define TM2PERIOD (8000000 / 256) / 10
#define TM3PERIOD (8000000 / 256) / 10
  volatile int * portE = (volatile int *) 0xbf886110; //init PORTE for leds
  int mytime = 0x5957;

  //For speed of the game
  int timeout = 0;
  int currentspeed = 30; //every 3 seconds (divide by 10)
  int timer3out = 0;
  
  
  //current height of shape
  int yshape = 10; //chance value to height of lcd
  
//Interrupt Service Routine
void user_isr( void )
{
	//Switch 1
   if(IFS(0) & 0x80)
   {
		IFS(0) = 0;
		
   }
  //Switch 2
   if(IFS(0) & (1 << 11))
   {
		IFS(0) = 0;
		
   }
  //Switch 3
   if(IFS(0) & (1 << 15))
   {
		IFS(0) = 0;
		
   }
  //Switch 4
   if(IFS(0) & (1 << 19))
   {
		IFS(0) = 0;
		
   }  
  //Timer 2
  if(IFS(0) & 0x100)
  {
	IFS(0) = 0;
	timeout++; 
  }
  if(timeout == currentspeed)
  {
	display_update();
	tick(&mytime);
	
	timeout = 0;
	game();
  }
  
  //Timer 3
  if(IFS(0) & (1 << 12))
  {
	  IFS(0) = 0;
	  timer3out = 0;
	  if(timer3out == 100)//increase speed of game every 10 second
	  {
		  if(currentspeed >= 8) //max speed
		  {
			currentspeed--;
		  }
	  }
  {
	display_update();
	tick(&mytime);
	timeout = 0;
  }
  }
  

  
  
  
  return;
}

//init
void setup( void )
{
  volatile int * trise = (volatile int *) 0xbf886100; //init TRISE so bit 0-8 is output
  * trise = * trise & ~0xff;
  TRISD = TRISD & 0x0fe0; //init TRISD so port 5-11 is output
  * portE = 0x0; //reset PORTE
  drawsetup();
  
  //Declare buttons and switches


  
  //Timer 2
  PR2 = TM2PERIOD;
  T2CONSET = 0x70; //prescale 1:256
  TMR2 = 0; //clear timercontent
  T2CONSET = 0x8000; //start timer
  
  
  //Timer 3
  PR3 = TM3PERIOD;
  T3CONSET = 0x70; //prescale 1:256
  TMR3 = 0; //clear timercontent
  T3CONSET = 0x8000; //start timer
  
  
  //Interrupt
  //Timer 2
  IPCSET(2) = 4;
  IECSET(0) = 0x100;
  
  //Timer 3
  IPCSET(3) = 4;
  IECSET(0) = (1 << 12);
  
  //Switch 1
  IPCSET(1) = 0x1c000000;
  IECSET(0) = 0x80;
  
  //Switch 2
  IPCSET(2) =  0x1c000000;
  IECSET(0) = (1 << 11);
  
  //Switch 3
  IPCSET(3) =  0x1c000000;
  IECSET(0) = (1 << 15);
  
  //Switch 4
  IPCSET(4) =  0x1c000000;
  IECSET(0) = (1 << 19);

	
  enable_interrupt();
  return;
}

//called repetitively
void mainwork()
{
	draw();
	
	
	
}

void gamestart()
{
	  int btn = getbutton();
	  int sw = getswitch();
		if(btn & 1) //rotate
		{
			rotate();
		}
		if(btn & 2) //move right
		{
			moveRight();
		}
		if(btn & 4) //down
		{
			down();
		}
		if(btn & 8) // move left
		{
			moveLeft();
		}
	//update screen	
	 
}


