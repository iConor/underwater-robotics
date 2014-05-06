import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel newDesiredState;
	RobotModel oldDesiredState;

	GamepadModel gamepad;

	PanTiltController camera;

	ThrusterController thrusters;

	UserDatagramProtocol network;

	public void setup() {

		oldDesiredState = new RobotModel();
		newDesiredState = new RobotModel();

		gamepad = new GamepadModel(this);

		camera = new PanTiltController(newDesiredState, gamepad);

		thrusters = new ThrusterController(this, newDesiredState, gamepad);

		network = new UserDatagramProtocol(this, "192.168.1.71");
	}

	public void draw() {

		oldDesiredState = new RobotModel(newDesiredState);

		camera.update();

		thrusters.update();
		if (oldDesiredState.getPortThrusterAngle() != newDesiredState
				.getPortThrusterAngle()) {
			network.writePortThrusterAngle(mapAngle(newDesiredState
					.getPortThrusterAngle()));
		}
		if (oldDesiredState.getStbdThrusterAngle() != newDesiredState
				.getStbdThrusterAngle()) {
			network.writeStbdThrusterAngle(mapAngle(newDesiredState
					.getStbdThrusterAngle()));
		}
		if (oldDesiredState.getCameraPanAngle() != newDesiredState
				.getCameraPanAngle()) {
			network.writeCameraPanAngle(mapAngle(newDesiredState
					.getCameraPanAngle()));
		}
		if (oldDesiredState.getCameraTiltAngle() != newDesiredState
				.getCameraTiltAngle()) {
			network.writeCameraTiltAngle(mapAngle(newDesiredState
					.getCameraTiltAngle()));
		}
		if (oldDesiredState.getPortThrusterPower() != newDesiredState.getPortThrusterPower()) {
			network.writeThrusterPower(thrusters.sabretoothPacket(128, 4,
					newDesiredState.getPortThrusterPower()));
		}
		if (oldDesiredState.getStbdThrusterPower() != newDesiredState.getStbdThrusterPower()) {
			network.writeThrusterPower(thrusters.sabretoothPacket(128, 0,
					newDesiredState.getStbdThrusterPower()));
		}
		if (oldDesiredState.getAftThrusterPower() != newDesiredState.getAftThrusterPower()) {
			network.writeThrusterPower(thrusters.sabretoothPacket(129, 0,
					newDesiredState.getAftThrusterPower()));
		}

	}

	String mapAngle(int angle) {
		return Integer.toString((int) PApplet.map(angle, 0, 180, 550000,
				2450000));
	}
}
