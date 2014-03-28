import procontroll.*;
import net.java.games.input.*;

import processing.serial.*;

ControllIO ctrllIO;
ControllDevice ctrllDevice;

ControllSlider rightHorizontal;
ControllSlider rightVertical;
ControllSlider leftVertical;
ControllCoolieHat coolieHat;

SerialThread serialThread;

PID yawPID;
PID pitchPID;
PID rollPID;
PID depthPID;

int YAW = 1;
int PITCH = 2;
int ROLL = 3;
int DEPTH = 4;

float X, Y, Z;
float x_prime, y_prime;
float L_x, R_x;
float L_theta, R_theta;
float L, R, Back;

void setup() {

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

  coolieHat = ctrllDevice.getCoolieHat(gamepad.cooliehat());

  // Initialize serial communications. 
  serialThread = new SerialThread(this);
  
  //Initialize PID controls
  yawPID = new PID(YAW, 1,0,0,0);
  pitchPID = new PID(PITCH, 1,0,0,0);
  rollPID =new PID(ROLL,1,0,0,0);
  depthPID = new PID(DEPTH,1,0,0,0);
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

