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
		
		udp9_22.listen(true);
		udp9_14.listen(true);
		udp8_19.listen(true);
		udp9_42.listen(true);
		udp9_24.listen(true);
	}

	public void writePortThrusterAngle(String angle) {
		udp9_22.send(angle, ip, udp9_22.port());
	}

	public void writeStbdThrusterAngle(String angle) {
		udp9_14.send(angle, ip, udp9_14.port());
	}

	public void writeCameraPanAngle(String angle) {
		udp8_19.send(angle, ip, udp8_19.port());
	}

	public void writeCameraTiltAngle(String angle) {
		udp9_42.send(angle, ip, udp9_42.port());
	}

	public void writeThrusterPower(String packet) {
		udp9_24.send(packet, ip, udp9_24.port());
	}
	
	public void receive( byte[] data, String ip, int port){
		if( port == udp9_24.port()){ // replace with an un-sabretoothing
			int address = data[0]&129;
			int command = data[1];
			int speed = data[2];
			if( address == 128){
				if(command == 1 || command == 5){
					speed *= -1;
					command -= 1;
				}
				if ( command == 4 ){
					System.out.println("port " + speed);
				} else {
					System.out.println("stbd " + speed);
				}
				
			} else { //aft
				if(command == 1 || command == 5) {
					speed *= -1;
				}
				System.out.println("aft " + speed);
			}
		} else {
			if(port == 9022){
				System.out.print("port angle ");
			} else
			if( port == 9014 ) {
				System.out.print("stbd angle ");
			} else if (port == 8019){
				System.out.print("pan angle ");
			} else { //port == 9042
				System.out.print("titl angle ");
			}
			System.out.println(getPWM(data));
		}
	}
	
	private int getPWM(byte[] ascii){
		StringBuilder builder = new StringBuilder();
		for(int i = 0; i < ascii.length; i++){
			builder.append(Integer.toString(ascii[i]-48));
		}
		return Integer.parseInt(builder.toString());
	}
}
