/************************************************************************
 *                                                                      *
 *   Classes:                                                           *
 *   SerialThread - Serial communications are handled by this thread.   *
 *                                                                      *
 ************************************************************************/

class SerialThread extends Thread {

  private final int BAUD_RATE = 9600;
  private boolean running = false;
  private PApplet main_function;
  private Serial serial;
  private int check = 0;
  private int low = 0;
  private int high = 0;
  private int data = 0;
  public float[] sensors = new float[4];

  // Constructor.
  SerialThread( PApplet parent ) {
    main_function = parent;
    this.start();
  }

  // Begin the thread.
  void start() {
    AutoSerial autoSerial = new AutoSerial();
    serial = new Serial( main_function, autoSerial.name(), BAUD_RATE );
    running = true;
    super.start();
  }

  // The 'content' of the thread.
  void run() {
    while ( running ) {
      // Wait for serial activity.
      while ( serial.available () < 1 ) {
      }
      // Test check byte.
      check = serial.read();
      // Send current status.
      if ( check == 243 ) {
        serial.write( desired.port_thruster_motor_power() );
        serial.write( desired.port_thruster_servo_angle() );
        serial.write( desired.starboard_thruster_motor_power() );
        serial.write( desired.starboard_thruster_servo_angle() );
        serial.write( desired.aft_thruster_motor_power() );
        serial.write( desired.camera_pan_servo_angle() );
        serial.write( desired.camera_tilt_servo_angle() );
      }
      // Wait for serial activity.
      while ( serial.available () < 16 ) {
      }
      // Print debugging info.
      for( int j = 0; j < 7; j++ ) {
        print( serial.read() + "    " );
      }
      println();
      // Reset check.
      check = 0;
      // Read sensor data.
      if ( serial.read() == 35 ) {
        for ( int i = 0; i < 4; i++ ) {
          low = serial.read();
          high = serial.read();
          data = 256 * high + low;
          sensors[i] = float( data ) / 100.0 - 180;
        }
        
        reported.yaw( sensors[0] );
        reported.pitch( sensors[1] );
        reported.roll( sensors[2] );
        reported.depth_pressure( sensors[3] );
        
        // Print sensor data.
        println( "                                             " + reported.yaw() + "    " + reported.pitch() + "    " + reported.roll() );
      }
      else {
        // Clear the buffer.
        serial.clear();
      }
    }
  }

  // Stop the thread.
  void quit() {
    running = false;
    serial.stop();
  }
}

