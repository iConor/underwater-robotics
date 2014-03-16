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
        serial.write(left_motor);
        serial.write(left_servo);
        serial.write(right_motor);
        serial.write(right_servo);
        serial.write(Z_motor);
        serial.write(camera_pan_servo_angle);
        serial.write(camera_tilt_servo_angle);
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

  // Stop the thread.
  void quit() {
    running = false;
    serial.stop();
  }
}

