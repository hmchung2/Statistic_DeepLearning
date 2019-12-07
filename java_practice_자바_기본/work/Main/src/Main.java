import java.util.Scanner;
public class Main {

	public static void main(String[] args) {
		int a;
		a = -1;
		Scanner scan = new Scanner(System.in);
		while(a >= 4000 | a <= 1  ) {
		a = scan.nextInt();
		}
	if(a%400 == 0)
	{
		System.out.print(1);
	}
	else if(a%4 == 0 & a%100 != 0 )
	{
		System.out.print(1);
	}
	else {System.out.print(0);}
	}
}