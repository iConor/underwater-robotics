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
		
		UDP = new Node_udp("192.168.7.2", "192.168.1.100");


	}

	public void draw() {

		oldDesiredState = new RobotModel(newDesiredState);

		thrusters.update();
		
		if(gamepad.getCoolieHat()){
			newDesiredState.setCameraPanAngle(updateCameraAngle(oldDesiredState.getCameraPanAngle(),5*gamepad.getCoolieHatX()));
			newDesiredState.setCameraTiltAngle(updateCameraAngle(oldDesiredState.getCameraTiltAngle(),5*gamepad.getCoolieHatY()));
		}

		if (!newDesiredState.equals(oldDesiredState)) {
				try {
					UDP.sendPacket(
							UDP.sabretoothPacket(128, 4,
									newDesiredState.getPortThrusterPower())+
						    UDP.sabretoothPacket(128, 0,
									newDesiredState.getStbdThrusterPower())+
							UDP.sabretoothPacket(129, 0,
									newDesiredState.getAftThrusterPower()),41234);
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				UDP.sendPacket(convertToNanoseconds(newDesiredState.getPortThrusterAngle()), 41235);//pwm pin 9_14
				UDP.sendPacket(convertToNanoseconds(newDesiredState.getStbdThrusterAngle()), 41236);//pwm pin 9_22
				UDP.sendPacket(convertToNanoseconds(newDesiredState.getCameraPanAngle()), 41237);//pwm pin 9_42
				UDP.sendPacket(convertToNanoseconds(newDesiredState.getCameraTiltAngle()), 41238);//pwm pin 8_19
				
		}

		
//		print(newDesiredState.getAftThrusterPower());
//		print("\t");
//		print(newDesiredState.getPortThrusterPower());
//		print("\t");
//		println(newDesiredState.getStbdThrusterPower());
	}

	int updateCameraAngle(int oldAngle, int delta) {
		int newAngle = oldAngle - delta;
		if (newAngle > 180 || newAngle < 0) {
			newAngle = oldAngle;
		}
		return newAngle;
	}
	
	String convertToNanoseconds(float angle) {
		return String.valueOf((int) PApplet.map(angle,0,180,550000,2450000));
	}
}
