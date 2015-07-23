void main() {
  int x,y;
  char text[7];
  trisb=0;
  portb=0;

uart1_init(9600);

while(1)
{
  x=adc_read(0);
  y=adc_read(1);
  inttostr(x,text);
  uart1_write_text("X=");
  uart1_write_text(text);
  uart1_write(13);
   inttostr(y,text);
  uart1_write_text("Y=");
  uart1_write_text(text);
  uart1_write(13);
  
  
  delay_ms(400);
  if(x>400&&y>400)
  uart1_write_text("welcom");
  else
  rb0_bit=0;
  


}

}