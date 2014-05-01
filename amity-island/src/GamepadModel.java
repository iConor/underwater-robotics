import processing.core.*;
import procontroll.*;
import gamepad.*;

public class GamepadModel {

	private ControllIO ctrllIO;
	private ControllDevice ctrllDevice;

	private ControllSlider leftVertical;
	private ControllSlider rightHorizontal;
	private ControllSlider rightVertical;
	private ControllCoolieHat coolieHat;

	GamepadModel(PApplet processing) {
		this(processing, .16f);
	}

	GamepadModel(PApplet processing, float tolerance) {

		ctrllIO = ControllIO.getInstance(processing);
		GamepadMap gamepadMap = new GamepadMap(ctrllIO);
		ctrllDevice = ctrllIO.getDevice(gamepadMap.getName());

		leftVertical = ctrllDevice.getSlider(gamepadMap.getLeftStickVertical());
		leftVertical.setTolerance(tolerance);

		rightHorizontal = ctrllDevice.getSlider(gamepadMap
				.getRightStickHorizontal());
		rightHorizontal.setTolerance(tolerance);

		rightVertical = ctrllDevice.getSlider(gamepadMap
				.getRightStickVertical());
		rightVertical.setTolerance(tolerance);

		coolieHat = ctrllDevice.getCoolieHat(gamepadMap.getCoolieHat());

	}

	/**
	 * @return the leftVertical
	 */
	public float getLeftVertical() {
		return leftVertical.getValue();
	}

	/**
	 * @return the rightHorizontal
	 */
	public float getRightHorizontal() {
		return rightHorizontal.getValue();
	}

	/**
	 * @return the rightVertical
	 */
	public float getRightVertical() {
		return rightVertical.getValue();
	}

	/**
	 * @return the coolieHat
	 */
	public boolean getCoolieHat() {
		return coolieHat.pressed();
	}

	/**
	 * @return the coolieHat
	 */
	public int getCoolieHatX() {
		return (int) coolieHat.getX();
	}

	/**
	 * @return the coolieHat
	 */
	public int getCoolieHatY() {
		return (int) coolieHat.getY();
	}
}
