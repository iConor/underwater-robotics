import processing.core.*;
import hypermedia.net.*;

public class UserDatagramProtocol {

	PApplet processing;
	String ip;

	private UDP udp9_22, udp9_14, udp8_19, udp9_42, udp9_24;

	UserDatagramProtocol(PApplet p, String ip) {
		processing = p;
		this.ip = ip;
		udp9_22 = new UDP(this, 9022);
		udp9_14 = new UDP(this, 9014);
		udp8_19 = new UDP(this, 8019);
		udp9_42 = new UDP(this, 9042);
		udp9_24 = new UDP(this, 9024);
	}

	public void writePortThrusterAngle(String angle) {
		udp9_22.send(angle, ip, 9022);
	}

	public void writeStbdThrusterAngle(String angle) {
		udp9_14.send(angle, ip, 9014);
	}

	public void writeCameraPanAngle(String angle) {
		udp8_19.send(angle, ip, 8019);
	}

	public void writeCameraTiltAngle(String angle) {
		udp9_42.send(angle, ip, 9042);
	}

	public void writeThrusterPower(String packet) {
		udp9_24.send(packet, ip, 9024);
	}

}
