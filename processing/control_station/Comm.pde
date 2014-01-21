class Comm extends Thread {

  private final int BAUD_RATE = 9600;
  private boolean running = false;
  Serial robot;

  // Move these:
  byte Z_motor, left_motor, right_motor;
  byte left_servo, right_servo, claw_servo;
  int cam_servo_x, cam_servo_y;
  int check;
  int time; //unused?
  //byte[] inBuffer = new byte[ NUMBER_BYTES ];
  //int[] sensors = new int[ NUMBER_OF_SENSORS ];

  // Constructor
  Comm( PApplet main_function ) {
    robot = new Serial( main_function, Serial.list()[0], BAUD_RATE ); 
    this.start();
  }

  // Begin the thread.
  void start() {
    running = true;
    super.start();
  }

  // This gets triggered by start().
  void run() {
    while ( running ) {
      //send a byte to tell the arduion to start the communication

      time = millis(); //unused?

      // Wait for serial activity.
      while ( robot.available () < 1 ) {
        /*if (( millis() - time ) > 1500 ){
         //clear the buffer
         while ( robot.available() > 0 ){
         robot.read();
         }
         while ( robot.available() < 1 ) {}
         }*/
      }

      // Test check byte.
      check = robot.read();
      // Send current status (model?).
      if ( check == 243 ) {
        robot.write(left_motor);
        robot.write(left_servo);
        robot.write(right_motor);
        robot.write(right_servo);
        robot.write(Z_motor);
      }
      // Wait for serial activity.
      while ( robot.available () < 2 ) {
      }
      // Print debugging info.
      println( robot.read() + "    " + robot.read() );
      // Reset check.
      check = 0;
    }
  }

  /*void quit() {
   running = false;
   }
   
   //makes sensor data avalible to the main program
   int sensor_data( int sensor_number ){
   return sensors[ sensor_number ];
   }*/

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
}

