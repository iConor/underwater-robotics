/* -*-mode:java; c-basic-offset:2; indent-tabs-mode:nil -*- */


/**
 * This program will demonstrate remote exec.
 *  $ CLASSPATH=.:../build javac Exec.java 
 *  $ CLASSPATH=.:../build java Exec
 * You will be asked username, hostname, displayname, passwd and command.
 * If everything works fine, given command will be invoked 
 * on the remote side and outputs will be printed out.
 *
 */

import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;


import com.jcraft.jsch.Channel;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.UIKeyboardInteractive;
import com.jcraft.jsch.UserInfo;

public class ssh_comunications {

    // Global SSH Data
    static Session session = null;
    static Channel channel = null;
    static InputStream input = null;
    static OutputStream output = null;
    static PrintStream ps = null;
    public String host = "192.168.7.2";
    
    public ssh_comunications(String ip) {
    	host = ip;
    	//setupBB();
    	System.out.println("it calls this function");
    	
    }

    public int setupBB() {
    	System.out.println("yeahhhh");
        try {
            JSch jsch = new JSch();

            // Connection Information
            String user = "root";
            //String host = "192.168.1.73";

            // Get Session (str User, str host, int port)
            session = jsch.getSession(user, host, 22);

            // username and password will be given via UserInfo interface.
            UserInfo ui = new MyUserInfo();
            session.setUserInfo(ui);
            session.setPassword("NeedAPasswordToMakeItWork");
            session.connect();

            channel = session.openChannel("shell");

            output = channel.getOutputStream();
            ps = new PrintStream(output, true);

            channel.connect();
            input = channel.getInputStream();

            ps.println("cd beaglebash");
            ps.println("./setup-all");

        } catch (Exception e) {
            System.out.println("Failed to setup SSH");
            //return 1;
        }
        return 0;
    }

    public int main(String arg) {
        try {
            // Setup SSH
            if (setupBB() == 1) {
                System.exit(0);
            } else {
                System.out.println("Successfully Configured.");
            }

            long start = System.currentTimeMillis();
            ps.println("./update-all " + arg);

            byte[] tmp = new byte[1024];
            while (input.available() > 0) {
                int i = input.read(tmp, 0, 1024);
                if (i < 0) {
                    break;
                }
                System.out.print(new String(tmp, 0, i));
            }

            if (channel.isClosed()) {
                System.out.println("exit-status: " + channel.getExitStatus());
            }

            long end = System.currentTimeMillis();
            Thread.sleep(32);
            System.out.println("Time (ms): " + (end - start));

            ps.close();
            channel.disconnect();
            session.disconnect();
            System.out.println("Disconnected.");

        } catch (Exception e) {
            System.out.println("Massive Error.");
            System.out.println("Just Kidding.");
            System.out.println("Connection Ended.");
            return -1;
        }
        return 0;
    }

    public static class MyUserInfo implements UserInfo, UIKeyboardInteractive {
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

        @Override
        public String[] promptKeyboardInteractive(String destination,
                String name, String instruction, String[] prompt, boolean[] echo) {
            return null;
        }
    }
}
