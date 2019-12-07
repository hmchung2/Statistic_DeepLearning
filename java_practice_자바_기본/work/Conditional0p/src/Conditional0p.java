import java.util.*;
public class Conditional0p {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
int gender, a,b, max,min;
System.out.println("당신의 성별은? (0:남자/1 :여자)" );
Scanner scan = new Scanner(System.in);
gender = scan.nextInt();
String genderstr = (gender  == 0) ? "남자" : "여자";

System.out.println(genderstr + "입니다" );
System.out.println("두개의 정수를 입력하세요..");
a= scan.nextInt();
b = scan.nextInt();
max = (a > b) ? a : b;
min= ( a <b) ? a : b;
System.out.println("큰     값: "    + max + "\n잡은값:" + min);

	}

}
