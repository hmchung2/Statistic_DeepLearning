import java.io.*;
import java.net.*;
public class DataGramClient {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		byte[] b = new byte[256];
		String host = "localhost";
		String send = null;
		DatagramPacket packet = null;
		BufferedReader in;
		try {
		
			DatagramSocket socket = new DatagramSocket();
			InetAddress address = InetAddress.getByName(host);
			in = new BufferedReader(new InputStreamReader(System.in));
			System.out.print("송신: ");
			while((send = in.readLine()) != null ) { //종료시에는 Crtl -Z 입력
				// 문자열을 바이트배열로 전환한 후 포트 1111전송한다
				b = send.getBytes();
			packet = new DatagramPacket(b,b.length,address,1111);
			socket.send(packet);
			//패킷을 수신하여 문자열로 전환한 후 화면에 출력한다.
			packet = new DatagramPacket(b,b.length);
			socket.receive(packet);
			String received = new String(packet.getData());
			System.out.println("수신:" + received);
			System.out.print("송신");
			}
			socket.close();
		
		
		} catch(IOException ex) {
			ex.printStackTrace();
		}
	}

}
