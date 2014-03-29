public class Gamepad {

  PApplet parent;

  ControllIO ctrllIO;
  ControllDevice ctrllDevice;

  ControllSlider rightHorizontal;
  ControllSlider rightVertical;
  ControllSlider leftVertical;
  ControllCoolieHat coolieHat;

  Gamepad(PApplet caller) {

    parent = caller; 

    // Initialize human-machine interface.
    ctrllIO = ControllIO.getInstance(parent);
    GamepadMap gamepad_map = new GamepadMap(ctrllIO);
    ctrllDevice = ctrllIO.getDevice(gamepad_map.getName());
    // Initialize buttons and/or sliders.
    rightVertical = ctrllDevice.getSlider(gamepad_map.getRightStickVertical());
    rightVertical.setTolerance(.16);
    rightHorizontal = ctrllDevice.getSlider(gamepad_map.getRightStickHorizontal());
    rightHorizontal.setTolerance(.16);
    leftVertical = ctrllDevice.getSlider(gamepad_map.getLeftStickVertical());
    leftVertical.setTolerance(.16);

    coolieHat = ctrllDevice.getCoolieHat(gamepad_map.getCoolieHat());
  }

  public void update() {

    if ( coolieHat.pressed() ) {
      update_camera();
    }

    // Read gamepad values.
    X = rightVertical.getValue();
    Y = rightHorizontal.getValue();
    Z = leftVertical.getValue();
    
  }
}

