#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */

int getswitch(void){
    return (PORTD>>8) & 0x000f;
}
int getbutton(void){
    return (PORTD>>5) & 0x0007;   
}

