import java.io.IOException;

import com.jcraft.jsch.JSchException;

import processing.core.*;
import procontroll.*;
import gamepad.*;

@SuppressWarnings("serial")
public class ControlStation extends PApplet {

	ControllIO ctrllIO;
	ControllDevice ctrllDevice;

	ControllSlider rightHorizontal;
	ControllSlider rightVertical;
	ControllSlider leftVertical;
	ControllCoolieHat coolieHat;

	SecureShell bbb_terminal;

	float X, Y, Z;
	float x_prime, y_prime;
	float L_x, R_x;
	float L_theta, R_theta;
	float L, R, Back;

	public void setup() {

		// Initialize human-machine interface.
		ctrllIO = ControllIO.getInstance(this);
		GamepadMap gamepad = new GamepadMap(ctrllIO);
		ctrllDevice = ctrllIO.getDevice(gamepad.getName());
		// Initialize buttons and/or sliders.
		rightVertical = ctrllDevice.getSlider(gamepad.getRightStickVertical());
		rightVertical.setTolerance((float) .16);
		rightHorizontal = ctrllDevice.getSlider(gamepad.getRightStickHorizontal());
		rightHorizontal.setTolerance((float) .16);
		leftVertical = ctrllDevice.getSlider(gamepad.getLeftStickVertical());
		leftVertical.setTolerance((float) .16);

		//coolieHat = ctrllDevice.getCoolieHat(gamepad.getCoolieHat());

		// Initialize communication class

		try {
			bbb_terminal = new SecureShell("root", "192.168.7.2");
		} catch (JSchException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		bbb_terminal.configure();
	}

	public void draw() {

//		if (coolieHat.pressed()) {
//			update_camera();
//		}

		// Read gamepad values.
		X = rightVertical.getValue();
		Y = rightHorizontal.getValue();
		Z = leftVertical.getValue();

		// Convert gamepad values to ?
		x_prime = (float) ((X + Y) * 0.707); // constant?
		y_prime = (float) ((Y - X) * 0.707); // constant?
		R_x = y_prime;
		L_x = -x_prime;

		// ?
		vector_control();

		// Update Communication class.
		rightmotor(R, R_theta);
		leftmotor(L, L_theta);
		Zmotor(Back);

		// println(convertToString());
		if(frameCount % 15 == 0) {
			try {
				bbb_terminal.transceive(convertToString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	String convertToString() {

		String commandString = starboard_thruster_servo_angle + " "
				+ port_thruster_servo_angle + " " + aft_thruster_motor_power4
				+ " " + aft_thruster_motor_powerB + " "
				+ motorControl(128, 1, starboard_thruster_motor_power) + " "
				+ motorControl(128, 2, port_thruster_motor_power);

		return commandString;

	}

	String motorControl(int address_, int motor_, int power) {
		byte thing1_;
		int speed_;
		int thing2_;
		if (motor_ == 1) {
			if (power >= 128) {
				thing1_ = (byte) 0;
				speed_ = power - 127;
				thing2_ = (speed_ + address_) & 127;
			} else {
				thing1_ = 1;
				speed_ = 127 - power;
				thing2_ = (speed_ + address_ + 1) & 127;
			}
		} else { // motor_ == 2
			if (power >= 128) {
				thing1_ = 4;
				speed_ = power - 127;
				thing2_ = (speed_ + address_ + 4) & 127;
			} else {
				thing1_ = 5;
				speed_ = 127 - power;
				thing2_ = (speed_ + address_ + 5) & 127;
			}
		}

		byte speed__ = (byte) (speed_);
		byte address__ = (byte) (address_);
		byte thing2__ = (byte) (thing2_);

		String out = " \"\\x" + hex(address__) + "\" \"\\x" + hex(thing1_)
				+ "\" \"\\x" + hex(speed__) + "\" \"\\x" + hex(thing2__) + "\"";

		return out;
	}

	int camera_pan_servo_angle = 90;
	int camera_tilt_servo_angle = 90;

	void update_camera() {
		camera_pan_servo_angle = camera_angle(camera_pan_servo_angle,
				(int) (coolieHat.getX()));
		camera_tilt_servo_angle = camera_angle(camera_tilt_servo_angle,
				(int) (coolieHat.getY()));
	}

	int camera_angle(int old_angle, int delta) {
		int new_angle = old_angle - delta;
		if (new_angle > 180 || new_angle < 0) {
			new_angle = old_angle;
		}
		return new_angle;
	}

	void vector_control() {

		float Cg_ratio = (float) .6422;
		float L_z, R_z;

		// Find front z power.
		R_z = Z / (2 + 2 * Cg_ratio);
		L_z = R_z; // possibly put roll control here

		// Find back power.
		Back = Z * (1 - 1 / (1 + Cg_ratio));

		// Put the motor thrust curve equation here.
		Back = Back;

		if (R_x == 0) {
			R_theta = PI / 2;
		} else {
			R_theta = atan(R_z / R_x);
		}
		if (L_x == 0) {
			L_theta = PI / 2;
		} else {
			L_theta = atan(L_z / L_x);
		}
		if (L_theta < 0) {
			L_theta = L_theta + PI;
		}
		if (R_theta < 0) {
			R_theta = R_theta + PI;
		}

		L_theta = degrees(L_theta);

		R_theta = degrees(R_theta);

		R = sqrt(R_x * R_x + R_z * R_z);
		L = sqrt(L_x * L_x + L_z * L_z);

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

	int aft_thruster_motor_power4, aft_thruster_motor_powerB,
			port_thruster_motor_power, starboard_thruster_motor_power;
	int port_thruster_servo_angle;
	int starboard_thruster_servo_angle, claw_servo;
	int cam_servo_x, cam_servo_y;
	int check;

	// Provides motor power inputs.
	void Zmotor(float power) {
		if (power > 0) {
			aft_thruster_motor_power4 = (byte) ((int) (map(power, 0, 1, 0, 254)));
			aft_thruster_motor_powerB = (byte) (0);
		} else {
			aft_thruster_motor_powerB = (byte) ((int) (map(power, 0, -1, 0, 254)));
			aft_thruster_motor_power4 = (byte) (0);
		}
	}

	void leftmotor(float power, float angle) {
		if (power > 0) {
			port_thruster_motor_power = (byte) (power * 120 + 128);
		} else {
			port_thruster_motor_power = (byte) (power * 120 - 128);
		}
		port_thruster_servo_angle = (int) (map(angle, 0, 180, 550000, 2450000));// int(map(angle,0,180,0,255));
	}

	void rightmotor(float power, float angle) {
		if (power > 0) {
			starboard_thruster_motor_power = (byte) (power * 120 + 128);
		} else {
			starboard_thruster_motor_power = (byte) (power * 120 - 128);
		}
		starboard_thruster_servo_angle = (int) (map(angle, 0, 180, 550000, 2450000));// int(map(angle,0 180,0,255));
	}
}
