#ifndef _Ycount_
#define _Ycount_

int count()
{
   int cnt = 0;
   int time = 0;
   bit yoot_array1;
   bit yoot_array2;
   bit yoot_array3;
   bit yoot_array4;
   
   while(1)
   {
      if((PINC & 0x01) != 0x01)
         break;
      time++;
   }
   
   srand(time);
  
   yoot_array1 = rand()%2;
   delay_ms(1);
   yoot_array2 = rand()%2;
   delay_ms(1);
   yoot_array3 = rand()%2;
   delay_ms(1);
   yoot_array4 = rand()%2;
                          
   cnt = yoot_array1 + yoot_array2 + yoot_array3 + yoot_array4;          

   return cnt;
}
#endif