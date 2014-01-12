#include <Servo.h>
#include <SoftwareSerial.h>


byte check=243;

#define LEFT_SERVO=9;
#define RIGHT_SERVO=10;


Servo lservo;
Servo Rservo;

int LM,RM,LS,RS,ZM;

long int time;
boolean run=true;

SoftwareSerial motorserial(10,11);

void setup()
{
  Serial.begin(9600);
  motorserial.begin(9600);
  lservo.attach(5,400,2200);
  Rservo.attach(6,400,2200);
  
  
}
void loop(){
  time=millis();
  Serial.write(check);
  
  while (Serial.available()<5){
    //have a timeout if we lose comunication
    /*if ((millis()-time)>1500){
      //clear the buffer
      while(Serial.available()>0){
        Serial.read();
      }
      delay(500);
      Serial.write(check);
    }*/
  }
      
      
    LM=Serial.read();
    LS=Serial.read();
    RM=Serial.read();
    RS=Serial.read();
    ZM=Serial.read();
    
    Serial.write(LM);
    Serial.write(RM);
    
    motorControl(128,1,LM);
    motorControl(128,2,RM);
    
    lservo.write(LS);                  // sets the servo position according to the scaled value 
    Rservo.write(RS);
  delay(15);                           // waits for the servo to get there 

    
    
}
  
  
void motorControl(int address_, int motor_,int power){
  int speed_;
  motorserial.write(address_);
  if(motor_==1)
  {
    if(power>=128)
    {
      speed_=power-127;
      motorserial.write((byte)0);
      motorserial.write(speed_);
      motorserial.write((speed_+address_)&127);
    }
    else
    {
      speed_=127-power;
      motorserial.write(1);
      motorserial.write(speed_);
      motorserial.write((speed_+address_+1)&127);
    }
  }
  else
  {
    if(power>=128)
    {
      speed_=power-127;
      motorserial.write(4);
      motorserial.write(speed_);
      motorserial.write((speed_+address_+4)&127);
    }
    else
    {
      speed_=127-power;
      motorserial.write(5);
      motorserial.write(speed_);
      motorserial.write((speed_+address_+5)&127);
    }
  }
}
