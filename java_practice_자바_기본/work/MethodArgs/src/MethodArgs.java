
public class MethodArgs {
  
	public static void callOne(int x ,Person y) 
	{
		System.out.print( "\ncallOne() �Ű����� ------- x: "+x+" "+y.toString());
		x = 80;
		y.setName("�Ӳ���");
		y.setAge(20);
		System.out.print( "callOne() ���� ----------x" + x+ " "+ y.toString());
		
		
		
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Person person = new Person("ȫ�浿", 23);
		int score = 70;
		System.out.print("�޼ҵ� ȣ�� ��  main() - score:" + score + " " + person.toString()) ;
		callOne(score,person);
		System.out.print("\n�޼ҵ� ȣ�� �� main() - score:" + score + " "+ person.toString());

	}

}
