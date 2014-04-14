
//------------------------------------------------------------   setupIMU()   --------------------//

void setupIMU() {

  Wire.begin();

  // Initialize IMU.
  mpu9150.initialize();

  // Initialize DMP.
  if (mpu9150.dmpInitialize() == 0) {

    //    // Calibrate offsets.
    //    mpu9150.setXGyroOffset(220);
    //    mpu9150.setYGyroOffset(76);
    //    mpu9150.setZGyroOffset(-85);
    //    mpu9150.setZAccelOffset(1788);

    // Enable the DMP.
    mpu9150.setDMPEnabled( true );

    // Get full set of interrupt status bits (clears register).
    mpuIntStatus = mpu9150.getIntStatus();

    // Let the loop know initialization was a success.
    dmpReady = true;

  } 
}

//------------------------------------------------------------   loopIMU()   --------------------//

void loopIMU() {

  // If initialization failed, don't do anything.
  if( !dmpReady ) return;

  // Get full set of interrupt status bits (clears register).
  mpuIntStatus = mpu9150.getIntStatus();

  // Check for FIFO overflow.
  if (( mpuIntStatus & 0x10) || mpu9150.getFIFOCount() == 1024 ) {

    // Reset the FIFO.
    mpu9150.resetFIFO();

  }// No overflow - process data.
  else if( mpuIntStatus & 0x02 ) {

    // Wait for DMP packet.
    while( !mpu9150.dmpPacketAvailable() );

    // Read DMP packet from FIFO buffer.
    mpu9150.getFIFOBytes(fifoBuffer, mpu9150.dmpGetFIFOPacketSize());

    // Raw buffer to quaternions.
    mpu9150.dmpGetQuaternion(&quaternion, fifoBuffer);

    // Quaternions to gravity.
    mpu9150.dmpGetGravity(&gravity, &quaternion);

    // Quaternions and gravity to yawPitchRoll.
    mpu9150.dmpGetYawPitchRoll(yawPitchRoll, &quaternion, &gravity);

    // Convert radians to degrees.
    for(int i = 0; i < 3; i++ ) {
      yawPitchRoll[i] *= 180/M_PI;
    }

  }
}
