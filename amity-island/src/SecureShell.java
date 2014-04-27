import java.io.*;

import com.jcraft.jsch.*;

public class SecureShell {
	
	RobotModel robot;

	JSch jsch_ssh_connection;
	Session jsch_session;
	Channel session_channel;
	InputStream channel_input;
	OutputStream channel_output;
	PrintStream bbb_terminal;

	public SecureShell(String username, String host, RobotModel bot)
			throws JSchException, IOException {

		robot = bot;

		jsch_ssh_connection = new JSch();

		jsch_session = jsch_ssh_connection.getSession(username, host);
		UserInfo userinfo = new MyUserInfo();
		jsch_session.setUserInfo(userinfo);
		jsch_session.setPassword("");
		jsch_session.connect();

		session_channel = jsch_session.openChannel("shell");
		session_channel.connect();

		channel_input = session_channel.getInputStream();
		channel_output = session_channel.getOutputStream();

		bbb_terminal = new PrintStream(channel_output, true);

		System.out.println("Constructor, check.");
		
	}

	public void configure() throws InterruptedException, IOException {

		bbb_terminal.println("cd beaglebash");

		Thread.sleep(60);

		byte[] tmp = new byte[1024];
		while (channel_input.available() > 0) {
			int i = channel_input.read(tmp, 0, 1024);
			if (i < 0) {
				continue;
			}
			System.out.print(new String(tmp, 0, i));
		}

		bbb_terminal.println("./setup-all");

		Thread.sleep(60);

		tmp = new byte[1024];
		while (channel_input.available() > 0) {
			int i = channel_input.read(tmp, 0, 1024);
			if (i < 0) {
				continue;
			}
			System.out.print(new String(tmp, 0, i));
		}

		System.out.println("Configure, check.");

	}

	public void transceive(String port, String stbd, String aft)
			throws IOException, InterruptedException {

		bbb_terminal.println("./serial-write 1 " + port);
		bbb_terminal.println("./serial-write 1 " + stbd);
		bbb_terminal.println("./serial-write 1 " + aft);
		bbb_terminal
				.println("./pwm-write 9_22 20" /* + robot.getPortThrusterAngle()*/);
		bbb_terminal
				.println("./pwm-write 9_14 20" /* + robot.getStbdThrusterAngle()*/);

		Thread.sleep(60);

		byte[] tmp = new byte[1024];
		while (channel_input.available() > 0) {
			int i = channel_input.read(tmp, 0, 1024);
			if (i < 0) {
				continue;
			}
			System.out.print(new String(tmp, 0, i));
		}

	}

	public void close() throws IOException {

		bbb_terminal.close();

		channel_output.close();
		channel_input.close();

		session_channel.disconnect();
		jsch_session.disconnect();

	}

	public static class MyUserInfo implements UserInfo {
		@Override
		public String getPassword() {
			return null;
		}

		@Override
		public boolean promptYesNo(String str) {
			return true;
		}

		@Override
		public String getPassphrase() {
			return null;
		}

		@Override
		public boolean promptPassphrase(String message) {
			return true;
		}

		@Override
		public boolean promptPassword(String message) {
			return true;
		}

		@Override
		public void showMessage(String message) {
		}
	}

}
