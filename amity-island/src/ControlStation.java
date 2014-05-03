import java.io.IOException;
import java.io.UnsupportedEncodingException;

import com.jcraft.jsch.JSchException;

import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel newDesiredState;
	RobotModel oldDesiredState;

	GamepadModel gamepad;

	ThrusterController thrusters;

	Node_udp UDP;

	public void setup() {

		frameRate(5);

		oldDesiredState = new RobotModel();
		newDesiredState = new RobotModel();

		gamepad = new GamepadModel(this);

		thrusters = new ThrusterController(this, newDesiredState, gamepad);
		// beaglebone,me
		UDP = new Node_udp("192.168.1.102", "192.168.1.101");

	}

	public void draw() {

		oldDesiredState = new RobotModel(newDesiredState);

		byte[] allMotors = new byte[12];

		thrusters.update();

		if (gamepad.getCoolieHat()) {
			newDesiredState.setCameraPanAngle(updateCameraAngle(
					oldDesiredState.getCameraPanAngle(),
					5 * gamepad.getCoolieHatX()));
			newDesiredState.setCameraTiltAngle(updateCameraAngle(
					oldDesiredState.getCameraTiltAngle(),
					5 * gamepad.getCoolieHatY()));
		}

		if (!newDesiredState.equals(oldDesiredState)) {

//			System.arraycopy(
//					UDP.sabretoothPacket(128, 4,
//							newDesiredState.getPortThrusterPower()), 0,
//					allMotors, 0, 4);
//			System.arraycopy(
//					UDP.sabretoothPacket(128, 0,
//							newDesiredState.getStbdThrusterPower()), 0,
//					allMotors, 4, 4);
//			System.arraycopy(
//					UDP.sabretoothPacket(129, 0,
//							newDesiredState.getAftThrusterPower()), 0,
//					allMotors, 8, 4);

			// UDP.sendPacket(allMotors, 41234);
			UDP.sendPacket(
					thrusters.sabretoothPacket(128, 4,
							newDesiredState.getPortThrusterPower()), 41234);
			UDP.sendPacket(
					thrusters.sabretoothPacket(128, 0,
							newDesiredState.getStbdThrusterPower()), 41234);
			UDP.sendPacket(
					thrusters.sabretoothPacket(129, 0,
							newDesiredState.getAftThrusterPower()), 41234);

			UDP.sendPacket(
					convertToNanoseconds(newDesiredState.getStbdThrusterAngle()),
					41235);// pwm pin 9_14
			UDP.sendPacket(
					convertToNanoseconds(newDesiredState.getPortThrusterAngle()),
					41236);// pwm pin 9_22
			UDP.sendPacket(
					convertToNanoseconds(newDesiredState.getCameraTiltAngle()),
					41237);// pwm pin 9_42
			UDP.sendPacket(
					convertToNanoseconds(newDesiredState.getCameraPanAngle()),
					41238);// pwm pin 8_19

		}

		// print(newDesiredState.getAftThrusterPower());
		// print("\t");
		// print(newDesiredState.getPortThrusterPower());
		// print("\t");
		// println(newDesiredState.getStbdThrusterPower());
	}

	int updateCameraAngle(int oldAngle, int delta) {
		int newAngle = oldAngle - delta;
		if (newAngle > 180 || newAngle < 0) {
			newAngle = oldAngle;
		}
		return newAngle;
	}

	String convertToNanoseconds(float angle) {
		return String
				.valueOf((int) PApplet.map(angle, 0, 180, 550000, 2450000));
	}
}
