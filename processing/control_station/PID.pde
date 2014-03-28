class PID {

  float P, I=0, D=0, previous_P=0;
  float P_gain, I_gain, D_gain;
  float current;
  float desired;
  float buffer;
  public float correction_factor;
  int sensor;

  PID (int Sensor, float buffer, float Pgain, float Igain, float Dgain) {
    P_gain = Pgain;
    I_gain = Igain;
    D_gain = Dgain;
    sensor = Sensor;
  }

  void control(float Desired) {
    //set current to sensor data
       current=serialThread.sensors(sensor);
       desired=Desired;
    //find position error
    P = current - desired;
    if ( abs( P ) <= buffer ) {
      P = 0;
    }

    //Intigral
    I += ( P / 60 );

    //reset intigral if it passes through buffer zone
    if ( I > 0 ) {
      if ( P < 0 ) {
        I = 0;
      }
    }
    else {
      if ( P > 0 ) {
        I = 0;
      }
    }

    //Derivative
    D = (P - previous_P)/60;
    previous_P = P;
    
    //add components together
    correction_factor = P*P_gain+I*I_gain+D*D_gain;
    
    //return correction_factor;
  }
}

