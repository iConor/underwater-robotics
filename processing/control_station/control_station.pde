import procontroll.*;
import gamepad.*;

import processing.serial.*;

ControllIO ctrllIO;
ControllDevice ctrllDevice;

ControllSlider rightHorizontal;
ControllSlider rightVertical;
ControllSlider leftVertical;
ControllCoolieHat coolieHat;

Model desired;
Model reported;

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

  // Initialize human-machine interface.
  ctrllIO = ControllIO.getInstance(this);
  GamepadMap gamepad_map = new GamepadMap(ctrllIO);
  ctrllDevice = ctrllIO.getDevice(gamepad_map.getName());
  // Initialize buttons and/or sliders.
  rightVertical = ctrllDevice.getSlider(gamepad_map.getRightStickVertical());
  rightVertical.setTolerance(.16);
  rightHorizontal = ctrllDevice.getSlider(gamepad_map.getRightStickHorizontal());
  rightHorizontal.setTolerance(.16);
  leftVertical = ctrllDevice.getSlider(gamepad_map.getLeftStickVertical());
  leftVertical.setTolerance(.16);

  coolieHat = ctrllDevice.getCoolieHat(gamepad_map.getCoolieHat());

  // Initialize serial communications. 
  serialThread = new SerialThread(this);
}

void draw() {

  if ( coolieHat.pressed() ) {
    update_camera();
  }

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
  rightmotor(R, R_theta);
  leftmotor(L, L_theta);
  Zmotor(Back);
}

