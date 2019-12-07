import java.io.*;
public class FinallyTest {
	static FileReader fr;
	static BufferedReader br;
	static boolean fileyn = true;
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		try {
			String str = "";
			fr = new FileReader(args[0]);
			br = new BufferedReader(fr);
			while((str = br.readLine())!=null)
				System.out.println(str);
		} catch(FileNotFoundException e) {
			System.out.println("no file found. \n" + e.toString());
			fileyn = false;
		} catch(ArrayIndexOutOfBoundsException e) {
			System.out.println("Magae variable: did not define the name of the file. \n" + e.toString());
			fileyn = false;
		}
		finally {
			if(fileyn == true) {
				fr.close();
				br.close();
				System.out.println("\n closing file");
			}
			System.out.println("\n finally operating \n operation done");
		}
	}
}
