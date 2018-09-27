#ifndef _Ygoal_
#define _Ygoal_

int goal(int B_position, int R_position)
{
   int goal = 0;
   
   if(B_position > 44 || (B_position > 20 && B_position < 30))
   {
      goal = 1;
      PORTA.0 = 1;
      PORTA.1 = 1;
      PORTA.2 = 1;
      PORTA.3 = 1;
      PORTA.4 = 1;
      PORTA.5 = 1;
      PORTA.6 = 1;
      PORTA.7 = 1;
   }
   if(R_position > 44 || (R_position > 20 && R_position < 30))
   {
      goal = 2;
      PORTB.0 = 1;
      PORTB.1 = 1;
      PORTB.2 = 1;
      PORTB.3 = 1;
      PORTB.4 = 1;
      PORTB.5 = 1;
      PORTB.6 = 1;
      PORTB.7 = 1;
   }
   return goal;     
}
#endif