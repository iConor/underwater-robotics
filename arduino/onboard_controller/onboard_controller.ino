#include "Servo.h"
#include "Wire.h"
#include "I2Cdev.h"
#include "MPU6050_9Axis_MotionApps41.h"
#include "SSC.h"

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

MPU6050 mpu9150;

bool dmpReady = false;
uint16_t fifoCount;
uint8_t mpuIntStatus;
uint8_t fifoBuffer[64];

Quaternion quaternion;
VectorFloat gravity;
float yawPitchRoll[3];

const uint8_t DEPTH_ADDRESS = 0x28;
const uint8_t DEPTH_POWERPIN = 8;

SSC depth( DEPTH_ADDRESS, DEPTH_POWERPIN );

float depth_pressure = 0.0;
float depth_temperature = 0.0;

// else

byte sensors[8] = {0,0,0,0,0,0,0,0};

void setup() {
  
  Wire.begin();
  
  setupIMU();
  //setupDepth();

  // Initialize serial port.
  Serial.begin( BAUD_RATE );

  // Initialize motor port.
  Serial1.begin( BAUD_RATE );

  // Initialize thruster servos.
  port_thruster_servo.attach( PORT_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX );
  starboard_thruster_servo.attach( STARBOARD_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX);
}

void loop() {

  // Send ready status to control station.
  Serial.write( CHECK_BYTE );

  // Wait for incoming data packet.
  while( Serial.available() < 5 ){
  }
  
  // Read sensors.
  loopIMU();
  //loopDepth();
  
  // Convert sensor data to bytes for rxtx.
  sensors[0]=int(100*(yawPitchRoll[0]+180)) & 0xFF;
  sensors[1]=(int(100*(yawPitchRoll[0]+180))>>8) & 0xFF;
  sensors[2]=int(100*(yawPitchRoll[1]+180)) & 0xFF;
  sensors[3]=(int(100*(yawPitchRoll[1]+180))>>8) & 0xFF;
  sensors[4]=int(100*(yawPitchRoll[2]+180)) & 0xFF;
  sensors[5]=(int(100*(yawPitchRoll[2]+180))>>8) & 0xFF;
  sensors[6]=int(100*depth_pressure) & 0xFF;
  sensors[7]=(int(100*depth_pressure)>>8) & 0xFF;
  
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
