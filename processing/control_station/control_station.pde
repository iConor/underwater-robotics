import procontroll.*;
import net.java.games.input.*;

import processing.serial.*;

ControllIO ctrllIO;
ControllDevice ctrllDevice;

ControllSlider rightHorizontal;
ControllSlider rightVertical;
ControllSlider leftVertical;

SerialThread serialThread;

float X, Y, Z;
float x_prime, y_prime;
float L_x, R_x;
float L_theta, R_theta;
float L, R, Back;
<<<<<<< HEAD
=======
// float a = 0.3; //constant?
>>>>>>> Integrated GUI_2 into main code.

void setup() {
  
  setupGUI_2();

<<<<<<< HEAD
=======
  // Initialize serial communications.
  Robot = new Serial( this, Serial.list()[4], 9600 );  
  comm = new Comm( 9600 );
  comm.start();

>>>>>>> Integrated GUI_2 into main code.
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

  // Initialize serial communications. 
  serialThread = new SerialThread(this);
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
<<<<<<< HEAD
  rightmotor(R, R_theta);
  leftmotor(L, L_theta);
  Zmotor(Back);
=======
  comm.rightmotor(R, R_theta);
  comm.leftmotor(L, L_theta);
  comm.Zmotor(Back);
  
  drawGUI_2();
>>>>>>> Integrated GUI_2 into main code.
}

