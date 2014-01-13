#include <Servo.h>

int PORT_THRUSTER_SERVO_PIN = 9;
int STARBOARD_THRUSTER_SERVO_PIN = 10;
int PORT_THRUSTER_MOTOR_PIN = 5;
int STARBOARD_THRUSTER_MOTOR_PIN = 6;

int port_thruster_motor_value;
int starboard_thruster_motor_value;
int port_thruster_servo_value;
int starboard_thruster_servo_value;
int aft_thruster_motor_value;

Servo port_thruster_servo;
Servo starboard_thruster_servo;

const byte CHECK_BYTE = 243;
const int BAUD_RATE = 9600;

void setup() {
  
  // Initialize serial port.
  Serial.begin( BAUD_RATE );
  
  // Initialize thruster servos.
  port_thruster_servo.attach( PORT_THRUSTER_SERVO_PIN, 400, 2200 );
  starboard_thruster_servo.attach( STARBOARD_THRUSTER_SERVO_PIN, 400, 2200);
}

void loop(){

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
  analogWrite( PORT_THRUSTER_MOTOR_PIN, port_thruster_motor_value );
  analogWrite( STARBOARD_THRUSTER_MOTOR_PIN, starboard_thruster_motor_value );

  // Set servo positions according to the scaled values.
  port_thruster_servo.write( port_thruster_servo_value ); 
  starboard_thruster_servo.write( starboard_thruster_servo_value );
  
  // Allow time for each servo operation to complete.
  delay( 15 );                           
}




