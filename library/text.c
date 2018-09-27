#ifndef _text_
#define _text_


unsigned char user_font1[5][8] = {
    0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 도
    0x1F, 0x00, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, // 개
    0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x00, 0x00, // 걸
    0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, // 윷
    0x1F, 0x11, 0x1F, 0x00, 0x04, 0x04, 0x1F, 0x00, // 모
    };

unsigned char blue_win[8][8] = {
    0x1E, 0x11, 0x11, 0x1E, 0x11, 0x11, 0x1E, 0x00, // B
    0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x1F, 0x00, // L
    0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E, 0x00, // U
    0x1F, 0x10, 0x10, 0x1F, 0x10, 0x10, 0x1F, 0x00, // E
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
    0x15, 0x15, 0x15, 0x15, 0x15, 0x1F, 0x0A, 0x00, // W
    0x0E, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E, 0x00, // I
    0x11, 0x19, 0x19, 0x15, 0x13, 0x13, 0x11, 0x00, // N
    };

unsigned char red_win[8][8] = {
    0x1E, 0x11, 0x11, 0x1E, 0x14, 0x12, 0x11, 0x00, // R
    0x1F, 0x10, 0x10, 0x1F, 0x10, 0x10, 0x1F, 0x00, // E
    0x1E, 0x11, 0x11, 0x11, 0x11, 0x13, 0x1E, 0x00, // D
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
    0x15, 0x15, 0x15, 0x15, 0x15, 0x1F, 0x0A, 0x00, // W
    0x0E, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E, 0x00, // I
    0x11, 0x19, 0x19, 0x15, 0x13, 0x13, 0x11, 0x00, // N
    }; 


                
int i, j, k;

void text(int yoot, int goal)
{
    if(goal == 0){  // 나온 윷을 Character LCD에 출력     
        lcd_init(1);

        switch(yoot)
        {
            case 1:  // 도           
                for(i = 0; i < 8; i++)
                {               
                    lcd_write_byte(0x40 + i, user_font1[0][i]);
                    delay_us(10);
                }
                break;
            case 2:  // 개
                for(i = 0; i < 8; i++)
                {
                    lcd_write_byte(0x40 + i, user_font1[1][i]);
                    delay_us(10);
                }
                break;
            case 3:  // 걸
                for(i = 0; i < 8; i++)
                {
                    lcd_write_byte(0x40 + i, user_font1[2][i]);  
                    delay_us(10);
                }
                break;
            case 4:  // 윷
                for(i = 0; i < 8; i++)
                {
                    lcd_write_byte(0x40 + i, user_font1[3][i]);  
                    delay_us(10);
                }
                break;
            case 5:  // 모
                for(i = 0; i < 8; i++)
                {
                    lcd_write_byte(0x40 + i, user_font1[4][i]);
                    delay_us(10);
                }
                break;
        }
        lcd_gotoxy(0,0);
        lcd_putchar(0);   
    } 
    else{  // 승자를 Character LCD에 출력
        lcd_init(8);

        for(i = 0; i < 8; i++)
        {
            if(goal == 1){  // blue win
                lcd_write_byte(0x40 + i, blue_win[0][i]); delay_us(10);                   
                lcd_write_byte(0x48 + i, blue_win[1][i]); delay_us(10);
                lcd_write_byte(0x50 + i, blue_win[2][i]); delay_us(10);
                lcd_write_byte(0x58 + i, blue_win[3][i]); delay_us(10);
                lcd_write_byte(0x60 + i, blue_win[4][i]); delay_us(10);
                lcd_write_byte(0x68 + i, blue_win[5][i]); delay_us(10);
                lcd_write_byte(0x70 + i, blue_win[6][i]); delay_us(10);
                lcd_write_byte(0x78 + i, blue_win[7][i]); delay_us(10);
            }
            else{  // red win
                lcd_write_byte(0x40 + i, red_win[0][i]); delay_us(10);                   
                lcd_write_byte(0x48 + i, red_win[1][i]); delay_us(10);
                lcd_write_byte(0x50 + i, red_win[2][i]); delay_us(10);
                lcd_write_byte(0x58 + i, red_win[3][i]); delay_us(10);
                lcd_write_byte(0x60 + i, red_win[4][i]); delay_us(10);
                lcd_write_byte(0x68 + i, red_win[5][i]); delay_us(10);
                lcd_write_byte(0x70 + i, red_win[6][i]); delay_us(10);
                lcd_write_byte(0x78 + i, red_win[7][i]); delay_us(10);
            }
        }  
        lcd_gotoxy(0,0);
        for(i = 0; i < 8; i++)
        {
            lcd_putchar(i);
        }
    }     
}

#endif