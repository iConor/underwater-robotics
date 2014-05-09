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
		if (reported.getPortThrusterAngle() != desired.getPortThrusterAngle()) {
			network.writePortThrusterAngle();
		}
		if (reported.getStbdThrusterAngle() != desired.getStbdThrusterAngle()) {
			network.writeStbdThrusterAngle();
		}
		if (reported.getCameraPanAngle() != desired.getCameraPanAngle()) {
			network.writeCameraPanAngle();
		}
		if (reported.getCameraTiltAngle() != desired.getCameraTiltAngle()) {
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
