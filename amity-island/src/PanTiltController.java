public class PanTiltController {

	RobotModel robot;
	GamepadModel gamepad;
	
	private final int increment = 5;
	private final int decrement = -1 * increment;

	PanTiltController(RobotModel bot, GamepadModel ctrl) {
		robot = bot;
		gamepad = ctrl;
	}

	void update() {
		if (gamepad.getdPadUp()) {
			robot.setCameraTiltAngle(updateCameraAngle(
					robot.getCameraTiltAngle(), increment));
		} else if (gamepad.getdPadDown()) {
			robot.setCameraTiltAngle(updateCameraAngle(
					robot.getCameraTiltAngle(), decrement));
		} else if (gamepad.getdPadLeft()) {
			robot.setCameraPanAngle(updateCameraAngle(
					robot.getCameraPanAngle(), increment));
		} else if (gamepad.getdPadRight()) {
			robot.setCameraPanAngle(updateCameraAngle(
					robot.getCameraPanAngle(), decrement));
		}
	}

	int updateCameraAngle(int oldAngle, int delta) {
		int newAngle = oldAngle - delta;
		if (newAngle > 180 || newAngle < 0) {
			newAngle = oldAngle;
		}
		return newAngle;
	}
}
