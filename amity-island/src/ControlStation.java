import processing.core.*;
import procontroll.*;
import gamepad.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	ControllIO ctrllIO;
	ControllDevice ctrllDevice;
	ControllButton[] button;
	ControllSlider[] slider;

	public void setup() {
		ctrllIO = ControllIO.getInstance(this);
		GamepadMap gamepadMap = new GamepadMap(ctrllIO);
		ctrllDevice = ctrllIO.getDevice(gamepadMap.getName());

		button = new ControllButton[ctrllDevice.getNumberOfButtons()];
		slider = new ControllSlider[ctrllDevice.getNumberOfSliders()];

		for (int i = 0; i < button.length; i++) {
			button[i] = ctrllDevice.getButton(i);
		}
		for (int i = 0; i < slider.length; i++) {
			slider[i] = ctrllDevice.getSlider(i);
		}
	}

	public void draw() {
		for (int i = 0; i < button.length; i++) {
			if (button[i].pressed()) {
				print("  " + i);
			}
		}
		println();
		for (int i = 0; i < slider.length; i++) {
			print("  " + slider[i].getValue());
		}
		println();
	}

}
