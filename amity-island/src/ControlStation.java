import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel desired;
	RobotModel reported;
	RobotModel last;

	GamepadModel gamepad;

	PanTiltController camera;

	ThrusterController thrusters;

	UserDatagramProtocol network;
	String BB_IP = "192.168.1.3";
	String PC_IP = "192.168.1.2";

	public void setup() {

		desired = new RobotModel();
		reported = new RobotModel();

		gamepad = new GamepadModel(this);

		camera = new PanTiltController(desired, gamepad);

		thrusters = new ThrusterController(desired, gamepad);

		network = new UserDatagramProtocol(desired, reported, BB_IP);

		System.out.println("Setup complete.");
	}

	public void draw() {

		last = new RobotModel(desired);

		camera.update(); // Desired robot model.

		thrusters.update();

		// Transmit desired robot model values if they don't match reported
		// values.
		if (abs(reported.getPortThrusterAngle()
				- desired.getPortThrusterAngle()) > 1) {
			network.writePortThrusterAngle();
		}
		if (abs(reported.getStbdThrusterAngle()
				- desired.getStbdThrusterAngle()) > 1) {
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

		// printThrusters(desired);
		if (frameCount % 1200 == 0) {
			System.out.println(".");
		} else if (frameCount % 15 == 0) {
			System.out.print(".");
		}
	}

	void printThrusters(RobotModel robot) {
		System.out.print(robot.getPortThrusterAngle());
		System.out.print("\t");
		System.out.print(robot.getStbdThrusterAngle());
		System.out.print("\t");
		System.out.print(robot.getPortThrusterPower());
		System.out.print("\t");
		System.out.print(robot.getStbdThrusterPower());
		System.out.print("\t");
		System.out.println(robot.getAftThrusterPower());
	}
}
