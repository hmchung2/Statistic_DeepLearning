
public class Testing_two {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
	int arry[] = {10,20,30,40,50}, a = 100, b = 0;
	try {
		for(int i = 0; i <= arry.length; i ++)
			System.out.println(arry[i]+ " ");
	} catch(ArrayIndexOutOfBoundsException e) {
		System.out.println("\n0~4 out of bound index");
	}
		try {
		
			int  z = a/b;
			System.out.println(z);
			
		
		}catch (ArithmeticException e) {
			System.out.println("\n cannot be divded by zero");
		}catch (Exception e) {
			System.out.println("wow");
		}finally {
			System.out.println("really");
		}
		
		System.out.println("bye");
	}

}
