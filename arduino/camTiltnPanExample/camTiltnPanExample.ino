
#include<Servo.h>
Servo vert;
Servo hori;
int x=90;
int y=90;

void setup(){
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  pinMode(A3, INPUT);
  vert.attach(3);
  hori.attach(5);
  establishContact();
}
void loop(){
  delay(15);
  if (digitalRead(A0)==HIGH){
  y=y+1;
  }
  else if (digitalRead(A1)==HIGH){
  y=y-1;
  }
  if (digitalRead(A2)==HIGH){
   x=x+1;
  }
  else if (digitalRead(A3)==HIGH){
   x=x-1;
  }
  if (x>180){
   x=180; 
  }
  else if (x<0){
   x=0;
  }
  if (y>180){
   y=180; 
  }
  else if (y<0){
   y=0;
  }
  vert.write(y);
  hori.write(x);
  Serial.print(x);
  Serial.println(y);
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0");   // send an initial string
    delay(300);
  }
}
