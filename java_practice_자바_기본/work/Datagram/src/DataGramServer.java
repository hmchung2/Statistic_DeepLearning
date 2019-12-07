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
				// ��Ŷ�� �޾Ƽ� �����͸� ���ڿ��� ����
				socket.receive(packet);
				String received = new String(packet.getData());
				//�����͸� ����Ʈ�迭�� ��ȯ�Ͽ� ��Ŷ���� �ٽ� ����
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
