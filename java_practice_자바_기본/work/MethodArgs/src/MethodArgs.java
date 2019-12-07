
public class MethodArgs {
  
	public static void callOne(int x ,Person y) 
	{
		System.out.print( "\ncallOne() 매개변수 ------- x: "+x+" "+y.toString());
		x = 80;
		y.setName("임꺽정");
		y.setAge(20);
		System.out.print( "callOne() 수행 ----------x" + x+ " "+ y.toString());
		
		
		
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Person person = new Person("홍길동", 23);
		int score = 70;
		System.out.print("메소드 호출 전  main() - score:" + score + " " + person.toString()) ;
		callOne(score,person);
		System.out.print("\n메소드 호출 후 main() - score:" + score + " "+ person.toString());

	}

}
