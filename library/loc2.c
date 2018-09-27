#ifndef _loc2_
#define _loc2_

int location2(int yoot,int slot, int o_slot)
{
   int l_slot = 0;                          
   
   if(slot == 42)
   {
      l_slot = 33;
   }   
   
   else if(slot == 33)  // ¸»±æ Áß¾Ó
   {
      if(o_slot == 5 || o_slot == 31 || o_slot == 32)
        l_slot = 34;
      else
        l_slot = 43;
   }
   
   else
    l_slot = slot + yoot;  //½½·Ô ¿¬»ê ³¡
    
   return l_slot;   
}
#endif