void vector_control() {

  float Cg_ratio=.6422;
  float L_z, R_z;

  // Find front z power.
  R_z = Z / ( 2 + 2 * Cg_ratio );
  L_z = R_z; //possibly put roll control here

  // Find back power.
  Back = Z * ( 1 - 1 / ( 1 + Cg_ratio ) );

  // Put the motor thrust curve equation here.
  Back = Back;

  if ( R_x == 0 ) {
    R_theta = PI / 2;
  }
  else {
    R_theta = atan( R_z / R_x );
  }
  if ( L_x == 0 ) {
    L_theta = PI / 2;
  }
  else {
    L_theta = atan( L_z / L_x );
  }
  if ( L_theta < 0 ) {
    L_theta=L_theta+PI;
  }
  if ( R_theta < 0 ) {
    R_theta = R_theta + PI;
  }

  L_theta = degrees( L_theta );
  R_theta = degrees( R_theta );

  R = sqrt( R_x * R_x + R_z * R_z );
  L = sqrt( L_x * L_x + L_z * L_z );

  // Put in motor direction.
  if ( R_z < 0 ) {
    R = -R;
  }
  else if ( R_z == 0 ) {
    if ( R_x < 0 ) {
      R = -R;
    }
    if ( L_x < 0 ) {
      L = -L;
    }
  }
}

// Move these:
byte Z_motor, left_motor, right_motor;
byte left_servo, right_servo, claw_servo;
int cam_servo_x, cam_servo_y;
int check;
int time; //unused?
//byte[] inBuffer = new byte[ NUMBER_BYTES ];
//int[] sensors = new int[ NUMBER_OF_SENSORS ];

// Provides motor power inputs.
void Zmotor( float power ) {
  Z_motor=byte( int( map( power, -1, 1, 22, 240 ) ) );
}
void leftmotor( float power, float angle ) {
  if ( power > 0 ) {
    left_motor = byte( power * 120 + 128 );
  } 
  else {
    left_motor = byte( power * 120 - 128 );
  }
  left_servo = byte( angle );//int(map(angle,0,180,0,255));
}
void rightmotor( float power, float angle ) {
  if ( power > 0 ) {
    right_motor = byte( power * 120 + 128 );
  }
  else {
    right_motor = byte( power * 120 - 128 );
  }
  right_servo = byte( angle );//int(map(angle,0 180,0,255));
}

/* void claw( float something ){
 //do stuff
 }*/
