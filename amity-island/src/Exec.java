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
import java.util.Scanner;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.UIKeyboardInteractive;
import com.jcraft.jsch.UserInfo;

public class Exec {

    // Global SSH Data
    static Session session = null;
    static Channel channel = null;
    static InputStream input = null;
    static OutputStream output = null;
    static PrintStream ps = null;

    public static void main(String[] arg) {
        try {
            JSch jsch = new JSch();

            // String user = "leean";
            // String host = "stdlinux.cse.ohio-state.edu";

            String user = "root";
            String host = "192.168.1.73";

            // Get Session (str User, str host, int port)
            session = jsch.getSession(user, host, 22);

            // username and password will be given via UserInfo interface.
            UserInfo ui = new MyUserInfo();
            session.setUserInfo(ui);
            session.setPassword("NeedAPasswordToMakeItWork");
            session.connect();

            // TODO Commands
            channel = null;
            int quit = 0;

            String command = "ls";

            // Input stuff
            Scanner input = new Scanner(System.in);

            channel = session.openChannel("shell");
            output = channel.getOutputStream();
            ps = new PrintStream(output, true);

            channel.connect();
            ps.println("cd beaglebash");
            ps.println("./pwm-write 9_14 0");
            Thread.sleep(1000);

            InputStream in = channel.getInputStream();

            long begin = System.currentTimeMillis();
            long end2 = System.currentTimeMillis();
            while (end2 - begin < 300000) {
                while (quit < 180) {

                    long start = System.currentTimeMillis();
                    ps.println("./pwm-write 9_14 " + quit);

                    byte[] tmp = new byte[1024];
                    while (in.available() > 0) {
                        int i = in.read(tmp, 0, 1024);
                        if (i < 0) {
                            break;
                        }
                        System.out.print(new String(tmp, 0, i));
                    }
                    if (channel.isClosed()) {
                        if (in.available() > 0) {
                            continue;
                        }
                        System.out.println("exit-status: "
                                + channel.getExitStatus());
                        break;
                    }

                    quit++;
                    long end = System.currentTimeMillis();
                    Thread.sleep(32);
                    System.out.println("Time (ms): " + (end - start));
                }

                while (quit >= 0) {

                    long start = System.currentTimeMillis();
                    ps.println("./pwm-write 9_14 " + quit);

                    byte[] tmp = new byte[1024];
                    while (in.available() > 0) {
                        int i = in.read(tmp, 0, 1024);
                        if (i < 0) {
                            break;
                        }
                        System.out.print(new String(tmp, 0, i));
                    }
                    if (channel.isClosed()) {
                        if (in.available() > 0) {
                            continue;
                        }
                        System.out.println("exit-status: "
                                + channel.getExitStatus());
                        break;
                    }

                    quit--;
                    long end = System.currentTimeMillis();
                    Thread.sleep(32);
                    System.out.println("Time (ms): " + (end - start));
                }
                end2 = System.currentTimeMillis();
            }

            ps.close();
            channel.disconnect();

            // while (quit < 90) {
            //
            // // System.out.println("Command: ");
            // // command = input.nextLine();
            // // if (command == "abort") {
            // // abort = true;
            // // }
            //
            // command = "cd beaglebash; ./pwm-write 9_14 " + quit * 2;
            //
            // long start = System.currentTimeMillis();
            // channel = session.openChannel("exec");
            // ((ChannelExec) channel).setCommand(command);
            //
            // // channel.setInputStream(null);
            //
            // // ((ChannelExec) channel).setErrStream(System.err);
            //
            // InputStream in = channel.getInputStream();
            //
            // channel.connect();
            //
            // // byte[] tmp = new byte[1024];
            // // while (true) {
            // // // while (in.available() > 0) {
            // // // int i = in.read(tmp, 0, 1024);
            // // // if (i < 0) {
            // // // break;
            // // // }
            // // // System.out.print(new String(tmp, 0, i));
            // // // }
            // // if (channel.isClosed()) {
            // // if (in.available() > 0) {
            // // continue;
            // // }
            // // // System.out.println("exit-status: "
            // // // + channel.getExitStatus());
            // // break;
            // // }
            // // long end = System.currentTimeMillis();
            // // // System.out.println("Time (ms): " + (end - start));
            // //
            // // }
            // // Thread.sleep(1000);
            // quit++;
            // long end = System.currentTimeMillis();
            // System.out.println("Time (ms): " + (end - start));
            // channel.disconnect();
            // }

            session.disconnect();
        } catch (Exception e) {
            System.out.println("Boogity");
        }

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
