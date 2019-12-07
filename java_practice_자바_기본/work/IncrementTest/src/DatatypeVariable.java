import java.util.Scanner;
public class DatatypeVariable {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		float diameter;
		int pointx = 0, pointy = 100, weight;
		char gender = 'M';
		boolean dataend = false;
		System.out.println("무게를 입력하세요 ..");
		Scanner scn = new Scanner(System.in);
		weight = scn.nextInt();
		System.out.println("diameter ..");
		diameter = scn.nextFloat();
		System.out.println("dataend ..");
		dataend = scn.nextBoolean(); 
		
		System.out.println("지름 :" + diameter + "cm"  );
		System.out.println(", 무게 : " + weight + "kg");
		System.out.println(" , 성별 : " + gender);
		System.out.println(", 좌표(" + pointx + ", "+ pointy + ")");
		System.out.println(" , 데이터 끝 : " + dataend);	
	}
}