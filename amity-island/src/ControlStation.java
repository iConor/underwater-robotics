import java.io.IOException;

import com.jcraft.jsch.JSchException;

import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel newDesiredState;
	RobotModel oldDesiredState;

	GamepadModel gamepad;

	ThrusterController thrusters;

	SecureShell bbb_terminal;

	public void setup() {

		frameRate(4);

		oldDesiredState = new RobotModel();
		newDesiredState = new RobotModel();

		gamepad = new GamepadModel(this);

		thrusters = new ThrusterController(this, newDesiredState, gamepad);

		try {
			bbb_terminal = new SecureShell("root", "192.168.1.103");
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			bbb_terminal.configure();
		} catch (InterruptedException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void draw() {

		oldDesiredState = new RobotModel(newDesiredState);

		thrusters.update();

		if (!newDesiredState.equals(oldDesiredState)) {
			try {
				bbb_terminal.transceive(thrusters.convertToString2(), "9_14 "
						+ newDesiredState.getPortThrusterAngle());
			} catch (IOException | InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			try {
				bbb_terminal.transceive(thrusters.convertToString(), "9_22 "
						+ newDesiredState.getStbdThrusterAngle());
			} catch (IOException | InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		print(newDesiredState.getAftThrusterPower());
		print("\t");
		print(newDesiredState.getPortThrusterPower());
		print("\t");
		println(newDesiredState.getStbdThrusterPower());
	}

	int updateCameraAngle(int oldAngle, int delta) {
		int newAngle = oldAngle - delta;
		if (newAngle > 180 || newAngle < 0) {
			newAngle = oldAngle;
		}
		return newAngle;
	}
}
