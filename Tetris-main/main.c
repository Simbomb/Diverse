#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */


int main(void)
{
	setup();
	
	
	while( 1 )
	{
		mainwork();
	}
	return 0;
}