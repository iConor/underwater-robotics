import java.io.IOException;

import com.jcraft.jsch.JSchException;

import processing.core.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	RobotModel newDesiredState;
	RobotModel oldDesiredState;

	GamepadModel gamepad;
	
	PanTiltController camera;

	ThrusterController thrusters;

	SecureShell bbb_terminal;

	public void setup() {

		frameRate(5);

		oldDesiredState = new RobotModel();
		newDesiredState = new RobotModel();

		gamepad = new GamepadModel(this);
		
		camera = new PanTiltController(newDesiredState, gamepad);
		
		thrusters = new ThrusterController(this, newDesiredState, gamepad);

		try {
			bbb_terminal = new SecureShell("root", "192.168.1.102",
					newDesiredState);
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
		
		camera.update();

		thrusters.update();

		if (!newDesiredState.equals(oldDesiredState)) {
			try {
				bbb_terminal.transceive(
						thrusters.sabretoothPacket(128, 4,
								newDesiredState.getPortThrusterPower()),
						thrusters.sabretoothPacket(128, 0,
								newDesiredState.getStbdThrusterPower()),
						thrusters.sabretoothPacket(129, 0,
								newDesiredState.getAftThrusterPower()));
			} catch (IOException | InterruptedException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
}
