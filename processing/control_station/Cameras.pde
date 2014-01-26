//Pan/Tilt Camera Gibberish

void pan_tilt_camera(int x_change, int y_change) {

  int x_max = 255;
  int x_min = -255;
  int y_max = 255;
  int y_min = -255;

  //X Value
  if (x_change > 0) {
    if (camera_x < x_max) {
      camera_x = camera_x + 5;
    }
  } 
  else if (x_change < 0) {
    if (camera_x > x_min) {
      camera_x = camera_x - 5;
    }
  }

  //Y Value
  if (y_change > 0) {
    if (camera_y < y_max) {
      camera_y = camera_x + 5;
    }
  } 
  else if (y_change < 0) {
    if (camera_y > y_min) {
      camera_y = camera_y - 5;
    }
  }
}

