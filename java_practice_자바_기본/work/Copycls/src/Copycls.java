import java.io.*;
public class Copycls {

	private InputStream in;
	private OutputStream out;
	private byte [ ]b;
	public Copycls(InputStream in, OutputStream out) {
		this(in, out, 1024);
	}
	public Copycls(InputStream in, OutputStream out, int size) {
		this.in = in;
		this.out = out;
		b = new byte[size];
	}
	
	public void Copy()throwsIOException
	{
		int dbyte = 0;
		while((dbyte = in.read(b)) != -1)
		{
			out.write(b,0,dbyte);
		}
		in.close();
		out.close();
	}
}
