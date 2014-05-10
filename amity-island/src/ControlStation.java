import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel desired;
	RobotModel reported;

	GamepadModel gamepad;

	PanTiltController camera;

	ThrusterController thrusters;

	UserDatagramProtocol network;
	String BB_IP = "192.168.1.101";
	String PC_IP = "192.168.1.100";
	
	private enum MODE { // Thruster control modes.
		VC, AP;
		public MODE next() { // Cycles through modes.
			return values()[(ordinal() + 1) % values().length];
		}
	}
	
	MODE mode = MODE.VC;

	public void setup() {

		desired = new RobotModel();
		reported = new RobotModel();

		gamepad = new GamepadModel(this);

		camera = new PanTiltController(desired, gamepad);

		thrusters = new ThrusterController(desired, gamepad);

		network = new UserDatagramProtocol(desired, reported, BB_IP);
	}

	public void draw() {
		
		if(gamepad.getSelect()){ // Cycle to next control mode.
			mode = mode.next(); // Really needs to be debounced.
		}

		camera.update(); // Desired robot model.
		
		if(mode.equals(MODE.VC)){
			thrusters.vector_control();
		} else {
			thrusters.airplane();
		}


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
