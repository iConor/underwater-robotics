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
    serial.bufferUntil('#');
    running = false;
    super.start();
  }

  // The 'content' of the thread.
  void run() {
    while ( running ) {
    }
  }

  void event() {
    int check = serial.read();

    // Send current status.
    if ( check == 243 ) {
      serial.read();
      serial.write(port_thruster_servo_angle);
      serial.write(starboard_thruster_servo_angle);
      serial.write(port_thruster_motor_power);
      serial.write(starboard_thruster_motor_power);
      serial.write(aft_thruster_motor_power);
    }

    if (check == 244) {
      // Print debugging info.
      println( " " + serial.read() + " " + serial.read() + "   " + serial.read() + " " + serial.read() + "   " + serial.read() );
      serial.read();
    }
  }

  // Stop the thread.
  void quit() {
    running = false;
    serial.stop();
  }
}

void serialEvent(Serial serial) {
  serialThread.event();
}

