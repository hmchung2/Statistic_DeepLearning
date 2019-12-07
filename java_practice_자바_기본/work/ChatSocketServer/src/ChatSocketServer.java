import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;


public class ChatSocketServer {

	public static void main(String[] args) {
		ServerSocket ss;
		Socket sc;
		BufferedReader in, stdin; //서버로의 립력
		PrintWriter out; // 클라이어튼로의 출력
		String inLine = null;
		try {
			ss = new ServerSocket(1111);
			sc = ss.accept();
			while(true) {
				in = new BufferedReader(new InputStreamReader(sc.getInputStream()));
				out = new PrintWriter(sc.getOutputStream(),true);
				stdin = new BufferedReader(new InputStreamReader(System.in));
				inLine = in.readLine();
				if(inLine == null)
					break;
				if(inLine.equals("안녕하세요")) {
					out.println("어서오세요");
				}
				else {
					System.out.println("수신" + inLine);
					out.println(inLine);
					System.out.println("송신" + inLine);
				}			
			}
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}
}
