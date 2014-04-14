import procontroll.*;
import gamepad.*;

import processing.serial.*;

Model desired;
Model reported;
Gamepad gamepad;

SerialThread serialThread;

float X, Y, Z;
float x_prime, y_prime;
float L_x, R_x;
float L_theta, R_theta;
float L, R, Back;

void setup() {
  
  // Initialize robot models.
  desired = new Model();
  reported = new Model();
  
  // Initialize interface device.
  gamepad = new Gamepad(this);

  // Initialize serial communications. 
  serialThread = new SerialThread(this);
}

void draw() {
  
  gamepad.update();

  // Convert gamepad values to ?
  x_prime = ( X + Y ) * 0.707; //constant?
  y_prime = ( Y - X ) * 0.707; //constant?
  R_x=y_prime;
  L_x=-x_prime;

  // ?
  vector_control();

  // Update Communication class.
  rightmotor(R, R_theta);
  leftmotor(L, L_theta);
  Zmotor(Back);
}

