import java.util.*;
public class MethodOverloading {
	
	public static int hapnumber(int a, int b)
    { 
           return (a + b);
    }
	
	public static int hapnumber(int a, int b, int c)
    {
           return (a + b + c);
    }
	
	public static float hapnumber(float aa, float bb) 
    {
            return (aa + bb);
    } 

	
	public static void main(String[] args) {
		int hap1, hap2;
		float hap3;
		
		hap1 = hapnumber(2, 3);
		hap2 = hapnumber(1,2,3);
		hap3 = hapnumber(1.1f, 2.2f);
		
		System.out.println("hap1=" +hap1 + " hap2="+ hap2 + " hap3 = " + hap3);
	}

}
