class SerialThread extends Thread {

  private final int BAUD_RATE = 9600;
  private boolean running = false;
  public Serial serial;

  // Constructor
  SerialThread( PApplet main_function ) {
    serial = new Serial( main_function, Serial.list()[0], BAUD_RATE );
    serial.bufferUntil('#');
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
    }
  }

  void event() {
    int check = serial.read();
    if ( check == 243 ) {
      serial.read();
      serial.write(left_motor);
      serial.write(left_servo);
      serial.write(right_motor);
      serial.write(right_servo);
      serial.write(Z_motor);
    }
    if (check == 244) {
      // Print debugging info.
      println( serial.read() + "    " + serial.read() );
      serial.read();
    }
    // Reset check.
    check = 0;
  }

  void quit() {
    running = false;
    serial.stop();
  }
}

void serialEvent(Serial serial) {
  serialThread.event();
}

