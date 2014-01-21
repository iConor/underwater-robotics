import processing.serial.*;

import procontroll.*;
import net.java.games.input.*;

Serial serial;
SerialThread serialThread;

ControllIO ctrllIO;
ControllDevice ctrllDevice;

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
  serial = new Serial( this, Serial.list()[0], 9600 );  
  serialThread = new SerialThread( 9600 );
  serialThread.start();

  // Initialize human-machine interface.
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
  serialThread.rightmotor(R, R_theta);
  serialThread.leftmotor(L, L_theta);
  serialThread.Zmotor(Back);
}

