#include <Servo.h>
#include <SoftwareSerial.h>

const byte CHECK_BYTE = 243;
const int BAUD_RATE = 9600;

const int PORT_THRUSTER_MOTOR_PIN = 5;
const int STARBOARD_THRUSTER_MOTOR_PIN = 6;
//const int AFT_THRUSTER_MOTOR_PIN = 7;
const int PORT_THRUSTER_SERVO_PIN = 9;
const int STARBOARD_THRUSTER_SERVO_PIN = 10;

const int SERVO_MIN = 400;
const int SERVO_MAX = 2200;

int port_thruster_motor_value;
int starboard_thruster_motor_value;
int aft_thruster_motor_value;
int port_thruster_servo_value;
int starboard_thruster_servo_value;

Servo port_thruster_servo;
Servo starboard_thruster_servo;

SoftwareSerial motorSerial(10,11);

void setup() {

  // Initialize serial port.
  Serial.begin( BAUD_RATE );

  // Initialize motor port.
  motorSerial.begin( BAUD_RATE );

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

  // Read incoming data packet.
  port_thruster_motor_value = Serial.read();
  port_thruster_servo_value = Serial.read();
  starboard_thruster_motor_value = Serial.read();
  starboard_thruster_servo_value = Serial.read();
  aft_thruster_motor_value = Serial.read();

  // Send thruster motor values back for debugging.
  Serial.write( port_thruster_motor_value );
  Serial.write( starboard_thruster_motor_value );

  // Set thruster motor speeds.
  motorControl( 128, 1, port_thruster_motor_value );
  motorControl( 128, 2, starboard_thruster_motor_value );

  // Set servo positions according to the scaled values.
  port_thruster_servo.write( port_thruster_servo_value ); 
  starboard_thruster_servo.write( starboard_thruster_servo_value );

  // Allow time for each servo operation to complete.
  delay( 15 );                           
}

void motorControl( int address_, int motor_, int power ) {
  int speed_;
  motorSerial.write( address_ );
  if( motor_ == 1 ) {
    if( power >= 128 ) {
      speed_ = power - 127;
      motorSerial.write( ( byte ) 0 );
      motorSerial.write( speed_ );
      motorSerial.write( ( speed_ + address_ ) & 127 );
    } 
    else {
      speed_ = 127 - power;
      motorSerial.write( 1 );
      motorSerial.write( speed_ );
      motorSerial.write( ( speed_ + address_ + 1 ) & 127 );
    }
  }
  else { // motor_ == 2
    if( power >= 128 ) {
      speed_ = power - 127;
      motorSerial.write( 4 );
      motorSerial.write( speed_ );
      motorSerial.write( ( speed_ + address_ + 4 ) & 127) ;
    }
    else {
      speed_ = 127 - power;
      motorSerial.write( 5 );
      motorSerial.write( speed_ );
      motorSerial.write( ( speed_ + address_ + 5 ) & 127 );
    }
  }
}
