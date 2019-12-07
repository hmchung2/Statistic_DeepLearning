import java.io.*;
import java.net.*;
public class URLExample {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub

		URL url = new URL("http://www.google.co.kr");
		System.out.println(url.getHost() + " ÀÇ ³»¿ë: \n");
		InputStream is = url.openStream();
		int ch;
		while ((ch=is.read())!= -1) {
			System.out.print((char)ch);
		}
	System.out.println();
	}
}
