#ifndef _Ystep_
#define _Ystep_

void step(int B_slot,int R_slot)
{
   switch(B_slot)
   {
      case 0 :       
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 0;
         break;
      case 1 :       
         PORTA.0 = 0;
         PORTA.1 = 0;
         PORTA.2 = 0;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 2 :       
         PORTA.0 = 1;
         PORTA.1 = 0;
         PORTA.2 = 0;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 3 :       
         PORTA.0 = 0;
         PORTA.1 = 1;
         PORTA.2 = 0;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 4 :       
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 0;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 5 :       
         PORTA.0 = 0;
         PORTA.1 = 0;
         PORTA.2 = 1;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
         //1临 场 
            
      case 6 :       
         PORTA.0 = 1;
         PORTA.1 = 0;
         PORTA.2 = 1;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 7 :       
         PORTA.0 = 0;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 8 :       
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 0;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 9 :       
         PORTA.0 = 0;
         PORTA.1 = 0;
         PORTA.2 = 0;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 10 :       
         PORTA.0 = 1;
         PORTA.1 = 0;
         PORTA.2 = 0;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
            //2临场
            
      case 11 :       
         PORTA.0 = 0;
         PORTA.1 = 1;
         PORTA.2 = 0;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 12 :       
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 0;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 13 :       
         PORTA.0 = 0;
         PORTA.1 = 0;
         PORTA.2 = 1;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 14 :       
         PORTA.0 = 1;
         PORTA.1 = 0;
         PORTA.2 = 1;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
      case 15 :       
         PORTA.0 = 0;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 1;
         PORTC.3 = 1;
         break;
         //3临场
            
      case 16 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 0;
         PORTA.5 = 0;
         PORTA.6 = 0;
         PORTA.7 = 0;
         PORTC.3 = 1;
         break;
      case 17 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 1;
         PORTA.5 = 0;
         PORTA.6 = 0;
         PORTA.7 = 0; 
         PORTC.3 = 1;
         break;
      case 18 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 0;
         PORTA.5 = 1;
         PORTA.6 = 0;
         PORTA.7 = 0; 
         PORTC.3 = 1;
         break;
      case 19 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 0;
         PORTA.7 = 0;     
         PORTC.3 = 1;
         break;
      case 20 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 0;
         PORTA.5 = 0;
         PORTA.6 = 1;
         PORTA.7 = 0;     
         PORTC.3 = 1;
         break;            
         //4临场 
            
      case 31 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 1;
         PORTA.5 = 0;
         PORTA.6 = 1;
         PORTA.7 = 0;      
         PORTC.3 = 1;
         break;
      case 32 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 0;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 0;      
         PORTC.3 = 1;
         break;
      case 33 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 1;
         PORTA.7 = 0;     
         PORTC.3 = 1;
         break;
      case 34 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 0;
         PORTA.5 = 0;
         PORTA.6 = 0;
         PORTA.7 = 1;      
         PORTC.3 = 1;
         break;
      case 35 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 1;
         PORTA.5 = 0;
         PORTA.6 = 0;
         PORTA.7 = 1;      
         PORTC.3 = 1;
         break;
         //5临场

      case 41 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 0;
         PORTA.5 = 1;
         PORTA.6 = 0;
         PORTA.7 = 1;       
         PORTC.3 = 1;
         break;
      case 42 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 1;
         PORTA.5 = 1;
         PORTA.6 = 0;
         PORTA.7 = 1;      
         PORTC.3 = 1;
         break;
      case 43 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 0;
         PORTA.5 = 0;
         PORTA.6 = 1;
         PORTA.7 = 1;    
         PORTC.3 = 1;
         break;
      case 44 :
         PORTA.0 = 1;
         PORTA.1 = 1;
         PORTA.2 = 1;
         PORTA.3 = 1;       
         PORTA.4 = 1;
         PORTA.5 = 0;
         PORTA.6 = 1;
         PORTA.7 = 1;      
         PORTC.3 = 1;
         break;                       
            //6临场
      default :
         break;         
   }

   switch(R_slot)
   {
      case 0 :       
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 0;
         break;
      case 1 :       
         PORTB.0 = 0;
         PORTB.1 = 0;
         PORTB.2 = 0;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 2 :       
         PORTB.0 = 1;
         PORTB.1 = 0;
         PORTB.2 = 0;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 3 :       
         PORTB.0 = 0;
         PORTB.1 = 1;
         PORTB.2 = 0;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 4 :       
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 0;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 5 :       
         PORTB.0 = 0;
         PORTB.1 = 0;
         PORTB.2 = 1;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
         //1临 场 
            
      case 6 :       
         PORTB.0 = 1;
         PORTB.1 = 0;
         PORTB.2 = 1;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 7 :       
         PORTB.0 = 0;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 8 :       
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 0;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 9 :       
         PORTB.0 = 0;
         PORTB.1 = 0;
         PORTB.2 = 0;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 10 :       
         PORTB.0 = 1;
         PORTB.1 = 0;
         PORTB.2 = 0;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
            //2临场
            
      case 11 :       
         PORTB.0 = 0;
         PORTB.1 = 1;
         PORTB.2 = 0;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 12 :       
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 0;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 13 :       
         PORTB.0 = 0;
         PORTB.1 = 0;
         PORTB.2 = 1;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 14 :       
         PORTB.0 = 1;
         PORTB.1 = 0;
         PORTB.2 = 1;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
      case 15 :       
         PORTB.0 = 0;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 1;
         PORTC.4 = 1;
         break;
         //3临场
            
      case 16 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 0;
         PORTB.5 = 0;
         PORTB.6 = 0;
         PORTB.7 = 0;
         PORTC.4 = 1;
         break;
      case 17 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 1;
         PORTB.5 = 0;
         PORTB.6 = 0;
         PORTB.7 = 0; 
         PORTC.4 = 1;
         break;
      case 18 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 0;
         PORTB.5 = 1;
         PORTB.6 = 0;
         PORTB.7 = 0; 
         PORTC.4 = 1;
         break;
      case 19 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 0;
         PORTB.7 = 0;     
         PORTC.4 = 1;
         break;
      case 20 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 0;
         PORTB.5 = 0;
         PORTB.6 = 1;
         PORTB.7 = 0;     
         PORTC.4 = 1;
         break;            
         //4临场 
            
      case 31 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 1;
         PORTB.5 = 0;
         PORTB.6 = 1;
         PORTB.7 = 0;      
         PORTC.4 = 1;
         break;
      case 32 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 0;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 0;      
         PORTC.4 = 1;
         break;
      case 33 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 1;
         PORTB.7 = 0;     
         PORTC.4 = 1;
         break;
      case 34 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 0;
         PORTB.5 = 0;
         PORTB.6 = 0;
         PORTB.7 = 1;      
         PORTC.4 = 1;
         break;
      case 35 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 1;
         PORTB.5 = 0;
         PORTB.6 = 0;
         PORTB.7 = 1;      
         PORTC.4 = 1;
         break;
         //5临场

      case 41 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 0;
         PORTB.5 = 1;
         PORTB.6 = 0;
         PORTB.7 = 1;       
         PORTC.4 = 1;
         break;
      case 42 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 1;
         PORTB.5 = 1;
         PORTB.6 = 0;
         PORTB.7 = 1;      
         PORTC.4 = 1;
         break;
      case 43 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 0;
         PORTB.5 = 0;
         PORTB.6 = 1;
         PORTB.7 = 1;    
         PORTC.4 = 1;
         break;
      case 44 :
         PORTB.0 = 1;
         PORTB.1 = 1;
         PORTB.2 = 1;
         PORTB.3 = 1;       
         PORTB.4 = 1;
         PORTB.5 = 0;
         PORTB.6 = 1;
         PORTB.7 = 1;      
         PORTC.4 = 1;
         break;                       
            //6临场
      default :
         break;         
   }
}
#endif