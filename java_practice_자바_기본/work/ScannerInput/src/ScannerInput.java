import java.util.Scanner;
import java.math.*;
public class ScannerInput {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
int sno;
String sname;
double sweight;
Scanner scan = new Scanner(System.in);
System.out.print("��ǰ��ȣ: " );
sno = scan.nextInt();
System.out.print("���ĸ� : ");
sname = scan.next();
System.out.print("����: ");
sweight = scan.nextDouble();
System.out.println(" ��ǰ��: " + sname + ", ��ǰ��ȣ: " + sno + ", ���� :" +sweight + "kg");
double d = 2.2- 2.2;
System.out.print(Math.abs(2.2-2.2) < 0.00001);	
	}

}
