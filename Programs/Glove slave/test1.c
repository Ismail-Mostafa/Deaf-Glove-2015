void main() {
char rec;
int x,y;
int f[5];
char send[7];

uart1_init(9600);

trisc=0b10000000;
while(1)
{

f[0]=adc_read(12);
f[1]=adc_read(10);
f[2]=adc_read(8);
f[3]=adc_read(9);
f[4]=adc_read(11);
x=adc_read(0);
y=adc_read(1);


/*inttostr(f[0],send);
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
delay_ms(1000);*/





if(f[1]<180&&f[2]<180)
{
 uart1_write('c');
 delay_ms(5000);
}



else if(f[1]>200&&f[2]>200&&y>370)
{
 uart1_write('b');
 delay_ms(5000);
}


}

}