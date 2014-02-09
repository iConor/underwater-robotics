void setup() {
  Serial.begin( 9600 );
  IMU_setup();
}

void loop() {
  IMU_readAndWrite();
  delay(500);
}
