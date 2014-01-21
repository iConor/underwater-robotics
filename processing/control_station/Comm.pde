class SerialThread extends Thread {

  boolean running = false;
  byte Z_motor, left_motor, right_motor;
  byte left_servo, right_servo, claw_servo;
  int cam_servo_x, cam_servo_y;
  int check;
  int time; //unused?
  //byte[] inBuffer = new byte[ NUMBER_BYTES ];
  //int[] sensors = new int[ NUMBER_OF_SENSORS ];

  // Constructor.
  SerialThread( int Baud_Rate ) {
    /*//make a serial class serial
     Serial serial;
     //list the available serial ports
     println( Serial.list() );
     //open robot port
     serial = new Serial( this, Serial.list()[1], Baud_Rate );*/
  }

  // Begin the thread.
  void start() {
    running = true;
    super.start();
  }

  // This get triggered by start().
  void run() {
    while ( running ) {
      //send a byte to tell the arduion to start the communication

      time = millis(); //unused?
      
      // Wait for serial activity.
      while ( serial.available () < 1 ) {
        /*if (( millis() - time ) > 1500 ){
         //clear the buffer
         while ( serial.available() > 0 ){
         serial.read();
         }
         while ( serial.available() < 1 ) {}
         }*/
      }
      
      // Test check byte.
      check = serial.read();
      // Send current status (model?).
      if ( check == 243 ) {
        serial.write(left_motor);
        serial.write(left_servo);
        serial.write(right_motor);
        serial.write(right_servo);
        serial.write(Z_motor);
      }
      // Wait for serial activity.
      while ( serial.available () < 2 ) {
      }
      // Print debugging info.
      println( serial.read() + "    " + serial.read() );
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

