import processing.serial.*;

import procontroll.*;
import net.java.games.input.*;

Serial Robot;
Comm comm;

ControllIO ctrllIO;
ControllDevice gamepad;

ControllSlider rightHorizontal;
ControllSlider rightVertical;
ControllSlider leftVertical;

float X, Y, Z;
float x_prime, y_prime;
float L_x, R_x;
float L_theta, R_theta;
float L, R, Back;
float a = 0.3; //constant?

void setup() {

  // Initialize serial communications.
  Robot = new Serial( this, Serial.list()[0], 9600 );  
  comm = new Comm( 9600 );
  comm.start();

  // Initialize human-machine interface.
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

  // Read gamepad values.
  X = rightVertical.getValue();
  Y = rightHorizontal.getValue();
  Z = leftVertical.getValue();

  // Convert gamepad values to ?
  x_prime = ( X + Y ) * 0.707; //constant?
  y_prime = ( Y - X ) * 0.707; //constant?
  R_x=y_prime;
  L_x=-x_prime;

  // ?
  vector_control();

  // Update Communication class.
  comm.rightmotor(R, R_theta);
  comm.leftmotor(L, L_theta);
  comm.Zmotor(Back);
}

