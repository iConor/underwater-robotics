import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel desiredState;
	RobotModel reportedState;

	GamepadModel gamepad;

	PanTiltController camera;

	ThrusterController thrusters;

	UserDatagramProtocol network;

	public void setup() {

		reportedState = new RobotModel();
		desiredState = new RobotModel();

		gamepad = new GamepadModel(this);

		camera = new PanTiltController(desiredState, gamepad);

		thrusters = new ThrusterController(this, desiredState, gamepad);

		network = new UserDatagramProtocol(this, "192.168.1.71");
	}

	public void draw() {

		reportedState = new RobotModel(desiredState);

		camera.update();

		thrusters.update();
		
		if (reportedState.getPortThrusterAngle() != desiredState
				.getPortThrusterAngle()) {
			network.writePortThrusterAngle(mapAngle(desiredState
					.getPortThrusterAngle()));
		}
		if (reportedState.getStbdThrusterAngle() != desiredState
				.getStbdThrusterAngle()) {
			network.writeStbdThrusterAngle(mapAngle(desiredState
					.getStbdThrusterAngle()));
		}
		if (reportedState.getCameraPanAngle() != desiredState
				.getCameraPanAngle()) {
			network.writeCameraPanAngle(mapAngle(desiredState
					.getCameraPanAngle()));
		}
		if (reportedState.getCameraTiltAngle() != desiredState
				.getCameraTiltAngle()) {
			network.writeCameraTiltAngle(mapAngle(desiredState
					.getCameraTiltAngle()));
		}
		if (reportedState.getPortThrusterPower() != desiredState.getPortThrusterPower()) {
			network.writeThrusterPower(thrusters.sabretoothPacket(128, 4,
					desiredState.getPortThrusterPower()));
		}
		if (reportedState.getStbdThrusterPower() != desiredState.getStbdThrusterPower()) {
			network.writeThrusterPower(thrusters.sabretoothPacket(128, 0,
					desiredState.getStbdThrusterPower()));
		}
		if (reportedState.getAftThrusterPower() != desiredState.getAftThrusterPower()) {
			network.writeThrusterPower(thrusters.sabretoothPacket(129, 0,
					desiredState.getAftThrusterPower()));
		}

	}

	String mapAngle(int angle) {
		return Integer.toString((int) PApplet.map(angle, 0, 180, 550000,
				2450000));
	}
}
