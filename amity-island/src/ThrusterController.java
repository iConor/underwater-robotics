import processing.core.*;

public class ThrusterController {

	PApplet processing;
	RobotModel robot;
	GamepadModel gamepad;

	float X, Y, Z;
	float x_prime, y_prime;
	float L_x, R_x;
	float L_theta, R_theta;
	float L, R, Back;

	ThrusterController(PApplet p, RobotModel bot, GamepadModel ctrl) {
		processing = p;
		robot = bot;
		gamepad = ctrl;
	}

	void update() {

		// Read gamepad values.
		X = gamepad.getRightVertical();
		Y = gamepad.getRightHorizontal();
		Z = gamepad.getLeftVertical();

		// Convert gamepad values to ?
		x_prime = (X + Y) * 0.707f; // constant?
		y_prime = (Y - X) * 0.707f; // constant?

		R_x = y_prime;
		L_x = -x_prime;

		// ?
		vector_control();

		robot.setStbdThrusterPower(R);
		robot.setStbdThrusterAngle(R_theta);
		robot.setPortThrusterPower(L);
		robot.setPortThrusterAngle(L_theta);
		robot.setAftThrusterPower(Back);
	}

	String motorControl(int address, int command, float power) {

		if (power < 0) {
			power *= -1;
			command += 1;
		}
		int speed = (int) (power * 126.0);
		int checksum = (speed + address + command) & 127;

		return "\"\\x" + PApplet.hex((byte) address) + "\" \"\\x"
				+ PApplet.hex((byte) command) + "\" \"\\x"
				+ PApplet.hex((byte) speed) + "\" \"\\x"
				+ PApplet.hex((byte) checksum) + "\"";
	}

	void vector_control() {

		float Cg_ratio = .6422f;
		float L_z, R_z;

		// Find front z power.
		R_z = Z / (2 + 2 * Cg_ratio);
		L_z = R_z; // possibly put roll control here

		// Find back power.
		Back = Z * (1 - 1 / (1 + Cg_ratio));

		// Put the motor thrust curve equation here.
		Back = Back;

		if (R_x == 0) {
			R_theta = PApplet.PI / 2;
		} else {
			R_theta = PApplet.atan(R_z / R_x);
		}
		if (L_x == 0) {
			L_theta = PApplet.PI / 2;
		} else {
			L_theta = PApplet.atan(L_z / L_x);
		}
		if (L_theta < 0) {
			L_theta = L_theta + PApplet.PI;
		}
		if (R_theta < 0) {
			R_theta = R_theta + PApplet.PI;
		}

		L_theta = PApplet.degrees(L_theta);
		R_theta = PApplet.degrees(R_theta);

		R = PApplet.sqrt(R_x * R_x + R_z * R_z);
		L = PApplet.sqrt(L_x * L_x + L_z * L_z);

		// Put in motor direction.
		if (R_z < 0) {
			R = -R;
		} else if (R_z == 0) {
			if (R_x < 0) {
				R = -R;
			}
			if (L_x < 0) {
				L = -L;
			}
		}
	}
}
