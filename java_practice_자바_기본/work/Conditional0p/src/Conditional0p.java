import java.util.*;
public class Conditional0p {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
int gender, a,b, max,min;
System.out.println("����� ������? (0:����/1 :����)" );
Scanner scan = new Scanner(System.in);
gender = scan.nextInt();
String genderstr = (gender  == 0) ? "����" : "����";

System.out.println(genderstr + "�Դϴ�" );
System.out.println("�ΰ��� ������ �Է��ϼ���..");
a= scan.nextInt();
b = scan.nextInt();
max = (a > b) ? a : b;
min= ( a <b) ? a : b;
System.out.println("ū     ��: "    + max + "\n������:" + min);

	}

}
