import processing.core.*;

public class ThrusterController {

	RobotModel robot;
	GamepadModel gamepad;

	ThrusterController(RobotModel bot, GamepadModel ctrl) {
		robot = bot;
		gamepad = ctrl;
	}

	void vector_control() {

		float centerGravityRatio = 0.6422f;

		float verticalAdj = 2;
		float rollCal = 0.1f;
		float pitchCal = .1f;

		float StbdAdj = 1.0f;
		float portAdj = 1.0f;// 0.7f;
		float backAdj = 1.0f;// 0.9f;

		float X, Y, Z;
		float L_x, R_x;
		float L_theta, R_theta;
		float L, R, Back;
		float L_z, R_z;

		// Read gamepad values.
		X = gamepad.getRightStickVertical();
		Y = gamepad.getRightStickHorizontal();
		Z = gamepad.getLeftStickVertical();

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
		Z = Z * verticalAdj;
		R_z = Z / (2 + 2 * centerGravityRatio) + getPitchControl() * pitchCal
				* .5f;
		L_z = R_z + gamepad.getLeftStickHorizontal() * rollCal;
		R_z = R_z - gamepad.getLeftStickHorizontal() * rollCal;

		// Find back z power.
		Back = Z * (1 - 1 / (1 + centerGravityRatio)) - getPitchControl();

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

		robot.setStbdThrusterPower((int) (R * StbdAdj * 127.0f));
		robot.setStbdThrusterAngle((int) R_theta);
		robot.setPortThrusterPower((int) (L * portAdj * 127.0f));
		robot.setPortThrusterAngle((int) L_theta);
		robot.setAftThrusterPower((int) (Back * backAdj * 127.0f));
	}

	float getPitchControl() {
		float pitch = 0;
		if (gamepad.getRightBumper()) {
			pitch = 1.0f;
		} else if (gamepad.getLeftBumper()) {
			pitch = -1.0f;
		}
		return pitch;
	}

	void airplane() {
		int thrust = (int) (gamepad.getLeftStickVertical() * -127.0f);
		robot.setPortThrusterPower(gamepad.getLeftBumper() ? 0 : thrust);
		robot.setStbdThrusterPower(gamepad.getRightBumper() ? 0 : thrust);
		int roll = (int) (90.0f * (thrust < 0 ? -1.0f : 1.0f) * gamepad
				.getRightStickHorizontal());
		robot.setPortThrusterAngle(roll < 0 ? -roll : 0);
		robot.setStbdThrusterAngle(roll < 0 ? 0 : roll);
		robot.setAftThrusterPower((int) (gamepad.getRightStickVertical() * 127.0f));

//		System.out.print(robot.getPortThrusterAngle());
//		System.out.print("\t");
//		System.out.print(robot.getStbdThrusterAngle());
//		System.out.print("\t");
//		System.out.print(robot.getPortThrusterPower());
//		System.out.print("\t");
//		System.out.print(robot.getStbdThrusterPower());
//		System.out.print("\t");
//		System.out.println(robot.getAftThrusterPower());
	}
}
