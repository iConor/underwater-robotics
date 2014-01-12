#include <Servo.h>


byte check=243;

#define LEFT_SERVO=9;
#define RIGHT_SERVO=10;
#define RIGHT_MOTOR=6;
#define LEFT_MOTOR=5;

Servo lservo;
Servo Rservo;

int LM,RM,LS,RS,ZM;
void setup()
{
  Serial.begin(9600);
  lservo.attach(9,400,2200);
  Rservo.attach(10,400,2200);
  
}
void loop(){
  Serial.write(check);
  
  while (Serial.available()<5){}
  
    LM=Serial.read();
    LS=Serial.read();
    RM=Serial.read();
    RS=Serial.read();
    ZM=Serial.read();
    
    Serial.write(LM);
    Serial.write(RM);
    
    analogWrite(5,LM);
    analogWrite(6,RM);
    
    lservo.write(LS);                  // sets the servo position according to the scaled value 
    Rservo.write(RS);
  delay(15);                           // waits for the servo to get there 

    
    
}
  
    

