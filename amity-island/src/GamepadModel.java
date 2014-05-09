import processing.core.*;
import procontroll.*;
import gamepad.*;

public class GamepadModel {

	private ControllIO ctrllIO;
	private ControllDevice ctrllDevice;

	private ControllSlider leftStickHorizontal;
	private ControllSlider rightStickHorizontal;
	private ControllSlider leftStickVertical;
	private ControllSlider rightStickVertical;

	private ControllButton leftStick;
	private ControllButton rightStick;

	private ControllButton dPadUp;
	private ControllButton dPadDown;
	private ControllButton dPadLeft;
	private ControllButton dPadRight;
	// OR
	private ControllCoolieHat coolieHat;

	private ControllButton faceUp;
	private ControllButton faceDown;
	private ControllButton faceLeft;
	private ControllButton faceRight;

	private ControllButton select;
	private ControllButton menu;
	private ControllButton start;

	private ControllButton leftBumper;
	private ControllButton rightBumper;
	private ControllButton leftTrigger;
	private ControllButton rightTrigger;

	boolean dPad = false;

	GamepadModel(PApplet processing) {
		this(processing, .16f);
	}

	GamepadModel(PApplet processing, float tolerance) {

		ctrllIO = ControllIO.getInstance(processing);
		GamepadMap gamepadMap = new GamepadMap(ctrllIO);
		ctrllDevice = ctrllIO.getDevice(gamepadMap.getName());

		// Set dPad true if there is no coolie hat.
		dPad = gamepadMap.getCoolieHat() == -1 ? true : false;

		// Stick Sliders
		leftStickHorizontal = ctrllDevice.getSlider(gamepadMap
				.getLeftStickHorizontal());
		rightStickHorizontal = ctrllDevice.getSlider(gamepadMap
				.getRightStickHorizontal());
		leftStickVertical = ctrllDevice.getSlider(gamepadMap
				.getLeftStickVertical());
		rightStickVertical = ctrllDevice.getSlider(gamepadMap
				.getRightStickVertical());

		// Stick Buttons
		// leftStick = ctrllDevice.getButton(gamepadMap.getLeftStick());
		// rightStick = ctrllDevice.getButton(gamepadMap.getRightStick());

		// D-Pad or Coolie Hat
		if (dPad) {
			dPadUp = ctrllDevice.getButton(gamepadMap.getdPadUp());
			dPadDown = ctrllDevice.getButton(gamepadMap.getdPadDown());
			dPadLeft = ctrllDevice.getButton(gamepadMap.getdPadLeft());
			dPadRight = ctrllDevice.getButton(gamepadMap.getdPadRight());
		} else {
			coolieHat = ctrllDevice.getCoolieHat(gamepadMap.getCoolieHat());
		}

		// Face Buttons (A, B, X, Y; X, CIRCLE, SQUARE, TRIANGLE; etc.)
		faceUp = ctrllDevice.getButton(gamepadMap.getFaceUp());
		faceDown = ctrllDevice.getButton(gamepadMap.getFaceDown());
		faceLeft = ctrllDevice.getButton(gamepadMap.getFaceLeft());
		faceRight = ctrllDevice.getButton(gamepadMap.getFaceRight());

		// Center Buttons (Select/Back; PS/Guide; etc.)
		select = ctrllDevice.getButton(gamepadMap.getSelect());
		// menu = ctrllDevice.getButton(gamepadMap.getMenu());
		start = ctrllDevice.getButton(gamepadMap.getStart());

		// Shoulder Buttons (Triggers may be sliders.)
		leftBumper = ctrllDevice.getButton(gamepadMap.getLeftBumper());
		rightBumper = ctrllDevice.getButton(gamepadMap.getRightBumper());
		// leftTrigger = ctrllDevice.getButton(gamepadMap.getLeftTrigger());
		// rightTrigger = ctrllDevice.getButton(gamepadMap.getRightTrigger());

		// Slider Dead Zone
		leftStickHorizontal.setTolerance(tolerance);
		rightStickHorizontal.setTolerance(tolerance);
		leftStickVertical.setTolerance(tolerance);
		rightStickVertical.setTolerance(tolerance);
	}

	/**
	 * @return the leftStickHorizontal
	 */
	public float getLeftStickHorizontal() {
		return leftStickHorizontal.getValue();
	}

	/**
	 * @return the rightStickHorizontal
	 */
	public float getRightStickHorizontal() {
		return rightStickHorizontal.getValue();
	}

	/**
	 * @return the leftStickVertical
	 */
	public float getLeftStickVertical() {
		return leftStickVertical.getValue();
	}

	/**
	 * @return the rightStickVertical
	 */
	public float getRightStickVertical() {
		return rightStickVertical.getValue();
	}

	/**
	 * @return the leftStick
	 */
	public boolean getLeftStick() {
		return leftStick.pressed();
	}

	/**
	 * @return the rightStick
	 */
	public boolean getRightStick() {
		return rightStick.pressed();
	}

	/**
	 * @return the dPadUp
	 */
	public boolean getdPadUp() {
		return dPad ? dPadUp.pressed() : coolieHat.getY() > 0;
	}

	/**
	 * @return the dPadDown
	 */
	public boolean getdPadDown() {
		return dPad ? dPadDown.pressed() : coolieHat.getY() < 0;
	}

	/**
	 * @return the dPadLeft
	 */
	public boolean getdPadLeft() {
		return dPad ? dPadLeft.pressed() : coolieHat.getX() > 0;
	}

	/**
	 * @return the dPadRight
	 */
	public boolean getdPadRight() {
		return dPad ? dPadRight.pressed() : coolieHat.getX() < 0;
	}

	/**
	 * @return the faceUp
	 */
	public boolean getFaceUp() {
		return faceUp.pressed();
	}

	/**
	 * @return the faceDown
	 */
	public boolean getFaceDown() {
		return faceDown.pressed();
	}

	/**
	 * @return the faceLeft
	 */
	public boolean getFaceLeft() {
		return faceLeft.pressed();
	}

	/**
	 * @return the faceRight
	 */
	public boolean getFaceRight() {
		return faceRight.pressed();
	}

	/**
	 * @return the select
	 */
	public boolean getSelect() {
		return select.pressed();
	}

	/**
	 * @return the menu
	 */
	public boolean getMenu() {
		return menu.pressed();
	}

	/**
	 * @return the start
	 */
	public boolean getStart() {
		return start.pressed();
	}

	/**
	 * @return the leftBumper
	 */
	public boolean getLeftBumper() {
		return leftBumper.pressed();
	}

	/**
	 * @return the rightBumper
	 */
	public boolean getRightBumper() {
		return rightBumper.pressed();
	}

	/**
	 * @return the leftTrigger
	 */
	public boolean getLeftTrigger() {
		return leftTrigger.pressed();
	}

	/**
	 * @return the rightTrigger
	 */
	public boolean getRightTrigger() {
		return rightTrigger.pressed();
	}
}
