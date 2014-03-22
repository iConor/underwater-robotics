#include <Servo.h>

const byte CHECK_BYTE = 243;
const int BAUD_RATE = 9600;

const int PORT_THRUSTER_SERVO_PIN = 10;
const int STARBOARD_THRUSTER_SERVO_PIN = 11;
const int CAMERA_PAN_SERVO_VALUE = 5;
const int CAMERA_TILT_SERVO_VALUE = 6;

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
int camera_pan_servo_angle;
int camera_tilt_servo_angle;

Servo port_thruster_servo;
Servo starboard_thruster_servo;
Servo camera_pan_servo;
Servo camera_tilt_servo;

void setup() {

  // Initialize control station port.
  Serial.begin( BAUD_RATE );

  // Initialize motor speed port.
  Serial1.begin( BAUD_RATE );

  // Initialize thruster servos.
  port_thruster_servo.attach( PORT_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX );
  starboard_thruster_servo.attach( STARBOARD_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX);
  
  // Initialize camera servos.
  camera_pan_servo.attach(CAMERA_PAN_SERVO_VALUE, SERVO_MIN, SERVO_MAX );
  camera_tilt_servo.attach(CAMERA_TILT_SERVO_VALUE, SERVO_MIN, SERVO_MAX );
}

void loop() {

  // Send ready status to control station.
  Serial.write( CHECK_BYTE );

  // Wait for incoming data packet.
  while( Serial.available() < 7 ){
  }

  // Read incoming data packet.
  port_thruster_motor_value = Serial.read();
  port_thruster_servo_value = Serial.read();
  starboard_thruster_motor_value = Serial.read();
  starboard_thruster_servo_value = Serial.read();
  aft_thruster_motor_value = Serial.read();
  camera_pan_servo_angle = Serial.read();
  camera_tilt_servo_angle = Serial.read();
  
  // Invert one thruster angle.
  port_thruster_servo_value = 180 - port_thruster_servo_value;
  
  // Send values back for debugging.
  Serial.write( port_thruster_servo_value );
  Serial.write( starboard_thruster_servo_value );

  // Set thruster motor speeds.
  motorControl( THRUSTER_ADDRESS, PORT_THRUSTER, port_thruster_motor_value );
  motorControl( THRUSTER_ADDRESS, STARBOARD_THRUSTER, starboard_thruster_motor_value );

  // Set thruster servo positions.
  port_thruster_servo.write( port_thruster_servo_value ); 
  starboard_thruster_servo.write( starboard_thruster_servo_value );
  
  // Set camera servo positions.
  camera_pan_servo.write( camera_pan_servo_angle );
  camera_tilt_servo.write( camera_tilt_servo_angle );

  // Allow time for servo operations to complete.
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
