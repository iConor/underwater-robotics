#include <Servo.h>
#include <SoftwareSerial.h>

#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps20.h"

#include <Wire.h>
#include <SSC.h>

//************************************************************
MPU6050 mpu;

//uncomment one of these
#define OUTPUT_READABLE_YAWPITCHROLL
//#define OUTPUT_READABLE_REALACCEL
//#define OUTPUT_READABLE_WORLDACCEL

#define LED_PIN 13 // (Arduino is 13, Teensy is 11, Teensy++ is 6)
bool blinkState = false;

// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount;     // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

// orientation/motion vars
Quaternion q;           // [w, x, y, z]         quaternion container
VectorInt16 aa;         // [x, y, z]            accel sensor measurements
VectorInt16 aaReal;     // [x, y, z]            gravity-free accel sensor measurements
VectorInt16 aaWorld;    // [x, y, z]            world-frame accel sensor measurements
VectorFloat gravity;    // [x, y, z]            gravity vector
float euler[3];         // [psi, theta, phi]    Euler angle container
float ypr[3];           // [yaw, pitch, roll]   yaw/pitch/roll container and gravity vector

// packet structure for InvenSense teapot demo
uint8_t teapotPacket[14] = { '$', 0x02, 0,0, 0,0, 0,0, 0,0, 0x00, 0x00, '\r', '\n' };
//************************************************************************

SSC ssc(0x28, 8);

byte sensors[8]={0,0,0,0,0,0,0,0};


const byte CHECK_BYTE = 243;
const int BAUD_RATE = 9600;

const int PORT_THRUSTER_SERVO_PIN = 10;
const int STARBOARD_THRUSTER_SERVO_PIN = 11;

const int SERVO_MIN = 400;
const int SERVO_MAX = 2200;

const int THRUSTER_ADDRESS = 128;
const int PORT_THRUSTER = 2;
const int STARBOARD_THRUSTER = 1;

int port_thruster_servo_value;
int starboard_thruster_servo_value;
int port_thruster_motor_value;
int starboard_thruster_motor_value;
int aft_thruster_motor_value;

Servo port_thruster_servo;
Servo starboard_thruster_servo;

void setup() {
  Wire.begin();
  
  setupIMU();
  setupPressure();

  // Initialize serial port.
  Serial.begin( BAUD_RATE );

  // Initialize motor port.
  Serial1.begin( BAUD_RATE );

  // Initialize thruster servos.
  port_thruster_servo.attach( PORT_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX );
  starboard_thruster_servo.attach( STARBOARD_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX);
}

void loop() {
  
  //IMU_readAndWrite();

  // Send ready status to control station.
  Serial.write( CHECK_BYTE );

  // Wait for incoming data packet.
  while( Serial.available() < 5 ){
  }
  getSensors();
  // Read incoming data packet.
  port_thruster_motor_value = Serial.read();
  port_thruster_servo_value = Serial.read();
  starboard_thruster_motor_value = Serial.read();
  starboard_thruster_servo_value = Serial.read();
  aft_thruster_motor_value = Serial.read();

  // Send thruster motor values back for debugging.
  Serial.write( port_thruster_motor_value );
  Serial.write( starboard_thruster_motor_value );
  Serial.write(35);
  Serial.write(sensors,8);

  // Set thruster motor speeds.
  motorControl( THRUSTER_ADDRESS, PORT_THRUSTER, port_thruster_motor_value );
  motorControl( THRUSTER_ADDRESS, STARBOARD_THRUSTER, starboard_thruster_motor_value );

  // Set servo positions according to the scaled values.
  port_thruster_servo.write( port_thruster_servo_value ); 
  starboard_thruster_servo.write( starboard_thruster_servo_value );

  // Allow time for each servo operation to complete.
  delay( 15 );                           
}

void motorControl( int address_, int motor_, int power ) {
  byte thing1_;
  int speed_;
  byte thing2_;
  if( motor_ == 1 ) {
    if( power >= 128 ) {
      thing1_ = ( byte ) 0;
      speed_ = power - 127;
      thing2_ = ( speed_ + address_ ) & 127;
    } 
    else {
      thing1_ = 1;
      speed_ = 127 - power;
      thing2_ = ( speed_ + address_ + 1 ) & 127;
    }
  }
  else { // motor_ == 2
    if( power >= 128 ) {
      thing1_ = 4;
      speed_ = power - 127;
      thing2_ = ( speed_ + address_ + 4 ) & 127;
    }
    else {
      thing1_ = 5;
      speed_ = 127 - power;
      thing2_ = ( speed_ + address_ + 5 ) & 127;
    }
  }
  Serial1.write( address_ );
  Serial1.write( thing1_ );
  Serial1.write( speed_ );
  Serial1.write( thing2_ );
}
