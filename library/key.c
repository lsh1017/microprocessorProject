#ifndef _key_
#define _key_

unsigned char key;
bit key_flag = 0;

char key_in(void)
{
    char buf = 0;
    
    if((PINC & 0x01) != 0x01)
    {
       //key in ok
        buf = (PINC & 0x01);
        key_flag = 1;
        
        while((PINC & 0x01) != 0x01)
        {
             delay_ms(1);
        }
        delay_ms(2);
    }
    
    return buf;
}

void key_chk(void)
{
    key_flag = 0;
    
    switch(key)
    {
        case 0x01:
            count();
        break;
    }
}
#endif