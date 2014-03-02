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
  private int low=0, high=0, data=0;
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
        serial.write(left_motor);
        serial.write(left_servo);
        serial.write(right_motor);
        serial.write(right_servo);
        serial.write(Z_motor);
      }
      // Wait for serial activity.
      while ( serial.available () < 11 ) {
      }
      // Print debugging info.
      println( serial.read() + "    " + serial.read() );
      //read the sensor data in from the robot controller
      if (serial.read()==35) {
        //yaw
          low = serial.read();
          high = serial.read();
          data=256*high+low;
          sensors[0]=float(data)/100.0-180;
        //pitch
          low = serial.read();
          high = serial.read();
          data=256*high+low;
          sensors[1]=float(data)/100.0-180;    
        //roll      
          low = serial.read();
          high = serial.read();
          data=256*high+low;
          sensors[2]=float(data)/100.0-180;          
        //pressure
          low = serial.read();
          high = serial.read();
          data=256*high+low;
          sensors[3]=float(data)/100.0-180;
          
          println(sensors[0]/PI*180+" , "+sensors[2]/PI*180);
          
      }
      else {
        //clear the buffer or something
        serial.clear();
      }
          
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

