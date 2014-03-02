//include in main 

//byte sensors[8]={0,0,0,0,0,0,0,0}

void getSensors()
{
  float pressure=0.0, temp=0.0;
  
  //get imu data
  getYawPitchRoll();
  
  //get pressure
  pressure=getPressure();
  
  //convert sensor values to bytes
  sensors[0]=int(100*(ypr[0]+180)) & 0xFF;
  sensors[1]=(int(100*(ypr[0]+180))>>8) & 0xFF;
  sensors[2]=int(100*(ypr[1]+180)) & 0xFF;
  sensors[3]=(int(100*(ypr[1]+180))>>8) & 0xFF;
  sensors[4]=int(100*(ypr[2]+180)) & 0xFF;
  sensors[5]=(int(100*(ypr[2]+180))>>8) & 0xFF;
  sensors[6]=int(100*pressure) & 0xFF;
  sensors[7]=(int(100*pressure)>>8) & 0xFF;
  
  
}
