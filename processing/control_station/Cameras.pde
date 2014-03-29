void update_camera() {
  desired.camera_pan_servo_angle( camera_angle( desired.camera_pan_servo_angle(), int(coolieHat.getX() ) ) );
  desired.camera_tilt_servo_angle( camera_angle( desired.camera_tilt_servo_angle(), int(coolieHat.getY() ) ) );
}

int camera_angle( int old_angle, int delta ) {
  int new_angle = old_angle - delta;
  if( new_angle > 180 || new_angle < 0 ){
    new_angle = old_angle;
  }
  return new_angle;
}
