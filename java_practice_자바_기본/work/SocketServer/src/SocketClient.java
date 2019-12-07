import java.io.*;
import java.net.*;

public class SocketClient {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Socket sc;
		BufferedReader in, stdin;
		PrintWriter out;
		String inLine = null;
		String host = "localhost";
		try {
			sc = new Socket(host,1113);
			out = new PrintWriter(sc.getOutputStream(),true);
			in = new BufferedReader(new InputStreamReader(sc.getInputStream()));
			stdin = new BufferedReader(new InputStreamReader(System.in));
			System.out.print("�۽�: ");
		
			while((inLine = stdin.readLine()) != null) {
				out.println(inLine);
				System.out.println("����: " + in.readLine());
				System.out.print("�۽�");
			}
		in.close();
		out.close();
		
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}

}
