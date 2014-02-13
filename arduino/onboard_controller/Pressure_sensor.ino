//put this in start of file

//#include <wire.h>
//#include <SSC.h>

//SSC ssc(0x28, 8);

void setupPressure()
{
  ssc.setMinRaw(0);
  ssc.setMaxRaw(16383);
  ssc.setMinPressure(0.0);
  ssc.setMaxPressure(1.6);
  
  ssc.start();
}

float getPressure()
{
  ssc.update();
  return ssc.pressure();
}
float getTemp()
{
  ssc.update();
  return ssc.temperature();
}
