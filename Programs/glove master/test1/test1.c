sbit DI at RC1_BIT;
sbit CLK at RC0_BIT;


void audio(int x)
{
int i;
// start bit
DI=0;
CLK=0;
delay_us(1800);
//send an address to module
for(i=15;i>=0;i--)
{
DI=(x>>i)&1;
CLK=0;
delay_us(200);
CLK=1;
delay_us(200);
}
//stop bit
delay_ms(2);
DI=1;
CLK=1;
}



void main() {
char rec;
int x,y;
int f[5];
char send[7];

uart1_init(9600);

trisc=0b10000000;
DI=1;
CLK=1;
uart1_write_text("hello");
while(1)
{
  if(uart1_data_ready())
  {
    rec=uart1_read();
    if(rec=='1')
    audio(1);
    if(rec=='2')
    audio(2);
    if(rec=='3')
    audio(3);
    if(rec=='4')
    audio(4);
    if(rec=='5')
    audio(5);
  }

f[0]=adc_read(12);
f[1]=adc_read(10);
f[2]=adc_read(8);
f[3]=adc_read(9);
f[4]=adc_read(11);
x=adc_read(0);
y=adc_read(1);
inttostr(f[0],send);
uart1_write_text("f0=");
uart1_write_text(send);
uart1_write(13);
IntToStr(f[1],send);
uart1_write_text("f1=");
uart1_write_text(send);
uart1_write(13);
IntToStr(f[2],send);
uart1_write_text("f2=");
uart1_write_text(send);
uart1_write(13);
IntToStr(f[3],send);
uart1_write_text("f3=");
uart1_write_text(send);
uart1_write(13);
IntToStr(f[4],send);
uart1_write_text("f4=");
uart1_write_text(send);
uart1_write(13);
IntToStr(x,send);
uart1_write_text("x=");
uart1_write_text(send);
uart1_write(13);
IntToStr(y,send);
uart1_write_text("y=");
uart1_write_text(send);
uart1_write(13);
delay_ms(1000);


if(f[0]<170&&f[1]<180&&f[2]<180&&f[3]>250)
{
 audio(2);
 delay_ms(5000);
}

else if(f[0]<170&&f[1]<180&&f[2]<180&&f[3]<170&&rec!='c')
{
 audio(1);
 delay_ms(5000);
}


else if(f[0]>230&&f[1]>230&&f[2]>230&&f[3]>230&&x<280)
{
  audio(3);
  delay_ms(5000);
}



else if(f[0]<170&&f[1]<180&&f[2]<180&&f[3]<170&&rec=='c')
{
 audio(4);
 rec=0;
 delay_ms(5000);
}

else if(f[0]>230&&f[1]>230&&f[2]>230&&f[3]>230&&x>350&&rec=='b')
{
 audio(5);
 rec=0;
 delay_ms(5000);
}


}

}