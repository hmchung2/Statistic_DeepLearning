import java.util.Scanner;
public class DatatypeVariable {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		float diameter;
		int pointx = 0, pointy = 100, weight;
		char gender = 'M';
		boolean dataend = false;
		System.out.println("���Ը� �Է��ϼ��� ..");
		Scanner scn = new Scanner(System.in);
		weight = scn.nextInt();
		System.out.println("diameter ..");
		diameter = scn.nextFloat();
		System.out.println("dataend ..");
		dataend = scn.nextBoolean(); 
		
		System.out.println("���� :" + diameter + "cm"  );
		System.out.println(", ���� : " + weight + "kg");
		System.out.println(" , ���� : " + gender);
		System.out.println(", ��ǥ(" + pointx + ", "+ pointy + ")");
		System.out.println(" , ������ �� : " + dataend);	
	}
}