//This will be the main program
import processing.serial.*;

import procontroll.*;
import java.io.*;

ControllIO ctrllIO;
ControllDevice ctrllDevice;
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
  
  // Initialize video game controller.
  ctrllIO = ControllIO.getInstance(this);
  Gamepad gamepad = new Gamepad(ctrllIO);
  ctrllDevice = ctrllIO.getDevice(gamepad.name());
  // Initialize buttons and/or sliders.
  rightVertical = ctrllDevice.getSlider(gamepad.rightStickVertical());
  rightVertical.setTolerance(.16);
  rightHorizontal = ctrllDevice.getSlider(gamepad.rightStickHorizontal());
  rightHorizontal.setTolerance(.16);
  leftVertical = ctrllDevice.getSlider(gamepad.leftStickVertical());
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

