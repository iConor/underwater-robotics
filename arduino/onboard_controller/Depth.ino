void setupDepth() {
  
  // Configure the sensor.
  depth.setMinRaw(0);
  depth.setMaxRaw(16383);
  depth.setMinPressure(0.0);
  depth.setMaxPressure(30);
  
  // Start the sensor.
  depth.start();
}

void loopDepth() {
  
  // Also returns error.
  depth.update();
  
  // Get sensor data.
  depth_pressure = depth.pressure();
  depth_temperature = depth.temperature();
}
