import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel desired;
	RobotModel reported;

	GamepadModel gamepad;

	PanTiltController camera;

	ThrusterController thrusters;

	UserDatagramProtocol network;
	String BB_IP = "192.168.1.71";
	String PC_IP = "192.168.1.66";

	public void setup() {

		desired = new RobotModel();
		reported = new RobotModel();

		gamepad = new GamepadModel(this);

		camera = new PanTiltController(desired, gamepad);

		thrusters = new ThrusterController(desired, gamepad);

		network = new UserDatagramProtocol(desired, reported, BB_IP);
	}

	public void draw() {

		camera.update(); // Desired robot model.

		thrusters.update(); // Desired robot model.

		// Transmit desired robot model values if they don't match reported
		// values.
		if (abs(reported.getPortThrusterAngle() - desired.getPortThrusterAngle()) > 1) {
			network.writePortThrusterAngle();
		}
		if (abs(reported.getStbdThrusterAngle() - desired.getStbdThrusterAngle()) > 1) {
			network.writeStbdThrusterAngle();
		}
		if (abs(reported.getCameraPanAngle() - desired.getCameraPanAngle()) > 1) {
			network.writeCameraPanAngle();
		}
		if (abs(reported.getCameraTiltAngle() - desired.getCameraTiltAngle()) > 1) {
			network.writeCameraTiltAngle();
		}
		if (reported.getPortThrusterPower() != desired.getPortThrusterPower()) {
			network.writePortThrusterPower();
		}
		if (reported.getStbdThrusterPower() != desired.getStbdThrusterPower()) {
			network.writeStarboardThrusterPower();
		}
		if (reported.getAftThrusterPower() != desired.getAftThrusterPower()) {
			network.writeAftThrusterPower();
		}
	}
}
