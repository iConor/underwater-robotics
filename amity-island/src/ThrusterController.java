import processing.core.*;

public class ThrusterController {

	PApplet processing;
	RobotModel robot;
	GamepadModel gamepad;

	ThrusterController(PApplet p, RobotModel bot, GamepadModel ctrl) {
		processing = p;
		robot = bot;
		gamepad = ctrl;
	}

	void update() {

		float centerGravityRatio = 0.6422f;
		float sin45 = 0.707f;

		float X, Y, Z;
		float L_x, R_x;
		float L_theta, R_theta;
		float L, R, Back;
		float L_z, R_z;

		// Read gamepad values.
		X = gamepad.getRightVertical();
		Y = gamepad.getRightHorizontal();
		Z = gamepad.getLeftVertical();

		// Rotate gamepad values 45 degrees.
		// Convert to polar coordinates.
		float r = PApplet.sqrt(X * X + Y * Y);
		// Prevent division by zero.
		X = X == 0 ? .00000000001f : X;
		float theta = PApplet.atan(Y / X);
		
		// Enforce -1 <= r <= 1.
		r = r > 1 ? 1 : r;
		r = r < -1 ? -1 : r;
		
		// Fix theta based on quadrant.
		if (Y >= 0) {
			if (X >= 0)
				theta += 0;
			else
				theta += PApplet.PI;
		} else {
			if (X < 0)
				theta += PApplet.PI;
			else
				theta += 2 * PApplet.PI;
		}

		// Rotate 45 degrees clockwise.
		theta -= PApplet.PI / 4;
		// Handle resulting negative values.
		theta = theta < 0 ? 2 * PApplet.PI + theta : theta;

		// Convert back to cartesian coordinates.
		R_x = -r * PApplet.cos(theta); // Flipped axis?
		L_x = r * PApplet.sin(theta);

		// vector_control();

		// Find front z power.
		R_z = Z / (2 + 2 * centerGravityRatio);
		L_z = R_z;

		// Find back z power.
		Back = Z * (1 - 1 / (1 + centerGravityRatio));

		// Find angles.
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

		// Radians to degrees.
		L_theta = PApplet.degrees(L_theta);
		R_theta = PApplet.degrees(R_theta);

		// Pythagoras knows final power.
		R = PApplet.sqrt(R_x * R_x + R_z * R_z);
		L = PApplet.sqrt(L_x * L_x + L_z * L_z);

		// Put in motor direction.
		if (R_z < 0) {
			R = -R;
			L = -L;
		} else if (R_z == 0) {
			if (R_x < 0) {
				R = -R;
			}
			if (L_x < 0) {
				L = -L;
			}
		}

		robot.setStbdThrusterPower(R);
		robot.setStbdThrusterAngle(R_theta);
		robot.setPortThrusterPower(L);
		robot.setPortThrusterAngle(L_theta);
		robot.setAftThrusterPower(Back);
	}

	String sabretoothPacket(int address, int command, float power) {

		if (power < 0) {
			power *= -1;
			command += 1;
		}
		int speed = (int) (power * 127.0f);
		int checksum = (speed + address + command) & 127;

		return "\"\\x" + PApplet.hex((byte) address) + "\" \"\\x"
				+ PApplet.hex((byte) command) + "\" \"\\x"
				+ PApplet.hex((byte) speed) + "\" \"\\x"
				+ PApplet.hex((byte) checksum) + "\"";
	}
	
}
