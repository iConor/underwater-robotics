
import java.io.UnsupportedEncodingException;

import processing.core.PApplet;
import hypermedia.net.*;

public class Node_udp {
	
	UDP udp;
	String beaglebone_ip;
	String host_ip;
	
	
	
	public Node_udp(String ip_destination, String ip_host) {
		beaglebone_ip = ip_destination;
		host_ip = ip_host;
		udp = new UDP(this);
	}
	
	public void sendPacket(String message, int port) {
		udp.send(message, beaglebone_ip, port);
		
	}
	
	public void sendPacket(byte[] message, int port) {
		udp.send(message, beaglebone_ip, port);
	}
	
	/*public void sendSerialPacket(int port) {
		udp.send(serialPacket, beaglebone_ip, port);
	}*/
	
	
	public void recievePacket( int port) {
		//do stuff in here to receive packets
	}
	
	String sabretoothPacket(int address, int command, float power) {

		if (power < 0) {
			power *= -1;
			command += 1;
		}
		int speed = (int) (power * 127.0f);
		int checksum = (speed + address + command) & 127;
		byte[] packet = {(byte) address, (byte) command, (byte) speed, (byte) checksum};
		String out = "";
		try {
			out = new String(packet, "US-ASCII");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return out;
		
	}
}
