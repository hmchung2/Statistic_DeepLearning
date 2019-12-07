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
		BufferedReader in, stdin; //�������� ����
		PrintWriter out; // Ŭ���̾�ư���� ���
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
				if(inLine.equals("�ȳ��ϼ���")) {
					out.println("�������");
				}
				else {
					System.out.println("����" + inLine);
					out.println(inLine);
					System.out.println("�۽�" + inLine);
				}			
			}
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}
}
