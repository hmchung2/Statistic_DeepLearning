
package repeating;
import java.util.*;
public class Rock_Paper_Sic {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
String winner = "computer";
int comHand, yourHand;

Random rand = new Random();
Scanner input = new Scanner(System.in);
yourHand = input.nextInt();
while (winner != "���") {
	comHand = rand.nextInt(3) + 1;
	System.out.print("Input Rock:1 Scissor:2 Paper:3");
	yourHand = input.nextInt();
	while (yourHand > 3 || yourHand < 1) {
		System.out.println("Input Rock : 1 Scissor : 2 Paper : 3");
		yourHand = input.nextInt();	
	}
if(comHand == yourHand){
	System.out.println("tie");
	continue;
}
else if(comHand == 1 && yourHand == 2 ){
	System.out.println("You lost, ��ǻ�ʹ� �ָ��� �½��ϴ�");	
continue;
}	
else if(comHand ==2 && yourHand == 3) {
	System.out.println("You lost, ��ǻ�ʹ� ������ �½��ϴ�");
continue;
}	
else if(comHand ==3 && yourHand == 1) {
	System.out.println("You lost, ��ǻ�ʹ� ���ڱ⸦ �½��ϴ�");
continue;
}	
else {
	System.out.println("you won");
	winner = "���";
	yourHand = yourHand;
	break;
}
}
System.out.println(winner);
System.out.println(yourHand);
	}
}





