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
			System.out.print("�۽�: ");
			while((send = in.readLine()) != null ) { //����ÿ��� Crtl -Z �Է�
				// ���ڿ��� ����Ʈ�迭�� ��ȯ�� �� ��Ʈ 1111�����Ѵ�
				b = send.getBytes();
			packet = new DatagramPacket(b,b.length,address,1111);
			socket.send(packet);
			//��Ŷ�� �����Ͽ� ���ڿ��� ��ȯ�� �� ȭ�鿡 ����Ѵ�.
			packet = new DatagramPacket(b,b.length);
			socket.receive(packet);
			String received = new String(packet.getData());
			System.out.println("����:" + received);
			System.out.print("�۽�");
			}
			socket.close();
		
		
		} catch(IOException ex) {
			ex.printStackTrace();
		}
	}

}
