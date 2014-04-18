import java.io.*;

import com.jcraft.jsch.*;

public class SecureShell {

	JSch jsch_ssh_connection;
	Session jsch_session;
	Channel session_channel;
	InputStream channel_input;
	OutputStream channel_output;
	PrintStream bbb_terminal;

	public SecureShell(String username, String host) throws JSchException,
			IOException {

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

	public void configure() {

		bbb_terminal.println("cd beaglebash");
		bbb_terminal.println("./setup-all");

		System.out.println("Configure, check.");

	}

	public void transceive(String arg) throws IOException {

		bbb_terminal.println("./update-all " + arg);

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
