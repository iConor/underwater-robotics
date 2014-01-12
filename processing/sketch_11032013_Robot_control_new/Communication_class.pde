import processing.serial.*;
class Comm extends Thread {
  boolean running=false;
  byte Z_motor, left_motor, right_motor;
  byte left_servo, right_servo, claw_servo;
  int cam_servo_x, cam_servo_y, check;
  int time;
  //byte[] inBuffer = new byte[NUMBER_BYTES];
  //int[] sensors = new int[NUMBER_OF_SENSORS];


  Comm(int Baud_Rate) {/*
    //make a serial class Robot
   Serial Robot;
   //list the available serial ports
   println(Serial.list());
   //open robot port
   Robot = new Serial(this, Serial.list()[1], Baud_Rate);*/
  }

  void start() {
    running=true;
    super.start();
  }

  //This get triggered by start
  void run() {
    while (running) {
      //send a byte to tell the arduion to start the communication
      
      //wait to recieve data from the robot
      time=millis();
      while (Robot.available ()<1) {
        /*if ((millis()-time)>1500){
          //clear the buffer
          while(Robot.available()>0){
          Robot.read();
        }
        while (Robot.available ()<1) {}
      }*/
      }
      check=Robot.read();
      if (check==243)
      {
        Robot.write(left_motor);
        Robot.write(left_servo);
        Robot.write(right_motor);
        Robot.write(right_servo);
        Robot.write(Z_motor);
      }
      while (Robot.available()<2){}
      println(Robot.read()+"    "+Robot.read());
      check=0;
    }
  }
  /*void quit() {
   running = false;
   }
   
   //makes sensor data avalible to the main program
   int sensor_data(int sensor_number){
   return sensors[sensor_number];
   }*/

  //provides motor power inputs
  void Zmotor(float power) {
    Z_motor=byte(int(map(power, -1, 1, 22, 240)));
  }
  void leftmotor(float power, float angle) {
    if(power>0){
      left_motor=byte(power*120+128);
    }
    else{
      left_motor=byte(power*120-128);
    }
    left_servo=byte(angle);//int(map(angle,0,180,0,255));
  }
  void rightmotor(float power, float angle) {
    if (power>0){
    right_motor=byte(power*120+128);
    }
    else{
      right_motor=byte(power*120-128);
    }
    right_servo=byte(angle);//int(map(angle,0 180,0,255));
  }

  /* void claw(float something){
   //do stuff
   }*/
}

