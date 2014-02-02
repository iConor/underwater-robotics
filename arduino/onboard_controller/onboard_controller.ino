#include <Servo.h>

int PORT_THRUSTER_SERVO_PIN = 9;
int STARBOARD_THRUSTER_SERVO_PIN = 10;
int PORT_THRUSTER_MOTOR_PIN = 5;
int STARBOARD_THRUSTER_MOTOR_PIN = 6;
//int AFT_THRUSTER_MOTOR_PIN = 7;

int SERVO_MIN = 400;
int SERVO_MAX = 2200;

int port_thruster_servo_angle;
int starboard_thruster_servo_angle;
int port_thruster_motor_power;
int starboard_thruster_motor_power;
int aft_thruster_motor_power;

Servo port_thruster_servo;
Servo starboard_thruster_servo;

const byte CHECK_BYTE = 243;
const int BAUD_RATE = 9600;

void setup() {
  
  // Initialize serial port.
  Serial.begin( BAUD_RATE );
  
  // Initialize thruster servos.
  port_thruster_servo.attach( PORT_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX );
  starboard_thruster_servo.attach( STARBOARD_THRUSTER_SERVO_PIN, SERVO_MIN, SERVO_MAX );
}

void loop(){

  // Send ready status to control station.
  Serial.write( CHECK_BYTE );

  // Wait for incoming data packet.
  while( Serial.available() < 5 ){
  }

  // Read incoming data packet.
  port_thruster_servo_angle = Serial.read();
  starboard_thruster_servo_angle = Serial.read();
  port_thruster_motor_power = Serial.read();
  starboard_thruster_motor_power = Serial.read();
  aft_thruster_motor_power = Serial.read();

  // Send thruster values back for debugging.
  Serial.write( port_thruster_servo_angle );
  Serial.write( starboard_thruster_servo_angle );
  Serial.write( port_thruster_motor_power );
  Serial.write( starboard_thruster_motor_power );
  Serial.write( aft_thruster_motor_power );

  // Set thruster motor power.
  analogWrite( PORT_THRUSTER_MOTOR_PIN, port_thruster_motor_power );
  analogWrite( STARBOARD_THRUSTER_MOTOR_PIN, starboard_thruster_motor_power );

  // Set thruster servo angles.
  port_thruster_servo.write( port_thruster_servo_angle ); 
  starboard_thruster_servo.write( starboard_thruster_servo_angle );
  
  // Allow time for each servo operation to complete.
  delay( 15 );                           
}
