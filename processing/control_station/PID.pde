class PID {

  float P, I=0, D=0, previous_P=0;
  float P_gain, I_gain, D_gain;
  float current;
  float desired;
  float buffer;
  int sensor;

  PID (int Sensor, float buffer, float Pgain, float Igain, float Dgain) {
    P_gain = Pgain;
    I_gain = Igain;
    D_gain = Dgain;
    //sensor = Sensor;
  }

  void control() {
    //set current to sensor data
    // current=Com1.sensor_data(Sensor);
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
    D = P - previous_P;
    previous_P = P;
  }
}

