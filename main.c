#include <mega128.h>  
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>
#include <alcd.h>

#define button PINC.0

int B_position = 0, R_position = 0;

#include "./library/Ygoal.c"
#include "./library/throw.c"
#include "./library/Ycount.c"
#include "./library/key.c"
#include "./library/loc.c"
#include "./library/loc2.c"
#include "./library/Ystep.c"
#include "./library/com.c"
#include "./library/text.c"

void main(void)
{
   int turn = 0, yoot = 0, once = 1;  
   int o_B_position, o_R_position;
   bit overlap=1;
   int move_count;  // 말이 한 번에 이동하던 것을 1칸씩 이동하게함
   bit start_flag = 1;

   DDRA = 0xff;
   DDRB = 0xff;
   DDRC = 0x1f;
  
   PORTA.0 = 1;
   PORTA.1 = 1;
   PORTA.2 = 1;
   PORTA.3 = 1;
   PORTA.4 = 1;
   PORTA.5 = 1;
   PORTA.6 = 1;
   PORTA.7 = 1;
   
   PORTB.0 = 1;
   PORTB.1 = 1;
   PORTB.2 = 1;
   PORTB.3 = 1; 
   PORTB.4 = 1;
   PORTB.5 = 1;
   PORTB.6 = 1;
   PORTB.7 = 1;
   
   PORTC.1 = 0;
   PORTC.2 = 1;
   PORTC.3 = 0;
   PORTC.4 = 0;  
   
   PORTD = 0xf7;

while(goal(B_position,R_position)==0)
    {
       if(once == 0)
       {
          if(turn == 0)
              turn = 1;
          else
              turn = 0;
              
          once = 1;
          
          continue;
       }
       else
       {
          if(turn == 0)
          {
             PORTC.1 = 0;
             PORTC.2 = 1;
          }
          else
          {
             PORTC.1 = 1;
             PORTC.2 = 0;
          }
       
          key = key_in();
          if(key_flag == 1)
              key_chk();
              
          yoot = count();
          
          if(yoot == 0)
             yoot = 5;
          
          text(yoot, goal(B_position,R_position));
          
          once--;
       }
       
       
       if(turn == 0)  // B turn
       {
          o_B_position = B_position;  
          
          for(move_count = yoot; move_count > 0; move_count--)
          {
             if(start_flag == 1)
                B_position = location(1, B_position);
             else
                B_position = location2(1, B_position, o_B_position);
             step(B_position, R_position);
             delay_ms(500);
             start_flag = 0;
          }                 
          
          overlap = combine(B_position, R_position);
          
          if(overlap == 1)
             R_position = 0;
          
          step(B_position, R_position);
          start_flag = 1;
       }
       else  // R turn
       {  
          o_R_position = R_position;  
          
          for(move_count = yoot; move_count > 0; move_count--)
          {
             if(start_flag == 1)
                R_position = location(1, R_position);
             else
                R_position = location2(1, R_position, o_R_position);
             step(B_position, R_position);
             delay_ms(500);
             start_flag = 0;
          }                 
          
          overlap = combine(B_position, R_position);
          
          if(overlap == 1)
             B_position = 0;
          
          step(B_position, R_position);
          start_flag = 1;
       }          
       
       once = throw_once_more(overlap, yoot);
       
       delay_ms(10);                          
    }
    
    PORTC.1 = 0;
    PORTC.2 = 0;
    
    text(yoot, goal(B_position,R_position));
}