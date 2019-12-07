import java.io.*;
import java.net.*;
public class DataGramServer {

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		DatagramPacket packet = null;
		byte[] b  = new byte[256];
		try {
			DatagramSocket socket = new DatagramSocket(1111);
			while(true) {
				packet = new DatagramPacket(b,b.length);
				// 패킷을 받아서 데이터를 문자열에 넣음
				socket.receive(packet);
				String received = new String(packet.getData());
				//데이터를 바이트배열로 전환하여 패킷으로 다시 보냄
				InetAddress address = packet.getAddress();
				int port = packet.getPort();
				b = received.getBytes();
				packet = new DatagramPacket(b,b.length,address, port);
				socket.send(packet);
			} 
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}

}
