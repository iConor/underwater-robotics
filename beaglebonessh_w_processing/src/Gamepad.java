import procontroll.*;

public class Gamepad {

  // Gamepad Connection
  ControllIO controllIO;

  //-------------------- Gamepad Names --------------------//

  // Known Gamepad Configurations
  public final String PS3 = "PLAYSTATION(R)3 Controller";
  public final String WIN360 = "Controller (Xbox 360 Wireless Receiver for Windows)";
  public final String MAC360 = "Wireless 360 Controller";
  public final String AIRFLO = "AIRFLO             ";
  public final String KEY = "Keyboard";

  // List of Known Configurations
  private final String[] KNOWN_GAMEPADS = {
    PS3, WIN360, MAC360, AIRFLO, KEY
  };

  // Gamepad Name
  private String _name = "";
  private int _number = -1;

  //-------------------- Buttons/Sliders --------------------//

  // Joystick Axes(?)
  private int _leftStickHorizontal = -1;
  private int _rightStickHorizontal = -1;
  private int _leftStickVertical = -1;
  private int _rightStickVertical = -1;

  // Clickable Joysticks
  private int _leftStick = -1;
  private int _rightStick = -1;

  //  D-pad or Coolie Hat
  private int _dPadUp = -1;
  private int _dPadDown = -1;
  private int _dPadLeft = -1;
  private int _dPadRight = -1;
  // OR
  private int _cooliehat = -1;

  // Face Buttons (A, B, X, Y; X, CIRCLE, SQUARE, TRIANGLE; etc.)
  private int _faceUp = -1;
  private int _faceDown = -1;
  private int _faceLeft = -1;
  private int _faceRight = -1;

  // Center Buttons (Select/Back; PS/Guide; etc.)
  private int _select = -1;
  private int _menu = -1;
  private int _start = -1;

  // Shoulder Buttons (Triggers may be sliders.)
  private int _leftBumper = -1;
  private int _rightBumper = -1;
  private int _leftTrigger = -1;
  private int _rightTrigger = -1;
  
  //only for a keyboard
  private int _leftStickHorizontalUp = -1;
  private int _rightStickHorizontalUp = -1;
  private int _leftStickVerticalUp = -1;
  private int _rightStickVerticalUp = -1;
  private int _leftStickHorizontalDown = -1;
  private int _rightStickHorizontalDown = -1;
  private int _leftStickVerticalDown = -1;
  private int _rightStickVerticalDown = -1;

  //-------------------- Autodetection Routine --------------------//

  // Constructor
  public Gamepad(ControllIO ctrllIO) {
    controllIO = ctrllIO;
    getGamepadNameAndNumber();
    setButtonsAndSliders();
  }

  // Get Gamepad Name
  private void getGamepadNameAndNumber() {

    ControllDevice controllDevice;
    String currentDevice = "";

    for (int i=0;i<controllIO.getNumberOfDevices();i++) {

      controllDevice = controllIO.getDevice(i);
      currentDevice = controllDevice.getName();

      for (int j=0;j<KNOWN_GAMEPADS.length;j++) {

        if (currentDevice.equals(KNOWN_GAMEPADS[j])) {
          _name = KNOWN_GAMEPADS[j];
          _number = i;
        }
      }
    }
  }

  // Set Button/Slider Numbers
  private void setButtonsAndSliders() {

    if (this._name.equals(PS3)) {
      _leftStickHorizontal = 0;
      _rightStickHorizontal = 2;
      _leftStickVertical = 1;
      _rightStickVertical = 3;

      _leftStick = 1;
      _rightStick = 21;

      _dPadUp = 4;
      _dPadDown = 6;
      _dPadLeft = 7;
      _dPadRight = 5;

      _faceUp = 12;
      _faceDown = 14;
      _faceLeft = 15;
      _faceRight = 13;

      _select = 0;
      _menu = 16;
      _start = 3;

      _leftBumper = 10;
      _rightBumper = 11;
      _leftTrigger = 8;
      _rightTrigger = 9;
    }
    else if (this._name.equals(WIN360)) {
      _leftStickHorizontal = 1;
      _rightStickHorizontal = 3;
      _leftStickVertical = 0;
      _rightStickVertical = 2;

      _leftStick = 8;
      _rightStick = 9;

      _cooliehat = 10;

      _faceUp = 3;
      _faceDown = 0;
      _faceLeft = 2;
      _faceRight = 1;

      _select = 6;
      _start = 7;

      _leftBumper = 4;
      _rightBumper = 5;
      // Triggers?
    }
    else if (this._name.equals(MAC360)) {
      _leftStickHorizontal = 0;
      _rightStickHorizontal = 2;
      _leftStickVertical = 1;
      _rightStickVertical = 3;

      _leftStick = 6;
      _rightStick = 7;

      _dPadUp = 0;
      _dPadDown = 1;
      _dPadLeft = 2;
      _dPadRight = 3;

      _faceUp = 14;
      _faceDown = 11;
      _faceLeft = 13;
      _faceRight = 12;

      _select = 5;
      _menu = 10;
      _start = 4;

      _leftBumper = 8;
      _rightBumper = 9;
      _leftTrigger = 4;
      _rightTrigger = 5;
    }
    else if (this._name.equals(AIRFLO)) {
      _leftStickHorizontal = 0;
      _rightStickHorizontal = 3;
      _leftStickVertical = 1;
      _rightStickVertical = 2;

      _leftStick = 11;
      _rightStick = 12;

      _cooliehat = 13;

      _faceUp = -3;
      _faceDown = 0;
      _faceLeft = 2;
      _faceRight = 1;

      _select = 9;
      _menu = 11;
      _start = 10;

      _leftBumper = 5;
      _rightBumper = 6;
      _leftTrigger = 7;
      _rightTrigger = 8;
    }
    else if (this._name.equals(KEY)) {
        _leftStickHorizontal = 0;
        _rightStickHorizontal = 3;
        _leftStickVertical = 1;
        _rightStickVertical = 2;


        _faceUp = 22;
        _faceDown = 36;
        _faceLeft = 35;
        _faceRight = 37;
        
        _leftStickHorizontalUp = 31;
        _rightStickHorizontalUp = 37;
        _leftStickVerticalUp = 16;
        _rightStickVerticalUp = 22;
        _leftStickHorizontalDown = 29;
        _rightStickHorizontalDown = 35;
        _leftStickVerticalDown = 30;
        _rightStickVerticalDown = 36;
    }
    else {
    }
  }

  //-------------------- Button/Slider Getters --------------------//

  public int leftStickHorizontal() {
    return _leftStickHorizontal;
  }
  public int rightStickHorizontal() {
    return _rightStickHorizontal;
  }
  public int leftStickVertical() {
    return _leftStickVertical;
  }
  public int rightStickVertical() {
    return _rightStickVertical;
  }

  public int leftStick() {
    return _leftStick;
  }
  public int rightStick() {
    return _rightStick;
  }

  public int dPadUp() {
    return _dPadUp;
  }
  public int dPadDown() {
    return _dPadDown;
  }
  public int dPadLeft() {
    return _dPadLeft;
  }
  public int dPadRight() {
    return _dPadRight;
  }

  public int cooliehat() {
    return _cooliehat;
  }

  public int faceUp() {
    return _faceUp;
  }
  public int faceDown() {
    return _faceDown;
  }
  public int faceLeft() {
    return _faceLeft;
  }
  public int faceRight() {
    return _faceRight;
  }

  public int select() {
    return _select;
  }
  public int menu() {
    return _menu;
  }
  public int start() {
    return _start;
  }

  public int leftBumper() {
    return _leftBumper;
  }
  public int rightBumper() {
    return _rightBumper;
  }
  public int leftTrigger() {
    return _leftTrigger;
  }
  public int rightTrigger() {
    return _rightTrigger;
  }

  //-------------------- Name And Number Getter --------------------//

  public String name() {
    return _name;
  }
  public int number() {
    return _number;
  }
}

