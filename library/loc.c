#ifndef _loc_
#define _loc_

int location(int yoot,int slot)
{
   int l_slot = 0;
   
   if(slot == 5)//����1
   {
      l_slot = slot + yoot + 25;
   }
   
   else if(slot == 10)//����2
   {  
      if(yoot == 3)
      {
         l_slot = 33;
      }
      else
         l_slot = slot + yoot + 30;
   }                             
   else if(slot == 41 || slot == 42)
   {
      if(slot + yoot == 43)
      {
         l_slot = 33;
      }
      if(slot == 41 && yoot == 1)
      {
        l_slot = 42;  
      }
      else
         l_slot = slot + yoot - 1;  
   }         
   
   else if(slot == 33)//���� �߾�
   {
      l_slot = slot + yoot + 9; 
   }
   else if(slot >= 31 && slot <= 35)
   {
      if(slot + yoot > 35)
      {
         l_slot = slot + yoot - 20;
      }                        
      else
         l_slot = slot + yoot;
   }     
   
   else
      l_slot = slot + yoot; //���� ���� ��
    
   return l_slot;   
}
#endif