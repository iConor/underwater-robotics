import processing.core.*;
import hypermedia.net.*;

public class UserDatagramProtocol {

	private RobotModel txBot;
	private RobotModel rxBot;
	private String bb_ip;

	private UDP portAngle;
	private UDP stbdAngle;
	private UDP panAngle;
	private UDP tiltAngle;
	private UDP serialPort;

	/**
	 * @param d
	 * @param r
	 * @param ip
	 */
	public UserDatagramProtocol(RobotModel d, RobotModel r, String ip) {

		txBot = d; // desired
		rxBot = r; // reported
		bb_ip = ip;

		// Match BB pins to software, by port.
		portAngle = new UDP(this, 9022);
		stbdAngle = new UDP(this, 9014);
		panAngle = new UDP(this, 8019);
		tiltAngle = new UDP(this, 9042);
		serialPort = new UDP(this, 9024);

		portAngle.listen(true);
		stbdAngle.listen(true);
		panAngle.listen(true);
		tiltAngle.listen(true);
		serialPort.listen(true);
	}

	/**
	 * 
	 */
	public void writePortThrusterAngle() {
		portAngle.send(angleToPWM(txBot.getPortThrusterAngle()), bb_ip,
				portAngle.port());
	}

	/**
	 * 
	 */
	public void writeStbdThrusterAngle() {
		stbdAngle.send(angleToPWM(txBot.getStbdThrusterAngle()), bb_ip,
				stbdAngle.port());
	}

	/**
	 * 
	 */
	public void writeCameraPanAngle() {
		panAngle.send(angleToPWM(txBot.getCameraPanAngle()), bb_ip,
				panAngle.port());
	}

	/**
	 * 
	 */
	public void writeCameraTiltAngle() {
		tiltAngle.send(angleToPWM(txBot.getCameraTiltAngle()), bb_ip,
				tiltAngle.port());
	}

	/**
	 * 
	 */
	public void writePortThrusterPower() {
		serialPort.send(sabretoothPacket(128, 4, txBot.getPortThrusterPower()),
				bb_ip, serialPort.port());
	}

	/**
	 * 
	 */
	public void writeStarboardThrusterPower() {
		serialPort.send(sabretoothPacket(128, 0, txBot.getStbdThrusterPower()),
				bb_ip, serialPort.port());
	}

	/**
	 * 
	 */
	public void writeAftThrusterPower() {
		serialPort.send(sabretoothPacket(129, 0, txBot.getAftThrusterPower()),
				bb_ip, serialPort.port());
	}

	// UDP event handler. Called whenever any port receives data.
	/**
	 * @param packet
	 * @param ip
	 * @param port
	 */
	public void receive(byte[] packet, String ip, int port) {

		if (port == serialPort.port()) {
			int[] data = decodeSabretooth(packet);
			if (data[0] == 128) { // data[0] == address
				if (data[1] == 4) { // data[1] == command
					rxBot.setPortThrusterPower(data[2]);
				} else { // data[1] == 0
					rxBot.setStbdThrusterPower(data[2]);
				}
			} else {// data[1] == 129
				rxBot.setAftThrusterPower(data[2]);
			}
		} else { // Some servo, for now.
			if (port == portAngle.port()) {
				rxBot.setPortThrusterAngle(pwmToAngle(getPWM(packet)));
			} else if (port == stbdAngle.port()) {
				rxBot.setStbdThrusterAngle(pwmToAngle(getPWM(packet)));
			} else if (port == panAngle.port()) {
				rxBot.setCameraPanAngle(pwmToAngle(getPWM(packet)));
			} else { // port == tiltAngle.port()
				rxBot.setCameraTiltAngle(pwmToAngle(getPWM(packet)));
			}
		}
	}

	// Convert Node's ASCII array to a string of integers.
	/**
	 * @param ascii
	 * @return
	 */
	private String getPWM(byte[] ascii) {
		StringBuilder builder = new StringBuilder();
		for (int i = 0; i < ascii.length; i++) {
			builder.append(Integer.toString(ascii[i] - 48));
		}
		return builder.toString();
	}

	// Format thruster power values to be written to a Sabretooth.
	/**
	 * @param address
	 * @param command
	 * @param speed
	 * @return
	 */
	private String sabretoothPacket(int address, int command, int speed) {

		if (speed < 0) {
			speed *= -1; // Absolute value.
			command += 1; // Indicates negative.
		}

		// In accordance with the data sheet.
		int checksum = (speed + address + command) & 127;

		// Return an eight character hex string.
		return PApplet.hex((byte) address) + PApplet.hex((byte) command)
				+ PApplet.hex((byte) speed) + PApplet.hex((byte) checksum);
	}

	// Undo Sabretooth formatting so values can go into the model.
	/**
	 * @param raw
	 * @return
	 */
	private int[] decodeSabretooth(byte[] raw) {

		int[] processed = new int[4];

		// Cast from byte array to int array, gently.
		for (int i = 0; i < processed.length; i++) {
			processed[i] = (int) raw[i];
		}

		// Address. Either 128 or 129.
		processed[0] &= 129;

		// If speed was negative.
		if (processed[1] == 5 || processed[1] == 1) {
			processed[2] *= -1; // Un-absolute-value.
			processed[1] -= 1; // Un-indicate-negative.
		}
		return processed;
	}

	// Convert an angle from the model to PWM integer string.
	/**
	 * @param angle
	 * @return
	 */
	private String angleToPWM(int angle) {
		return Integer.toString((int) PApplet.map(angle, 0, 180, 550000,
				2450000));
	}

	// Convert a PWM integer string to an angle for the model.
	/**
	 * @param pwm
	 * @return
	 */
	private int pwmToAngle(String pwm) {
		return (int) PApplet.map(Float.valueOf(pwm), 550000, 2450000, 0, 180);
	}
}
