import java.io.*;
import java.net.*;

public class URLConnectionExample {

	public static void main(String[] args) throws Exception{
		URL url = new URL("https://www.naver.com/");
		System.out.println(url.getHost()+ "ÀÇ ³»¿ë: \n");
		URLConnection con = url.openConnection();
		InputStream is = con.getInputStream();
		int ch;
		while((ch=is.read()) != -1) {
			
			System.out.print((char) ch);
		}
		System.out.println();
	}
}
