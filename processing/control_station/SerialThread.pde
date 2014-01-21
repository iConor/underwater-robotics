class SerialThread extends Thread {

  private final int BAUD_RATE = 9600;
  private boolean running = false;
  private Serial serial;

  // Constructor
  SerialThread( PApplet main_function ) {
    serial = new Serial( main_function, Serial.list()[0], BAUD_RATE ); 
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

      // Wait for serial activity.
      while ( serial.available () < 1 ) {
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

  void quit() {
    running = false;
  }
}

