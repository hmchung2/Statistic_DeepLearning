import java.io.*;
import java.net.*;

public class SocketServer {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
        ServerSocket ss;
		Socket sc;
		BufferedReader in, stdin;
		PrintWriter out;
		String inLine = null;
		String host = "localhost";
		try {
			 ss = new ServerSocket(1113);
			sc = ss.accept();
			
			while(true){
			in = new BufferedReader(new InputStreamReader(sc.getInputStream()));
			out = new PrintWriter(sc.getOutputStream(), true);
			
			inLine = in.readLine();
			if(inLine == null)
				break;
			System.out.println("수신" + inLine);
			out.println(inLine);
			System.out.println("송신" + inLine);
		}
	}catch(IOException ex) {
		ex.printStackTrace();
	}
	}
}
