//This will be the main program
import processing.serial.*;

import procontroll.*;
import java.io.*;

ControllIO ctrllIO;
ControllDevice gamepad;
  Serial Robot;
  
ControllSlider rightHorizontal;
ControllSlider rightVertical;
ControllSlider leftVertical;


Comm com;
float X;
float Y;
float x_prime, y_prime;
float a = 0.3;

void setup() {

 
  //list the available serial ports
    println(Serial.list());
    //open robot port
    Robot = new Serial(this, Serial.list()[0], 9600);
    
  com = new Comm(9600);
  com.start();
  ctrllIO = ControllIO.getInstance(this);
  gamepad = ctrllIO.getDevice("Controller (Xbox 360 Wireless Receiver for Windows)");
  rightVertical = gamepad.getSlider(2);
  rightVertical.setTolerance(.16);
  rightHorizontal = gamepad.getSlider(3);
  rightHorizontal.setTolerance(.16);
  leftVertical = gamepad.getSlider(0);
  leftVertical.setTolerance(.16);
}

void draw() {

  //take code for controller
  X = rightVertical.getValue();
  Y = rightHorizontal.getValue();
  Z = leftVertical.getValue();

  x_prime = (X+Y)*0.707;
  y_prime = (Y-X)*0.707;
  R_x=y_prime;
  L_x=-x_prime;
  vector_control();
  com.rightmotor(R, R_theta);
  com.leftmotor(L, L_theta);
  com.Zmotor(Back);
}

